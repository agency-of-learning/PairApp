class AddSlugToMenteeApplicationState < ActiveRecord::Migration[7.0]
  def change
    add_column :mentee_application_states, :slug, :string
    add_index :mentee_application_states, [:slug, :user_mentee_application_id], unique: true, name: 'index_on_slug_and_user_mentee_application_id'
  end
end
