class Spree::WishlistsController < Spree::StoreController
  helper 'spree/products'

  respond_to :html
  respond_to :js, :only => [:update]

  def new
    @wishlist = Spree::Wishlist.new

    respond_with(@wishlist)
  end

  def edit
    @wishlist = Spree::Wishlist.find_by_access_hash(params[:id])

    respond_with(@wishlist)
  end

  def update
    @wishlist = Spree::Wishlist.find_by_access_hash(params[:id])
    @wishlist.update_attributes(params[:wishlist])

    respond_with(@wishlist)
  end

  def show
    @wishlist = Spree::Wishlist.find_by_access_hash(params[:id])

    respond_with(@wishlist)
  end

  def create
    @wishlist = Spree::Wishlist.new(params[:wishlist])
    @wishlist.user = spree_current_user

    @wishlist.save
    respond_with(@wishlist)
  end

  def destroy
    @wishlist = Spree::Wishlist.find_by_access_hash(params[:id])
    @wishlist.destroy
    respond_with(@wishlist )do |format|
      format.html { redirect_to account_path }
    end
  end

end
