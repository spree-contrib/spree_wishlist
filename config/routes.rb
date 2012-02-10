Spree::Core::Engine.routes.prepend do
  resources :wishlists
  resources :wished_products, :only => [:create, :update, :destroy]
  match '/wishlist' => "wishlists#show", :as => "default_wishlist"
end
