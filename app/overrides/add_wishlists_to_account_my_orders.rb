Deface::Override.new(
  virtual_path: 'spree/users/show',
  name: 'add_wishlists_to_account_my_orders',
  insert_after: "[data-hook='account_my_orders']",
  partial: 'spree/users/wishlists',
  original: 'f1f0e9b7901295ea2f4dedaa53efd632aaa2d26e'
)
