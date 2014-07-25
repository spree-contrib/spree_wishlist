Spree::Core::Engine.routes.draw do
  resources :wishlists, path: "lista-de-desejos"
  resources :wished_products, only: [:create, :update, :destroy]
  get '/lista-de-desejos' => "wishlists#default", as: "default_wishlist"
end
