Linker::Application.routes.draw do

  match 'ladmin/login' => 'ladmin#login'
  match 'ladmin/logout' => 'ladmin#logout' 
  resources :users
  resources :groups do
    resources :links # Added so that I can do group/:id/link/new ...
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

  root :to => "links#index"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
