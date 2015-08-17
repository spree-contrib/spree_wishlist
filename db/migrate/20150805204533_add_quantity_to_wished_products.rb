class AddQuantityToWishedProducts < ActiveRecord::Migration
  def change
    add_column :spree_wished_products, :quantity, :integer, null: false, default: 1
  end
end
