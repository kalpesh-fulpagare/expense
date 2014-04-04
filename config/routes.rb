RailsApp::Application.routes.draw do
  resources :meter_readings
  resources :groups
  authenticated :user do
    root to: "dashboards#show"
  end
  devise_for :users, skip: [:registrations]
  devise_scope :user do
    root to: "devise/sessions#new"
  end

  resources :expenses
  resources :personal_expenses
  resources :categories, except: [:show]
  resources :users, except: [:show] do
    put 'change_password', on: :member
    post "invite", on: :collection
  end
  resource :dashboard
  resources :events do
    put 'change_status', on: :member
  end
  resource :tools, only: [] do
    get 'monthly_stats', on: :collection
    get 'calculate_stats', on: :collection
    put 'update_stats', on: :collection
  end
  match 'users/:id/change_password' => 'users#edit'

  # devise_for :users
  # # Devise Routes
  # authenticated :user do
  #   root to: "users#index"
  # end
  # devise_scope :user do
  #   root to: "devise/sessions#new"
  # end
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
