class DashboardPresenter
  def initialize(day)
    @day = day.to_date
  end

  def day
    @day
  end    

  def general_expenses
    @general_expenses = GeneralExpense.day_list(@day).decorate
  end

  def incomes_truck_routes
    @incomes_truck_routes = Income.truck_routes(@day).decorate
  end
  
  def incomes_brand_shops
    @incomes_brand_shops = Income.brand_shops(@day).decorate
  end

  def incomes_external_shops
    @incomes_external_shops = Income.external_shops(@day).decorate
  end

  def drivers
    @drivers = Driver.all.map { |c| ["#{c.name} #{c.surname}", c.id] }
  end

  def general_expense
    @general_expense = GeneralExpense.new
  end

  def last_workdays
    query_dates = Income.last_workdays
    @last_workdays = []
    query_dates.each do |item|
      @last_workdays << { active: chosen_date?(item.date),
                          date_name: name_of_day(item.date),
                          date_value: item.date.to_s(:db) }
    end
    return @last_workdays
  end

  private

  def chosen_date?(any_date)
    any_date == @day.to_date ? true : false
  end

  def name_of_day(any_date)
    if any_date == DateTime.now.to_date
      I18n.l any_date, format: :last_workdays_today
    elsif any_date == (DateTime.now - 1.day).to_date
      I18n.l any_date, format: :last_workdays_yesterday
    else
      I18n.l any_date, format: :last_workdays_other
    end
  end
end
