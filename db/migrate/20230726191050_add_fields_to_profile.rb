class AddFieldsToProfile < ActiveRecord::Migration[7.0]
  def up
    add_column :profiles, :location, :string
    add_column :profiles, :job_search_status, :integer, default: 0

    execute <<-SQL
      CREATE TYPE WORK_MODELS_ENUM AS ENUM('onsite', 'hybrid', 'remote');
    SQL
    add_column :profiles, :work_model_preferences, :work_models_enum, array: true
  end

  def down
    remove_column :profiles, :location
    remove_column :profiles, :job_search_status
    remove_column :profiles, :work_model_preferences

    execute <<-SQL
      DROP TYPE WORK_MODELS_ENUM;
    SQL
  end
end
