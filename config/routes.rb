Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  resources :products
  # resources :carts
  # resources :categories
  # resources :guests

  get '/login'  =>  'sessions#new', as: 'login'
  post '/login' =>  'sessions#create'
  delete '/logout' => 'sessions#destroy', as: 'logout'
  resources :merchants, only: [:new, :create, :show] do
    get :dashboard
    resources :products
    resources :orders, only: [:index, :show]
  end

  resources :categories, only: [:new, :create]

  patch 'merchants/:merchant_id/products/:id/active_update' => 'products#active_update', as: "active_update"

  patch 'merchants/:merchant_id/order_items/:id' => 'order_items#mark_shipped', as: "mark_shipped"

  # resources :orders
  # resources :order_items
  # resources :payments
  # resources :products
  # resources :reviews
  # resources :sessions

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
