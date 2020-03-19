# Spree Wishlist

[![Build Status](https://travis-ci.org/spree-contrib/spree_wishlist.svg?branch=master)](https://travis-ci.org/spree-contrib/spree_wishlist)
[![Code Climate](https://codeclimate.com/github/spree-contrib/spree_wishlist/badges/gpa.svg)](https://codeclimate.com/github/spree-contrib/spree_wishlist)

The Spree Wishlist extension enables multiple wishlists per user, as well as managing those as public (sharable) and private. It also includes the ability to notify a friend via email of a recommended product.

---

## Installation

Add the following to your `Gemfile`

```ruby
gem 'spree_wishlist', github: 'spree-contrib/spree_wishlist', branch: 'master'
```

Run

```bash
bundle install
bundle exec rails g spree_wishlist:install
```

## API endpoints

Please read [Spree API v1 summary](https://guides.spreecommerce.org/api/summary.html) first.

Available endpoints:

### Wishlists management

* GET `/api/v1/wishlists` - returns a list of wishlists for signed in user
* GET `/api/v1/wishlists/:id` - returns single wishlists with a list of Products (Variants)
* POST `/api/v1/wishlists` - creates a new wishlist

  payload:

  ```json
  wishlist: {
    name: 'fathers day'
  }
  ```

* PATCH `/api/v1/wishlists/:id`

  payload:
  
  ```json
  wishlist: {
    name: 'new name'
  }
  ```

* DELETE `/api/v1/wishlists/:id`

### Wishlists products management

* POST `/api/v1/wished_products` - adds Product (Variant) to a Wishlist

  payload:

  ```json
  wished_product: {
    variant_id: 2,
    wishlist_id: 1
  }
  ```

* PATCH `/api/v1/wished_products/:id`

  payload:

  ```json
  wished_product: {
    variant_id: 3,
    wishlist_id: 2
  }
  ```

* DELETE `/api/v1/wished_products/:id`

---

## Contributing

[See corresponding guidelines][1]

---

Copyright (c) 2009-2020 [Spree Commerce Inc.][4] and [contributors][5], released under the [New BSD License][3]

[1]: https://github.com/spree-contrib/spree_wishlist/blob/master/CONTRIBUTING.md
[3]: https://github.com/spree-contrib/spree_wishlist/blob/master/LICENSE.md
[4]: https://github.com/spree
[5]: https://github.com/spree-contrib/spree_wishlist/graphs/contributors
