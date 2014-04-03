class RemoveWishedProductsForDeletedVariants < ActiveRecord::Migration
  def up
    Spree::WishedProduct.includes(:variant).find_each do |wished_product|
      wished_product.destroy if !wished_product.variant
    end
  end

  def down
  end
end
