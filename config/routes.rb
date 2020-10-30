Spree::Core::Engine.add_routes do
  resources :wishlists
  resources :wished_products, only: [:create, :update, :destroy]
  get '/wishlist' => "wishlists#default", as: "default_wishlist"

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :wishlists
      resources :wished_products, only: [:create, :update, :destroy]
    end

    namespace :v2 do
      namespace :storefront do
        resources :wishlists
        resources :wished_products, only: [:create, :update, :destroy]
      end
    end
  end
end
