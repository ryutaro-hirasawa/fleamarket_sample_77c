Rails.application.routes.draw do
  devise_for :users,controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'sending_destinations', to: 'users/registrations#new_sending_destinations'
    post 'sending_destinations', to: 'users/registrations#create_sending_destinations'
  end
  root to: "home#index"
  resource :items, only:[:new, :create] do
  end
  root 'items#index'
  resources :items, except: :show
  resources :users, :only => [:show]
end