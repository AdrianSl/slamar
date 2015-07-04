module DashboardHelper
  def is_workday_created?(any_date)
    Income.where(date: any_date).count > 0 ? true : false
  end
end
