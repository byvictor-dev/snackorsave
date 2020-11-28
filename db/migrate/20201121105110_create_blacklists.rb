class CreateBlacklists < ActiveRecord::Migration[6.0]
  def change
    create_table :blacklists do |t|
      t.boolean :blocked, default: true
      t.integer :user_id
      t.string  :category
      t.string  :title

      t.timestamps
    end
  end
end
