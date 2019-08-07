Deface::Override.new(
  virtual_path: 'spree/admin/users/_sidebar',
  name: 'add_wishlists_to_admin_user_sidebar',
  insert_bottom: "[data-hook='admin_user_tab_options']",
  partial: 'spree/admin/users/link_to_wishlists',
  original: 'f1f0e9b7901295ea2f4dedaa53efd632aaa2d26e'
)
