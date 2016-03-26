Rails.application.routes.draw do
  devise_for :users

  resource :state, only: [:show]

  root to: 'pages#index'
end
