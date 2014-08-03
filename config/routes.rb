Bloggr::Application.routes.draw do
  root "static_pages#home"

  resources :users
  namespace :dashboard do
    resources :posts
  end

  get 'register' => 'users#new'
  post 'register' => 'users#create'

  get 'signin' => 'signin#new'
  post 'signin' => 'signin#create'
  delete 'signout' => 'signin#destroy'

  get 'dashboard' => 'dashboard/posts#index'

end
