class AddMerchantCategoryIdToBlocklist < ActiveRecord::Migration[6.0]
  def change
    add_reference :blacklists, :merchant_categories, foreign_key: true
  end
end
