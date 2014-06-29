require 'date'
class Order <ActiveRecord::Base
  BUDGET_TYPES=["Food Budget","Finance Budget","Shopping Budget","Auto Budget","Entertainment Budget","Other Budget"]
  first_day=Date.today.beginning_of_week
  begin_day=first_day.wday
  a=[*1..6]
  a.push(0)
  @days_from_this_week=a.map.each do |d|
    d=Date::DAYNAMES[d]
  end
  @array=[]
  @days_from_this_week1=(Date.today.at_beginning_of_week..Date.today.at_end_of_week)
  

 # prepares options_for_select array for transaction date select box with format of [[1,option1],[2,option2],[3,option3]...]

  @days_from_this_week.zip(@days_from_this_week1).each do |a,b|
    @array2=[]
    c=a.to_s+"("+b.strftime("%m-%d-%Y")+")"
    @array2 << c
    d=b.strftime("%Y-%m-%d").to_s+" 00:00:00"
    e=DateTime.parse(d)
    @array2 << e
    @array << @array2
  end  
  ALERT_SEND_PERIOD=[["send at the end of each day",1],["send at the end of each week",2],["send at the end of each month",3]]
  DAY_OF_WEEK=@array
  RECUR_WEEK_PERIOD=[["Week",1], ["Two Weeks",2], ["Four Weeks",3], ["Daily",4],["Begin of month",5],["End of month"],6]
  RECUR_MONTH_OPTION=["first day of month", "last day of month"]
end