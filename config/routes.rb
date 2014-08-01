Bloggr::Application.routes.draw do
  root "static_pages#home"

  resources :users
  get 'signup' => 'users#new'
  post 'signup' => 'users#create'

end
