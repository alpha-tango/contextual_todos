class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :element, null: false
      t.integer :times, null: false
    end
  end
end
