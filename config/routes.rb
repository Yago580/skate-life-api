Rails.application.routes.draw do
  resources :skateparks, only: [:index, :show]
end
