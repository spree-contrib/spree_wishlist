module Spree
  module V2
    module Storefront
      class WishedProductSerializer < BaseSerializer
        set_type :wished_product

        attributes :remark, :quantity

        attribute :pre_tax_amount do |product|
          product.variant.product.pre_tax_price * product.quantity
        end

        attribute :display_pre_tax_amount do |product|
          Spree::Money.new(product.variant.product.pre_tax_price * product.quantity)
        end

        belongs_to :variant
        belongs_to :wishlist, serializer: ::Spree::V2::Storefront::WishlistSerializer
      end
    end
  end
end
