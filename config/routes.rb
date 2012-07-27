Smds::Application.routes.draw do
  devise_for :users

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

  root :to => 'quotes_lister#index'
  
  match 'newest'               => 'quotes_lister#newest'
  match 'favorites'            => 'quotes_lister#favorites'
  match 'my_submissions'       => 'quotes_lister#my_submissions'
  match ':user_id/submissions' => 'quotes_lister#user_submissions', :as => :user_submissions

  resources :quotes, :except => [:index]
  resources :comments, :only => [:create, :destroy]

  post 'vote_up/:id'    => 'quotes_activity#vote_up',    :as => :vote_up
  post 'vote_down/:id'  => 'quotes_activity#vote_down',  :as => :vote_down
  post 'favorite/:id'   => 'quotes_activity#favorite',   :as => :favorite
  post 'unfavorite/:id' => 'quotes_activity#unfavorite', :as => :unfavorite
  post 'quotes/:id/flag'       => 'quotes_activity#flag',   :as => :quote_flag
  post 'quotes/:id/unflag'     => 'quotes_activity#unflag', :as => :quote_unflag


  delete 'comments/:id' => 'comments#destroy', :as => :comment
  post 'comments/:id/favorite' => 'comment_activities#favorite', :as => :comment_favorite
  post 'comments/:id/unfavorite' => 'comment_activities#unfavorite', :as => :comment_unfavorite
  post 'comments/:id/flag'    => 'comment_activities#flag',    :as => :comment_flag
  post 'comments/:id/unflag'    => 'comment_activities#unflag',    :as => :comment_unflag
  post 'comments/:id/vote_up'    => 'comment_activities#vote_up',    :as => :comment_vote_up
  post 'comments/:id/vote_down'    => 'comment_activities#vote_down',    :as => :comment_vote_down

  namespace :admin do
    resources :users, :only => [:index]
  end  
  
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
