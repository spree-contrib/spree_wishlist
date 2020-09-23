module Spree
  module V2
    module Storefront
      class WishedProductSerializer < BaseSerializer
        set_type :wished_product
        attributes :id, :variant_id,:wishlist_id, :remark, :quantity
      end
    end
  end
end
