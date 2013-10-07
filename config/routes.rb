VerseApp::Application.routes.draw do

  # devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks", :registrations => 'registrations' }
  # devise_scope :user do
  #   post '/users/auth/twitter_with_poem' => 'omniauth_callbacks#twitter_with_poem', :as => 'twitter_with_poem'
  # end

  root :to => 'welcome#index'
  get '/about' => 'welcome#about', :as => 'about'
  get '/contact' => 'welcome#contact', :as => 'contact'

  post '/poems/write_poem' => 'poems#write_poem'
  get '/poems/select_user' => 'poems#select_user'
  get '/poems/guest_check' => 'poems#create_from_guest', :as => 'create_poem_from_guest'

  get '/users/:id' => 'users#show', :as => 'profile'
  get '/users/:id/edit' => 'users#edit'
  put '/users/:id' => 'users#update'

  resources :poems
  resources :titles

  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout

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


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
