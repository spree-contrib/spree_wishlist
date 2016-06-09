module Spree
  module Api

    class WishedProductsController < Spree::Api::BaseController

      helper Spree::Wishlists::ApiHelpers

      def create
        authorize! :create, Spree::WishedProduct
        @wished_product = Spree::WishedProduct.new(wished_product_attributes)
        @wishlist = current_api_user.wishlist

        if @wishlist.include? params[:wished_product][:variant_id]
          @wished_product = @wishlist.wished_products.detect {|wp| wp.variant_id == params[:wished_product][:variant_id].to_i }
        else
          @wished_product.wishlist = @wishlist
          @wished_product.save
        end

        @wishlist.reload
        if @wished_product.persisted?
          respond_with(@wishlist, :status => 201, :default_template => :show)
        else
          invalid_resource!(@wished_product)
        end
      end

      def update
        @wished_product = Spree::WishedProduct.find(params[:id])
        authorize! :update, @wished_product
        @wished_product.update_attributes(wished_product_attributes)
        @wishlist = @wished_product.wishlist

        if @wished_product.errors.empty?
          respond_with(@wished_product, :status => 200, :default_template => :show)
        else
          invalid_resource!(@wished_product)
        end
      end

      def destroy
        @wished_product = Spree::WishedProduct.find(params[:id])
        authorize! :destroy, @wished_product
        @wished_product.destroy
        respond_with(@wished_product, :status => 204)
      end

      private

      def wished_product_attributes
        params.require(:wished_product).permit(:variant_id, :wishlist_id, :remark)
      end


    end # eoc

  end
end
