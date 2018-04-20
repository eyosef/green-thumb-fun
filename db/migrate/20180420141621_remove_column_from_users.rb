class RemoveColumnFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :tomato_id
  end
end
