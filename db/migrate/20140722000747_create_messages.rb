class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :content
      t.integer :addresser_id
      t.integer :addressee_id

      t.timestamps
    end
    add_index :messages, [:addressee_id, :addresser_id, :created_at]
  end
end
