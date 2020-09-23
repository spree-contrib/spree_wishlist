module Spree
  module Api
    module V1
      class WishedProductsController < Spree::Api::WishedProductsBaseController
        def create
          super

          if @wished_product.persisted?
            respond_with(@wishlist, status: 201, default_template: :show)
          else
            invalid_resource!(@wished_product)
          end
        end

        def update
          super

          if @wished_product.errors.empty?
            respond_with(@wished_product, default_template: :show)
          else
            invalid_resource!(@wished_product)
          end
        end

        def destroy
          super
          respond_with(@wished_product, status: 204)
        end

      end
    end
  end
end
