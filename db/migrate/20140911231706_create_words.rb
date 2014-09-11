class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |table|
      table.string :word, null: false
      table.integer :count, null: false
    end
  end
end
