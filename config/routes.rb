Linker::Application.routes.draw do

  match 'ladmin/login' => 'ladmin#login', via: [:get, :post]
  match 'ladmin/logout' => 'ladmin#logout', via: [:get, :post]

  resources :users
  resources :groups do
    resources :links # Enables group/:id/link/new
    collection do
      post 'order_links'
    end
  end

  #match 'search' => 'links#index'
  get 'search' => 'links#index'
  get 'advanced_search' => 'links#advanced_search'
  resources :links do
    collection do
      get 'groups'
    end
  end

  get 'toggle_full_details' => 'links#toggle_full_details'
  get 'toggle_row_shading' => 'links#toggle_row_shading'

  get 'verify_link/:id', to: 'links#verify_link', as: :verify_link
  get 'unverify_link/:id', to: 'links#unverify_link', as: :unverify_link

  root :to => "links#index"

end
