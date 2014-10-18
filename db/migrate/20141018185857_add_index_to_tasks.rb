class AddIndexToTasks < ActiveRecord::Migration
  def change
    add_index :tasks, :context_id
  end
end
