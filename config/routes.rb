Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }
  root 'videos#index'

  resources :videos, only: %i[index show]
end
