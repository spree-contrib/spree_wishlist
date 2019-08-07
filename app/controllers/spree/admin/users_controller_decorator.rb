Spree::Admin::UsersController.class_eval do

  def wishlists
    per_page = params[:per_page] || Spree::Config[:admin_wishlists_per_page]    
    @wishlists = @user.wishlists.page(params[:page]).per(per_page)
  end

end
