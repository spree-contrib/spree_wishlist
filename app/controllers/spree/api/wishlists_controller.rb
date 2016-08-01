module Spree
  module Api

    class WishlistsController < Spree::Api::BaseController

      before_filter :find_wishlist, :only => [:destroy, :show, :update, :edit]

      helper Spree::Wishlists::ApiHelpers

      def index
        @wishlists = current_wishlist_user.wishlists.page(params[:page]).per(params[:per_page])
        respond_with(@wishlists)
      end

      def new
      end

      def create
        authorize! :create, Spree::Wishlist
        @wishlist = Spree::Wishlist.new( wishlist_attributes )
        @wishlist.user = current_wishlist_user
        @wishlist.save

        if @wishlist.persisted?
          respond_with(@wishlist, :status => 201, :default_template => :show)
        else
          invalid_resource!(@wishlist)
        end
      end

      def show
        expires_in 15.minutes, :public => true
        respond_with(@wishlist)
      end

      def update
        authorize! :update, @wishlist
        @wishlist.update_attributes wishlist_attributes

        if @wishlist.errors.empty?
          respond_with(@wishlist, :status => 200, :default_template => :show)
        else
          invalid_resource!(@wishlist)
        end
      end

      def destroy
        authorize! :destroy, @wishlist
        @wishlist.destroy
        respond_with(@wishlist, :status => 204)
      end

      private

      def wishlist_attributes
        params.require(:wishlist).permit(:name, :is_default, :is_private)
      end

      def find_wishlist
        @wishlist = Spree::Wishlist.find_by_access_hash!(params[:id])
      end
      
      # to allow managing of other users' list by admins
      def current_wishlist_user
        @current_wishlist_user ||= begin
          if params[:user_id] && @current_user_roles.include?('admin')
            Spree.user_class.find(params[:user_id])
          else
            # if the API user is not an admin, or didn't ask for another user,
            # return themselves.
            current_api_user
          end
        end
      end
    end # eoc

  end
end
