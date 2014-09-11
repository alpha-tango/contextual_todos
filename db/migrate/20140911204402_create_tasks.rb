class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |table|
      table.string :body, null: false
      table.integer :project_id
      table.integer :context_id
      table.boolean :complete, default: false, null: false

      table.timestamps
    end
  end
end
