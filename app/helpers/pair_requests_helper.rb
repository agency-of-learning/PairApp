module PairRequestsHelper
  def format_request_date(pair_request)
    start_time = pair_request.when
    end_time = start_time + pair_request.duration

    format_date = start_time.to_fs(:month_day_year)
    format_time = start_time.to_fs(:hour_min_period)
    time_range = "#{format_time} - #{end_time.to_fs(:hour_min_period)}"

    content_tag(:span, format_date) + tag.br + content_tag(:span, time_range)
  end
end
