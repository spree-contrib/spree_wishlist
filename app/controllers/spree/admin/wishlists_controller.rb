class Spree::Admin::WishlistsController < Spree::Admin::BaseController
  helper 'spree/products'

  before_action :find_wishlist, only: [:show, :destroy]

  respond_to :html
  respond_to :js, only: :update

  def show
    respond_with(@wishlist)
  end

  def destroy
    @wishlist.destroy
    respond_with(@wishlist) do |format|
      format.html { redirect_to account_path }
    end
  end

  private

  def wishlist_attributes
    params.require(:wishlist).permit(:name, :is_default, :is_private)
  end

  # Isolate this method so it can be overwritten
  def find_wishlist
    @wishlist = Spree::Wishlist.find_by_access_hash!(params[:id])
  end
end
