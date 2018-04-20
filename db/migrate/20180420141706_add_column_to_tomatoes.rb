class AddColumnToTomatoes < ActiveRecord::Migration
  def change
    add_column :tomatoes, :user_id, :integer
  end
end
