class WishlistHooks < Spree::ThemeSupport::HookListener
  
  insert_after :cart_form, 'products/wishlist_form'
  insert_after :account_my_orders, 'users/wishlists'
  
end
