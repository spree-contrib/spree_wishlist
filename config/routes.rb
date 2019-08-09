Spree::Core::Engine.add_routes do

  resources :wishlists
  resources :wished_products, only: [:create, :update, :destroy]
  get '/wishlist' => 'wishlists#default', as: 'default_wishlist'

  namespace :admin, path: Spree.admin_path do
    resources :users do
      resources :wishlists, only: [:index, :show, :destroy]
    end
  end

end
