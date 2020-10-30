module Spree
  module Api
    module V2
      module Storefront
        class WishedProductsController < ::Spree::Api::V2::BaseController

          def create
            spree_authorize! :create, Spree::WishedProduct

            @wished_product = Spree::WishedProduct.new(wished_product_attributes)

            @wishlist = spree_current_user.wishlists.find(@wished_product[:wishlist_id]) || spree_current_user.wishlist

            if @wishlist.include? params[:wished_product][:variant_id]
              @wished_product = @wishlist.wished_products.detect {|wp| wp.variant_id == params[:wished_product][:variant_id].to_i }
            else
              @wished_product.wishlist = @wishlist
              @wished_product.save
            end

            @wishlist.reload
            if @wished_product.persisted?
              render_serialized_payload { serialize_resource(@wished_product) }
            else
              render_error_payload(@wished_product.errors.full_messages.join(', '))
            end
          end

          def update
            @wished_product = Spree::WishedProduct.find(params[:id])
            spree_authorize! :update, @wished_product
            @wished_product.update(wished_product_attributes)
            @wishlist = @wished_product.wishlist

            if @wished_product.errors.empty?
              render_serialized_payload { serialize_resource(@wished_product) }
            else
              render_error_payload(@wished_product.errors.full_messages.join(', '))
            end
          end

          def destroy
            @wished_product = Spree::WishedProduct.find(params[:id])
            spree_authorize! :destroy, @wished_product
            @wished_product.destroy
            render_serialized_payload { serialize_resource(@wished_product) }
          end

          private

          def wished_product_attributes
            params.require(:wished_product).permit(:variant_id, :wishlist_id, :remark)
          end

          def resource_serializer
            ::Spree::V2::Storefront::WishedProductSerializer
          end
        end
      end
    end
  end
end
