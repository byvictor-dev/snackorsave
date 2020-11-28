class CreateMerchantCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :merchant_categories do |t|
      t.string :description, null: false
    end
  end
end
