Deface::Override.new(:virtual_path => "products/show",
                     :name => "add_wish_to_cart_form",
                     :insert_bottom => "[data-hook='cart_form']",
                     :partial => "products/wishlist_form",
                     :disabled => false)
