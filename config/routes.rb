TDlist::Application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :messages
  resources :authentications, only: [:create]
  
  root 'static_pages#home'

  offline = Rack::Offline.configure do
    #cache "assets/application.css?body=1"
    #cache "assets/cust.css?body=1"

    #cache "assets/application.js?body=1"

    #cache "assets/jquery.js?body=1"
    #cache "assets/jquery_ujs.js?body=1"  

    #cache "assets/application.js?body=1"

    #root_path = Pathname.new(Rails.root + "app/assets/javascripts")

    #Dir[
     # "#{Rails.root}/app/assets/bootstrap/*.{js}",
     # "#{Rails.root}/app/assets/javascripts/angular/*.{js,coffee}",
     # "#{Rails.root}/app/assets/javascripts/angular/controllers/*.{js,coffee}",
     # ].each do |file|
     # cache Pathname.new("assets/" + Pathname.new(file + "?body=1").relative_path_from(root_path).to_s)
    #end

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
