class RemoveWishedVariantsForDeletedVariants < ActiveRecord::Migration
  def up
    if Object.const_defined?('Spree::WishedVariant')
      Spree::WishedVariant.includes(:variant).find_each do |wished_variant|
        wished_variant.destroy unless wished_variant.variant
      end
    end
  end

  def down
  end
end
