class RemoveAddresserIdFromMessages < ActiveRecord::Migration
  def change
    remove_column :messages, :addresser_id, :integer
  end
end
