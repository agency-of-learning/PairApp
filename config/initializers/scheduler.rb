# NOTE: this is a temporary solution.
# The issue with this is when we run multiple containers there is no real "locking" mechanism
# across them. So we might end up with multiple containers running the same job.
# This is fine for now because these jobs will be idempotent.
# But this is something we should fix in the future.
#

require 'rufus-scheduler'

s = Rufus::Scheduler.singleton

s.every '30m' do
  PairRequest::AutoExpireJob.perform_async
end
