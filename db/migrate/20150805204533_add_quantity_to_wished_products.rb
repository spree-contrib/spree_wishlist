class AddQuantityToWishedProducts < SpreeExtension::Migration[4.2]
  def change
    add_column :spree_wished_products, :quantity, :integer, null: false, default: 1
  end
end
