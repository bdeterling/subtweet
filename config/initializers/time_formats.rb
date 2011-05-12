[Time, Date].map do |klass|
  klass::DATE_FORMATS[:app_date] = "%m/%d/%Y"
  klass::DATE_FORMATS[:app_month_and_year] = "%B %Y"
  klass::DATE_FORMATS[:app_abbrev_month_and_year] = "%b %Y"
  klass::DATE_FORMATS[:app_sort_time] = "%Y%m%d.%H%M"
end
Time::DATE_FORMATS[:app_datetime] = "%m/%d/%Y %H:%M"
Time::DATE_FORMATS[:app_time] = "%I:%M %p"
