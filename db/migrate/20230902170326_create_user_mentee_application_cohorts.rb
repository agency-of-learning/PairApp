class CreateUserMenteeApplicationCohorts < ActiveRecord::Migration[7.0]
  def change
    create_table :user_mentee_application_cohorts do |t|
      t.daterange :active_date_range, null: false
      t.boolean :active, default: true, null: false
      t.string :name, null: false

      t.timestamps
    end

    add_reference :user_mentee_applications,
      :user_mentee_application_cohort,
      foreign_key: true,
      index: { name: 'idx_user_mentee_applications_on_mentee_application_cohort_id' },
      null: true
  end
end
