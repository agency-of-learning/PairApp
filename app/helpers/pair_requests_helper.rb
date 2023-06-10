module PairRequestsHelper
  def format_date(pair_request)
    pair_request.when.strftime('%B %-e, %Y %-l:%M%P')
  end
end
