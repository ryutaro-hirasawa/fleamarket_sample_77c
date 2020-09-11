Rails.application.routes.draw do
  devise_for :users,controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'sending_destinations', to: 'users/registrations#new_sending_destinations'
    post 'sending_destinations', to: 'users/registrations#create_sending_destinations'
  end
  root to: "items#index"
  resources :users, :only => [:show]
  resources :items, :only => [:show]
end