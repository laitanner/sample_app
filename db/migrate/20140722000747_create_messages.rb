class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :content
      t.integer :addresser_id
      t.integer :addressee_id

      t.timestamps
    end
  end
end
