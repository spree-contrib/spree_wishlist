class RemoveWishedProductsForDeletedVariants < SpreeExtension::Migration[4.2]
  def up
    Spree::WishedProduct.includes(:variant).find_each do |wished_product|
      wished_product.destroy unless wished_product.variant
    end
  end

  def down
  end
end
