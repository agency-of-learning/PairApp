class CreateMenteeApplicationStates < ActiveRecord::Migration[7.0]
  def change
    create_table :mentee_application_states do |t|
      t.references :user_mentee_application, null: false, foreign_key: true
      t.integer :status, null: false, default: 0
      t.text :note
      t.references :status_changed, null: true, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
