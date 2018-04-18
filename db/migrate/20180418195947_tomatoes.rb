class Tomatoes < ActiveRecord::Migration
  def change
    create_table :tomatoes do |t|
      t.string :variety
      t.string :growth_type
      t.string :days
      t.string :details
    end
  end
end
