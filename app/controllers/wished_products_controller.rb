class WishedProductsController < ApplicationController
  resource_controller

  create.before do
    @wished_product.wishlist = current_user.wishlist
  end
  
  create.response do |wants|
    wants.html { redirect_to @wished_product.wishlist }
  end

  update.response do |wants|
    wants.html { redirect_to @wished_product.wishlist }
  end
  
  destroy.response do |wants|
    wants.html { redirect_to @wished_product.wishlist }
  end
end
