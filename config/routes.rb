Rails.application.routes.draw do
  resources :skateparks, only: [:index, :show]
  resources :users, only: [:index, :show, :create, :destroy]

  post '/favorites' => 'favorites#create'
  delete '/favorite/:user_id/:skatepark_id' => 'favorites#destroy'
end
