class TestingComments < ActiveRecord::Migration[7.0]
  def change
     create_table :standup_meeting_comments do |t|
      t.references :action_text_rich_text, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
