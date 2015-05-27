class GeneralExpensesController < ApplicationController
  before_action :logged_in_user
  
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

  def general_expense_params
    params.require(:general_expense).permit(:name, :value, :date)
  end
end
