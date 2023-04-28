class AddPairRequestTable < ActiveRecord::Migration[7.0]
  def change
    create_table :pair_requests, force: :cascade do |t|
      t.references "author", null: false, index: true, foreign_key: { to_table: :users }
      t.references "invitee", null: false, index: true, foreign_key: { to_table: :users }
      t.datetime "when", null: false
      t.float "duration", null: false
      t.integer "status", default: 0, null: false

      t.timestamps null: false
    end
  end
end
