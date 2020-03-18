module Spree
  module Wishlists
    module ApiHelpers

      ATTRIBUTES = [
        :wishlist_attributes,
        :wished_product_attributes
      ]

      mattr_reader *ATTRIBUTES

      @@wishlist_attributes = [
        :access_hash, :user_id, :name, :is_private, :is_default
      ]

      @@wished_product_attributes = [
        :id, :variant_id, :wishlist_id, :remark
      ]

    end
  end
end
