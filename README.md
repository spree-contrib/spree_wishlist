# Spree Wishlist

[![Build Status](https://travis-ci.org/spree-contrib/spree_wishlist.svg?branch=3-0-stable)](https://travis-ci.org/spree-contrib/spree_wishlist)
[![Code Climate](https://codeclimate.com/github/spree-contrib/spree_wishlist/badges/gpa.svg)](https://codeclimate.com/github/spree-contrib/spree_wishlist)

The Spree Wishlist extension enables multiple wishlists per user, as well as managing those as public (sharable) and private. It also includes the ability to notify a friend via email of a recommended product.

---

## Installation

Add the following to your `Gemfile`
```ruby
gem 'spree_wishlist', github: 'spree-contrib/spree_wishlist', branch: '3-0-stable'
gem 'spree_email_to_friend', github: 'spree-contrib/spree_email_to_friend', branch: '3-0-stable'
```

Run
```sh
$ bundle install
$ bundle exec rails g spree_wishlist:install
```

---

## Contributing

[See corresponding guidelines][1]

---

Copyright (c) 2009-2015 [Spree Commerce Inc.][4] and [contributors][5], released under the [New BSD License][3]

[1]: https://github.com/spree-contrib/spree_wishlist/blob/master/CONTRIBUTING.md
[3]: https://github.com/spree-contrib/spree_wishlist/blob/master/LICENSE.md
[4]: https://github.com/spree
[5]: https://github.com/spree-contrib/spree_wishlist/graphs/contributors
