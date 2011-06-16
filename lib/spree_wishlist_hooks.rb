Deface::Override.new(:virtual_path => "products/show",
                     :name => "add_wish_to_cart_form",
                     :insert_bottom => "[data-hook='cart_form']",
                     :partial => "products/wishlist_form",
                     :disabled => false)
Deface::Override.new(:virtual_path => "users/show",
                     :name => "add_wishlists_to_account_my_orders",
                     :insert_after => "[data-hook='account_my_orders']",
                     :partial => "users/wishlists",
                     :disabled => false)
Deface::Override.new(:virtual_path => "wishlists/show",
                     :name => "add_email_to_wishlist_footer_links",
                     :insert_after => "[data-hook='wishlist_footer_links']",
                     :text => %(<div id="email_to_friend">
                       <%= link_to(t('email_to_friend.send_to_friend'), email_to_friend_url('wishlist', @wishlist)) %>
                     </div>),
                     :disabled => false)
