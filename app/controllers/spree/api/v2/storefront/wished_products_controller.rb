module Spree
  module Api
    module V2
      module Storefront
        class WishedProductsController < Spree::Api::WishedProductsBaseController
          def create
            super
            if @wished_product.persisted?
              Spree::V2::Storefront::WishedProductSerializer.new(@wished_product).serialized_json            WishedProductSerializer.new(@wished_product).serialized_json
            else
              invalid_resource!(@wished_product)
            end
          end

          def update
            super
            if @wished_product.errors.empty?
              WishedProductSerializer.new(@wished_product).serialized_json
            else
              invalid_resource!(@wished_product)
            end
          end

          def destroy
            super
            WishedProductSerializer.new(@wished_product).serialized_json
          end

          def resource_serializer
            Spree::V2::Storefront::WishedProductSerializer.new(@wished_product).serialized_json
          end
        end
      end
    end
  end
end
