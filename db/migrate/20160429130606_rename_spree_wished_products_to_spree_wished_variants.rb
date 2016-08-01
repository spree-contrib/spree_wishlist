class RenameSpreeWishedProductsToSpreeWishedVariants < ActiveRecord::Migration
  def up
    rename_table :spree_wished_products, :spree_wished_variants
  end

  def down
    rename_table :spree_wished_variants, :spree_wished_products
  end
end
