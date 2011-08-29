class WishlistsController < Spree::BaseController
  helper :products

  respond_to :html
  respond_to :js, :only => [:update]

  def new
    @wishlist = Wishlist.new

    respond_with(@wishlist)
  end

  def edit
    @wishlist = Wishlist.find_by_access_hash(params[:id])

    respond_with(@wishlist)
  end

  def update
    @wishlist = Wishlist.find_by_access_hash(params[:id])
    @wishlist.update_attributes(params[:wishlist])

    respond_with(@wishlist)
  end

  def show
    @wishlists = current_user.wishlists
    @wishlist = Wishlist.find_by_access_hash(params[:id])

    respond_with(@wishlist)
  end

  def create
    @wishlist = Wishlist.new(params[:wishlist])
    @wishlist.user = current_user

    @wishlist.save
    respond_with(@wishlist)
  end

  def destroy
    @wishlist = Wishlist.find_by_access_hash(params[:id])
    @wishlist.destroy
    respond_with(@wishlist )do |format|
      format.html { redirect_to account_path }
    end
  end

end
