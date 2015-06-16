class GeneralExpensesController < ApplicationController
  before_action :logged_in_user
  
  def autocomplete_name
    q = "%" + params[:q].downcase + "%"
    items = GeneralExpense.select(:name).order(name: :asc).distinct.limit(8)
    items = items.where("LOWER(name) LIKE ?", q)
    render json: items_to_json(items)
  end
  def new
    @general_expense = GeneralExpense.new
  end
  def create
    @general_expense = current_user.general_expenses.build(general_expense_params)
    if @general_expense.save
      flash[:success] = "Expense added successfully."
      redirect_to root_path
    else
      render 'new'
    end
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