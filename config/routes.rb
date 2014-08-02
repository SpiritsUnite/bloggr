Bloggr::Application.routes.draw do
  root "static_pages#home"

  resources :users
  get 'register' => 'users#new'
  post 'register' => 'users#create'

end
