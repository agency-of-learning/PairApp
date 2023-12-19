class CreateRichTextReactions < ActiveRecord::Migration[7.0]
  def change
    create_table :rich_text_reactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :rich_text, null: false, foreign_key: { to_table: :action_text_rich_texts }
      t.string :emoji_caption, null: false

      t.timestamps
    end
  end
end
