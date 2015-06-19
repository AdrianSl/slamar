class DriverDecorator < Draper::Decorator
  delegate :name, :surname

  def full_name
    name + " " +surname
  end

end
