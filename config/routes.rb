require 'sidekiq/web'

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
  resources :comments, :only => [:create, :edit, :update, :destroy]

  post 'toggle_vote_up/:id'    => 'quote_activities#toggle_vote_up',    :as => :toggle_vote_up
  post 'toggle_vote_down/:id'  => 'quote_activities#toggle_vote_down',  :as => :toggle_vote_down
  post 'favorite/:id'   => 'quote_activities#favorite',   :as => :favorite
  post 'unfavorite/:id' => 'quote_activities#unfavorite', :as => :unfavorite
  post 'quotes/:id/flag'       => 'quote_activities#flag',   :as => :quote_flag
  post 'quotes/:id/unflag'     => 'quote_activities#unflag', :as => :quote_unflag
  post 'quotes/:id/email' => 'quote_activities#email', :as => :quote_email


  delete 'comments/:id' => 'comments#destroy', :as => :comment
  post 'comments/:id/favorite' => 'comment_activities#favorite', :as => :comment_favorite
  post 'comments/:id/unfavorite' => 'comment_activities#unfavorite', :as => :comment_unfavorite
  post 'comments/:id/flag'    => 'comment_activities#flag',    :as => :comment_flag
  post 'comments/:id/unflag'    => 'comment_activities#unflag',    :as => :comment_unflag
  post 'comments/:id/toggle_vote_up'    => 'comment_activities#toggle_vote_up',    :as => :comment_toggle_vote_up
  post 'comments/:id/toggle_vote_down'    => 'comment_activities#toggle_vote_down',    :as => :comment_toggle_vote_down

  resources :feedbacks, :only => [:new, :create]
  
  get 'sharing_email' => 'sharing#email_new', :as => :sharing_email
  post 'sharing_email'=> 'sharing#email_create', :as => :sharing_email
  
  namespace :admin do
    resources :users, :only => [:index]
    resources :feedbacks, :only => [:index]
  end  
  
  # mount Sidekiq::Web, at: '/sidekiq'
  
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
