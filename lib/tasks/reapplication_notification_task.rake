class NoActiveCohortError < StandardError; end

task enqueue_reapplication_notifications: :environment do
  active_cohort = Admin::UserMenteeApplicationCohort.active
  raise NoActiveCohortError if active_cohort.blank?

  # Currently, looking at last 2 inactive cohorts
  previous_cohorts_to_cull = Admin::UserMenteeApplicationCohort.inactive.last(2).pluck(:id)
  # Gather users from previous cohort cycles who are still applicants
  users = UserMenteeApplication.includes(:user).where(
    user_mentee_application_cohort_id: previous_cohorts_to_cull,
    user: { role: User.roles[:applicant] }
  ).map(&:user)

  users.each do |user|
    MenteeApplication::ReapplicationNotification.with(active_cohort_name: active_cohort.name)
                                                .deliver(user)
    puts "Reapplication Notification enqueued for: #{user.full_name}"
  end
end
