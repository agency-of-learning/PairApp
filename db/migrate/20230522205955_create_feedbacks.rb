class CreateFeedbacks < ActiveRecord::Migration[7.0]
  def change
    create_table :feedbacks do |t|
      t.references :author, null: false, foreign_key: {to_table: :users}
      t.references :receiver, null: false, foreign_key: {to_table: :users}
      t.references :referenceable, polymorphic: true, null: false
      t.integer :overall_rating, default: 0, null: false
      t.integer :status, default: 0, null: false
      t.jsonb :data, default: {}, null: false
      t.datetime :locked_at

      t.timestamps
    end
  end
end
