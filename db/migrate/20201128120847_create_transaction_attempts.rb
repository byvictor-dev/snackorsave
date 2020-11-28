class CreateTransactionAttempts < ActiveRecord::Migration[6.0]
  def change
    create_table :transaction_attempts do |t|
      t.integer :amount
      t.integer :category_id
      t.integer :user_id
      t.string  :merchant_name

      t.timestamps
    end
  end
end
