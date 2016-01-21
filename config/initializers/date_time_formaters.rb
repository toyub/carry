#date time formaters
#defaults(activesupport/lib/active_support/core_ext/time/conversions.rb):
#DATE_FORMATS = {
#   :db           => '%Y-%m-%d %H:%M:%S',
#   :number       => '%Y%m%d%H%M%S',
#   :nsec         => '%Y%m%d%H%M%S%9N',
#   :time         => '%H:%M',
#   :short        => '%d %b %H:%M',
#   :long         => '%B %d, %Y %H:%M',
#   :long_ordinal => lambda { |time|
#     day_format = ActiveSupport::Inflector.ordinalize(time.day)
#     time.strftime("%B #{day_format}, %Y %H:%M")
#   },
#   :rfc822       => lambda { |time|
#     offset_format = time.formatted_offset(false)
#     time.strftime("%a, %d %b %Y %H:%M:%S #{offset_format}")
#   },
#   :iso8601      => lambda { |time| time.iso8601 }
# }

Time::DATE_FORMATS.merge!(
  date_only: lambda {|time| I18n.l time, format: :date_only},
  date_with_short_time: lambda {|time| I18n.l time, format: :date_with_short_time},
  short_date: lambda {|time| time.strftime("%Y-%m-%d") }
)
