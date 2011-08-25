# Spree Wishlist extension

The Spree Wishlist extension enables multiple wishlists per user, as well as managing those
as public (sharable) and private.  It also includes the ability to notify a friend via email
of a recommended product.

## Installation

1. Add the following to your Gemfile

<pre>
    gem 'spree_wishlist', :git => 'git://github.com/spree/spree_wishlist.git'
    gem 'spree_email_to_friend'
</pre>

2. Run `bundle install`

3. To setup the asset pipeline includes and copy migrations run: `rails g spree_wishlist:install`

