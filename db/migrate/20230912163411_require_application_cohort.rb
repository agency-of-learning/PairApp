class RequireApplicationCohort < ActiveRecord::Migration[7.0]
  def change
    change_column_null(:user_mentee_applications, :user_mentee_application_cohort_id, false)
  end
end
