class WishlistHooks < Spree::ThemeSupport::HookListener
  
  insert_after :cart_form, 'products/wishlist_form'
  insert_after :account_my_orders, 'users/wishlists'
  insert_after :wishlist_footer_links do
    content_tag('div', link_to(t('email_to_friend.send_to_friend'), email_to_friend_url('wishlist', @wishlist)), :id => 'email_to_friend')
  end
  
end
