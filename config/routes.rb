Spree::Core::Engine.add_routes do
  resources :wishlists
  resources :wished_variants, only: [:create, :update, :destroy]
  get '/wishlist' => 'wishlists#default', as: 'default_wishlist'
end
