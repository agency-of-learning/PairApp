json.extract! pair_request, :id, :author_id, :acceptor_id, :when, :duration, :created_at, :updated_at
json.url pair_request_url(pair_request, format: :json)
