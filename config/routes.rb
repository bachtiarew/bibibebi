Rails.application.routes.draw do
 
  get "users/sign_in"
  get "mains/index"
  get "users/logout"
  get "homepages/coba"
  post "users/login"
  resources :users do
    collection do
      get :create_mobile
      get :login_mobile
    end
  end
  resources :babysitters do 
    collection do
      get :update_rate
      post :create_mobile
    end
  end
  get "parents/get_user", to: "parents#get_user"
  resources :parents
  root "homepages#index"
  get 'admins/index'
  get 'homepages/frame' 
  post "homepages/copas"
  post '/rate' => 'rater#create', as: 'rate'
  namespace :admins do
    resources :graphs
    resources :skills
  end

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
