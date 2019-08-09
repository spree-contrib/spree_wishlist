module Spree
  module Admin
    class WishlistsController < Spree::Admin::BaseController

      before_action :load_user
      before_action :find_wishlist, only: [:show, :destroy]

      respond_to :html

      def index
        per_page = params[:per_page] || Spree::Config[:admin_wishlists_per_page]
        @wishlists = @user.wishlists.page(params[:page]).per(per_page)
      end

      def show
        respond_with(@wishlist)
      end

      def destroy
        if @wishlist.destroy
          flash[:success] = Spree.t(:wishlist_deleted, scope: :notice_messages)
        else
          flash[:error] = Spree.t(:wishlist_not_deleted, scope: :notice_messages, error: @wishlist.errors.full_messages.to_sentence)
        end
        redirect_to spree.admin_user_wishlists_url(@user)
      end

      private

      def load_user
        @user = Spree::User.find_by_id(params[:user_id])
      end

      def find_wishlist
        @wishlist = Spree::Wishlist.find_by_access_hash!(params[:id])
      end

    end
  end
end
