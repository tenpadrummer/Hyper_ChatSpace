Rails.application.routes.draw do
  devise_for :users
  root "groups#index"
  resources :users, only: [:index, :edit, :update]
  resources :groups, only: [:new, :create, :edit, :update] do
    resources :messages, only: [:index, :create]
    namespace :api do
      resources :messages, only: [:index]
    end
    collection do
      put "show_last_message"
    end
  end
end
