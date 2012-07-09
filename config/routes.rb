Spree::Core::Engine.routes.draw do
  resources :wishlists
  resources :wished_products, :only => [:create, :update, :destroy]
  match '/wishlist' => "wishlists#default", :as => "default_wishlist"
end
