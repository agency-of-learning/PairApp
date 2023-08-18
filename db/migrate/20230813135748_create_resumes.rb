class CreateResumes < ActiveRecord::Migration[7.0]
  def change
    create_table :resumes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.boolean :current

      t.timestamps
    end
  end
end
