object false
node(:attributes) { [*wishlist_attributes] }
node(:required_attributes) { required_fields_for(Spree::Wishlist) }
