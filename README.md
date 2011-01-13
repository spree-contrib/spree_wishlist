# Spree Wishlist extension

The Spree Wishlist extension enables multiple wishlists per user, as well as managing those
as public (sharable) and private.  It also includes the ability to notify a friend via email
of a recommended product.

## Installation

1. Add spree_wishlist to your Gemfile
2. run `bundle install`
3. copy over assets and migrations via the rake task: `rake spree_wishlist:install`
4. run the migrations: `rake db:migrate`

