class IncomeDecorator < Draper::Decorator
  include ActionView::Helpers::NumberHelper
  delegate_all
  decorates_association :driver

  def value
    number_with_precision object.value, precision: 2
  end
  def midday_value
    number_with_precision object.midday_value, precision: 2
  end
end
