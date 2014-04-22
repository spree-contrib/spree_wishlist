class AddIndexToWishlists < ActiveRecord::Migration
  def change
    add_index :spree_wishlists, [:user_id]
    add_index :spree_wishlists, [:user_id, :is_default]
  end
end
