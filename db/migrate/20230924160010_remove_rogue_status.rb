class RemoveRogueStatus < ActiveRecord::Migration[7.0]
  def change
    remove_column :user_mentee_applications, :status if column_exists?(:user_mentee_applications, :status)
  end
end
