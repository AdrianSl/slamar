class IncomeDecorator < Draper::Decorator
  delegate_all
  decorates_association :driver

end
