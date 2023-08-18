class CreateUserMenteeApplication < ActiveRecord::Migration[7.0]
  def change
    create_table :user_mentee_applications do |t|
      t.references :user, null: false, foreign_key: true, index: true

      t.string :city, null: false
      t.string :state, null: false
      t.string :country, null: false

      t.text :reason_for_applying, null: false
      t.string :linkedin_url
      t.string :github_url

      t.text :learned_to_code, null: false
      t.text :project_experience, null: false
      t.integer :available_hours_per_week, null: false
      t.string :referral_source
      t.text :additional_information

      t.timestamps
    end
  end
end
