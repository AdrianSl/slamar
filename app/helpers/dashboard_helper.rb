module DashboardHelper
  def workday_created?(any_date)
    Income.where(date: any_date).present?
  end
end
