class AddToIdToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :to_id, :integer, default: 0
  end
end
