class CreateContexts < ActiveRecord::Migration
  def change
    create_table :contexts do |table|
      table.string :name, null: false
      table.boolean :built_in, default: false, null: false
    end
  end
end
