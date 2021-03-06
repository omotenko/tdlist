TDlist::Application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :messages
  resources :authentications, only: [:create]
  
  root 'static_pages#home'

  offline = Rack::Offline.configure do
    cache "assets/application.css"
    cache "assets/application.js"

    cache "assets/bootstrap/glyphicons-halflings-regular.woff"
    cache "assets/bootstrap/glyphicons-halflings-regular.ttf"
    cache "assets/bootstrap/glyphicons-halflings-regular.svg"

    public_path = Pathname.new(Rails.public_path)
    Dir[
      public_path.join("templates/*.html")
      ].each do |file|
      cache Pathname.new(file).relative_path_from(public_path)
    end

    network "*"
  end

  match '/application.manifest', to: offline, via: 'get'

  match '/auth/:provider/callback', to: 'authentications#create', via: 'get'

  match '/signup',  to: 'users#new',        via: 'get'
  match '/signin',  to: 'sessions#new',     via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'

  match '/messages',     to: 'messages#index',   via: 'get'
  match '/messages',     to: 'messages#create',  via: 'post'
  match '/messages/:id', to: 'messages#update',  via: 'put'
  match '/messages/:id', to: 'messages#destroy', via: 'delete'


  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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
