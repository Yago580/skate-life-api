Rails.application.routes.draw do
  resources :skateparks, only: [:index, :show]
  resources :users, only: [:index, :show, :create, :destroy]

  post '/users/:id/favorites' => 'favorites#create', as: 'favorite'
end
