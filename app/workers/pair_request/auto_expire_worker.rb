class PairRequest
  class AutoExpireWorker < ApplicationWorker
    sidekiq_options queue: 'low'

    # rubocop:disable Rails/SkipsModelValidations
    def perform
      PairRequest.pending.where('pair_requests.when < ?',
        Time.current).update_all(status: :expired)
    end
    # rubocop:enable Rails/SkipsModelValidations
  end
end
