Deface::Override.new(:virtual_path => "wishlists/show",
                     :name => "add_email_to_wishlist_footer_links",
                     :insert_after => "[data-hook='wishlist_footer_links']",
                     :text => %(<% if respond_to?(:email_to_friend_url) %> <div id="email_to_friend">
                       <%= link_to(t('email_to_friend.send_to_friend'), email_to_friend_url('wishlist', @wishlist)) %>
                     </div><% end %>),
                     :disabled => false)
