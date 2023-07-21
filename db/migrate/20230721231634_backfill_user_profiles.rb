class BackfillUserProfiles < ActiveRecord::Migration[7.0]
  # prevent locking
  disable_ddl_transaction!

  def up
    User.find_each do |user|
      Profile.create!(user:)
    end
  end
end
