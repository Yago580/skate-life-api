Rails.application.routes.draw do
  resources :skateparks, only: [:index, :show]
  resources :users, only: [:index, :show, :create, :destroy]

  post '/users/:id/favs' => 'favorites#create', as: 'fav'
  delete '/users/:id/favs/:park_id' => 'favorites#destroy', as: 'fav_destroy'
end
