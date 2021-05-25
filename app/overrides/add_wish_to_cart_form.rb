ActiveSupport::Deprecation.warn('"Add to wishlist" button is deprecated and and is not working properly.')

Deface::Override.new(
  virtual_path: 'spree/products/show',
  name: 'add_wish_to_cart_form',
  insert_bottom: "[data-hook='cart_form']",
  partial: 'spree/products/wishlist_form'
)
