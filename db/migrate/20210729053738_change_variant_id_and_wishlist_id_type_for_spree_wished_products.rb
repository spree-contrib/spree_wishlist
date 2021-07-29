class ChangeVariantIdAndWishlistIdTypeForSpreeWishedProducts < ActiveRecord::Migration[4.2]
  def change
    change_table(:spree_wished_products) do |t|
      t.change :variant_id, :bigint
      t.change :wishlist_id, :bigint
    end
  end
end
