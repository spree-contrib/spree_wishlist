class SpreeWishlistHooks < Spree::ThemeSupport::HookListener
  Deface::Override.new(:virtual_path => "products/show",
                       :name => "converted_cart_form_445784258",
                       :insert_after => "[data-hook='cart_form'], #cart_form[data-hook]",
                       :partial => "products/wishlist_form",
                       :disabled => false)
  Deface::Override.new(:virtual_path => "users/show",
                       :name => "converted_account_my_orders_389006052",
                       :insert_after => "[data-hook='account_my_orders'], #account_my_orders[data-hook]",
                       :partial => "users/wishlists",
                       :disabled => false)
  Deface::Override.new(:virtual_path => "wishlists/show",
                       :name => "converted_wishlist_footer_links",
                       :insert_after => "[data-hook='wishlist_footer_links'], #footer_links[data-hook]",
                       :text => %(<div id="email_to_friend">
                         <%= link_to(t('email_to_friend.send_to_friend'), email_to_friend_url('wishlist', @wishlist)) %>
                       </div>),
                       :disabled => false)
end
