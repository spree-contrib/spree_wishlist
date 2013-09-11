Deface::Override.new(:virtual_path => "spree/products/show",
                     :name => "add_wish_to_cart_form",
                     :insert_bottom => "[data-hook='cart_form']",
                     :partial => "spree/products/wishlist_form",
                     :disabled => false,
                     :original => "789e3f5f6f36a8cd4115d7342752a37735659298")
