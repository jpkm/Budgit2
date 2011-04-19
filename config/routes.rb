Budgit::Application.routes.draw do
  get "home/index"

  match 'user/edit' => 'users#edit', :as => :edit_current_user

  match 'signup' => 'users#new', :as => :signup

  match 'logout' => 'sessions#destroy', :as => :logout

  match 'login' => 'sessions#new', :as => :login
  
  root :to => 'home#index'
  
  resources :sessions

  resources :users

  resources :credit_categories
  match 'deactivate3' => 'credit_categories#deactivate3', :as => :deactivate3
  match 'reactivate3' => 'credit_categories#reactivate3', :as => :reactivate3

  resources :credits

  resources :debit_categories
  match 'deactivate4' => 'debit_categories#deactivate4', :as => :deactivate4
  match 'reactivate4' => 'debit_categories#reactivate4', :as => :reactivate4
  
  resources :roles

  resources :debits 
  match 'reimburse' => 'debits#reimburse', :as => :reimburse
  match 'process' => 'debits#process', :as => :process
  match 'claim' => 'debits#claim', :as => :claim
   
  resources :accounts
  match 'deactivate1' => 'accounts#deactivate1', :as => :deactivate1
  match 'make_account' => 'accounts#make_account', :as => :make_account
	
  resources :clubs
  match 'deactivate5' => 'clubs#deactivate5', :as => :deactivate5
  match 'reactivate5' => 'clubs#reactivate5', :as => :reactivate5

  resources :assignments
  match 'deactivate2' => 'assignments#deactivate2', :as => :deactivate2
  match 'reactivate2' => 'assignments#reactivate2', :as => :reactivate2
  
 
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
  
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
