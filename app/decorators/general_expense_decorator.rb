class GeneralExpenseDecorator < Draper::Decorator
  include ActionView::Helpers::NumberHelper
  delegate_all

  def value
    number_with_precision object.value, precision: 2
  end
end
