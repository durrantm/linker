Linker::Application.routes.draw do

  match 'ladmin/login' => 'ladmin#login'
  match 'ladmin/logout' => 'ladmin#logout' 
  resources :users
  resources :groups do
    collection do
      post 'order_links'
    end
  end
  match 'search' => 'links#index'
  match 'advanced_search' => 'links#advanced_search'
  resources :links do   
    collection do
      get 'groups'
    end
  end
  #
  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
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
  #
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "links#index"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
