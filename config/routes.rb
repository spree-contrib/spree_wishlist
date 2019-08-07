Spree::Core::Engine.add_routes do

  resources :wishlists
  resources :wished_products, only: [:create, :update, :destroy]
  get '/wishlist' => 'wishlists#default', as: 'default_wishlist'

  namespace :admin, path: Spree.admin_path do
    resources :users do
      member do
        get :wishlists
      end
    end

    resources :wishlists, only: [:show, :destroy]
  end

end
