User.class_eval do
  has_many :wishlists

  def wishlist
    default_wishlist = self.wishlists.first(:conditions => ["is_default = ?", true]) 
    default_wishlist ||= self.wishlists.first
    default_wishlist ||= self.wishlists.create(:name => I18n.t(:default_wishlist_name, :default => "My wishlist"), :is_default => true)
    default_wishlist.update_attribute(:is_default, true) unless default_wishlist.is_default?
    default_wishlist
  end
end
