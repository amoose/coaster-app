# == Route Map
#
#           Prefix Verb   URI Pattern                             Controller#Action
#            users GET    /users(.:format)                        users#index
#                  POST   /users(.:format)                        users#create
#         new_user GET    /users/new(.:format)                    users#new
#        edit_user GET    /users/:id/edit(.:format)               users#edit
#             user GET    /users/:id(.:format)                    users#show
#                  PATCH  /users/:id(.:format)                    users#update
#                  PUT    /users/:id(.:format)                    users#update
#                  DELETE /users/:id(.:format)                    users#destroy
#                  PATCH  /users/:id/update_geolocation(.:format) users#update_geolocation
#         sessions POST   /sessions(.:format)                     sessions#create
#      new_session GET    /sessions/new(.:format)                 sessions#new
#          session DELETE /sessions/:id(.:format)                 sessions#destroy
#     destinations GET    /destinations(.:format)                 destinations#index
#                  POST   /destinations(.:format)                 destinations#create
#  new_destination GET    /destinations/new(.:format)             destinations#new
# edit_destination GET    /destinations/:id/edit(.:format)        destinations#edit
#      destination GET    /destinations/:id(.:format)             destinations#show
#                  PATCH  /destinations/:id(.:format)             destinations#update
#                  PUT    /destinations/:id(.:format)             destinations#update
#                  DELETE /destinations/:id(.:format)             destinations#destroy
#         stations GET    /stations(.:format)                     stations#index
#                  POST   /stations(.:format)                     stations#create
#      new_station GET    /stations/new(.:format)                 stations#new
#     edit_station GET    /stations/:id/edit(.:format)            stations#edit
#          station GET    /stations/:id(.:format)                 stations#show
#                  PATCH  /stations/:id(.:format)                 stations#update
#                  PUT    /stations/:id(.:format)                 stations#update
#                  DELETE /stations/:id(.:format)                 stations#destroy
#             root GET    /                                       stations#home
#             help GET    /help(.:format)                         static_pages#help
#            about GET    /about(.:format)                        static_pages#about
#          contact GET    /contact(.:format)                      static_pages#contact
#          locator GET    /locator(.:format)                      users#locator
#           signup GET    /signup(.:format)                       users#new
#           signin GET    /signin(.:format)                       sessions#new
#          signout GET    /signout(.:format)                      sessions#destroy
#

Coaster::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  resources :users
  patch '/users/:id/update_geolocation', to: 'users#update_geolocation'
  resources :sessions, only: [:new, :create, :destroy]
  resources :destinations
  resources :stations

  root to: 'stations#nearest'
  get '/help',      to: 'static_pages#help'
  get '/about',     to: 'static_pages#about'
  get '/contact',   to: 'static_pages#contact'

  get '/locator',   to: 'users#locator'
  get '/signup',    to: 'users#new'
  get '/signin',    to: 'sessions#new'
  get '/signout',   to: 'sessions#destroy', via: :delete

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
