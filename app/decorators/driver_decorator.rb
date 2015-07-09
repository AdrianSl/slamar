class DriverDecorator < Draper::Decorator
  delegate_all

  def full_name
    surname + " " +name
  end

end
