Bloggr::Application.routes.draw do
  resources :users
  get 'signup' => 'users#new'
  post 'signup' => 'users#create'

end
