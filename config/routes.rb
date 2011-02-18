Budgit::Application.routes.draw do
  resources :debit_categories

  resources :dabit_categories

  match 'user/edit' => 'users#edit', :as => :edit_current_user

  match 'signup' => 'users#new', :as => :signup

  match 'logout' => 'sessions#destroy', :as => :logout

  match 'login' => 'sessions#new', :as => :login
  
  root :to => 'home#index'
  #root :controller => 'home', :action => 'index'
  
  resources :sessions

  resources :users

  resources :credit_categories

  resources :credits

  resources :debit_categories

  resources :roles

  resources :debits

  resources :accounts

  resources :clubs

  resources :assignments
  
  # for home page and other semi-static pages
   #map.root :controller => 'home', :action => 'index'
   #map.home ':page', :controller => 'home', :action => 'show', "page => /index|about|contacts|privacy/

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  
  #root :to => 'home', :action => 'index'
  #root :controller => 'home', :action => 'index'
  
  #map.root :controller => 'home', :action => 'index'
   #map.home ':page', :controller => 'home', :action => 'show', "page => /index|about|contacts|privacy/

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
