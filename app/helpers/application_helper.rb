module ApplicationHelper
  
  def time_difference(start_date, end_date)
    dates = (start_date.to_date..end_date.to_date).to_a
    return dates.size
  end

end
