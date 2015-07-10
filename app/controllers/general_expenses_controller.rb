class GeneralExpensesController < ApplicationController
  before_action :logged_in_user
  
  def autocomplete_name
    q = "%" + params[:q].downcase + "%"
    items = GeneralExpense.select(:name).distinct.limit(8)
    items = items.where("LOWER(name) LIKE ?", q)
    render json: items_to_json(items)
  end
  def index
    if !params[:from].blank?
      @from = params[:from]
    else 
      @from = (Time.now - 1.month).strftime("%Y-%m-%d")
    end
    if !params[:to].blank?
      @to = params[:to]
    else 
      @to = Time.now.strftime("%Y-%m-%d")
    end
    @general_expenses = GeneralExpense.where(date: @from..@to)
    if !params[:name].blank?
      @name = params[:name]
      q = "%" + @name.downcase + "%"
      @general_expenses = @general_expenses.where("LOWER(name) LIKE ?", q).list
    else
      @name = ""
      @general_expenses = @general_expenses.list
    end
  end
  def new
    @general_expense = GeneralExpense.new
  end
  def create
    @general_expense = current_user.general_expenses.build(general_expense_params)
    if @general_expense.save
      flash[:success] = "Expense added successfully."
      redirect_to dashboard_path(date_to_url(general_expense_params[:date]))
    else
      render 'new'
    end
  end
  def edit
    @general_expense = GeneralExpense.find(params[:id])
  end
  def update
    @general_expense = GeneralExpense.find(params[:id])
    if @general_expense.update_attributes(general_expense_params)
      flash[:success] = "Expense updated successfully."
      redirect_to dashboard_path(date_to_url(general_expense_params[:date]))
    else
      render 'edit'
    end
  end
  def destroy
    general_expense = GeneralExpense.find(params[:id])
    general_expense.destroy
    flash[:success] = "General expense removed successfully."
    redirect_to general_expenses_path
  end

  private

  def items_to_json(items)
    items.collect do |item|
      [item.id.to_s, item.name]
    end
  end
  def general_expense_params
    params.require(:general_expense).permit(:name, :value, :date)
  end
end
