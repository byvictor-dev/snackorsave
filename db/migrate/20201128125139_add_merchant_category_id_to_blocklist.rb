class AddMerchantCategoryIdToBlocklist < ActiveRecord::Migration[6.0]
  def change
    add_reference :blacklists, :merchant_category, foreign_key: true
    remove_column :blacklists, :category_id, :integer
  end
end
