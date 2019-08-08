class Spree::Admin::WishlistsController < Spree::Admin::BaseController
  helper 'spree/products'

  before_action :find_wishlist, only: [:show, :destroy]

  respond_to :html

  def show
     @user = @wishlist.user
    respond_with(@wishlist)
  end

  def destroy
    if @wishlist.destroy
      flash[:success] = Spree.t(:wishlist_deleted, scope: :notice_messages)
    else
      flash[:error] = Spree.t(:wishlist_not_deleted, scope: :notice_messages, error: @wishlist.errors.full_messages.to_sentence)
    end
    redirect_to spree.wishlists_admin_user_url
  end

  private

  def find_wishlist
    @wishlist = Spree::Wishlist.find_by_access_hash!(params[:id])
  end
end
