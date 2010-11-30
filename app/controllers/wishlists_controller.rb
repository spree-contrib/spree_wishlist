class WishlistsController < Spree::BaseController
  resource_controller
  helper :products
  
  create.before do
    @wishlist.user = current_user
  end

  update.wants.js { 
    flash[:notice] = nil
    render :js => "alert('#{t :updated_successfully}');"
  }
  
  private

    def object
      @object ||= end_of_association_chain.find_by_access_hash(param)
      @object ||= current_user.wishlist if current_user
      @object
    end

    def can_read?
      object && object.can_be_read_by?(current_user)
    end
end
