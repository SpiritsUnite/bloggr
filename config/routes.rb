Bloggr::Application.routes.draw do
  root "static_pages#home"

  resources :users
  namespace :dashboard do
    resources :posts
  end
  resources :posts, only: :show

  post 'posts/:id' => 'comments#create'

  get 'register' => 'users#new'
  post 'register' => 'users#create'

  get 'signin' => 'signin#new'
  post 'signin' => 'signin#create'
  delete 'signout' => 'signin#destroy'

  get 'dashboard' => 'dashboard/posts#index'

end
