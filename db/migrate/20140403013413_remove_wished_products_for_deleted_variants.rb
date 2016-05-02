class RemoveWishedProductsForDeletedVariants < ActiveRecord::Migration
  def up
    if Object.const_defined?('Spree::WishedProduct')
      Spree::WishedProduct.includes(:variant).find_each do |wished_product|
        wished_product.destroy unless wished_product.variant
      end
    end
  end

  def down
  end
end
