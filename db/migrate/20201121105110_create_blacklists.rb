class CreateBlacklists < ActiveRecord::Migration[6.0]
  def change
    create_table :blacklists do |t|
      t.boolean :blocked, default: true
      t.integer :user_id
      t.integer :category_id
      t.string  :title

      t.timestamps
    end
  end
end
