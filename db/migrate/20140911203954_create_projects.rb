class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |table|
      table.string :name, null: false

      table.timestamps
    end
  end
end
