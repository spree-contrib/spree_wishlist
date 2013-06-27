Spree.user_class.class_eval do
  has_many :wishlists, :class_name => Spree::Wishlist

  def wishlist
    default_wishlist = self.wishlists.first(:conditions => ["is_default = ?", true])
    default_wishlist ||= self.wishlists.first
    default_wishlist ||= self.wishlists.create(:name => Spree.t(:default_wishlist_name, :default => "My wishlist"), :is_default => true)
    default_wishlist.update_attribute(:is_default, true) unless default_wishlist.is_default?
    default_wishlist
  end
end
