Rails.application.routes.draw do
  devise_for :users,controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'sending_destinations', to: 'users/registrations#new_sending_destinations'
    post 'sending_destinations', to: 'users/registrations#create_sending_destinations'
  end
  root to: "items#index"
  resources :items, only:[:show,:new, :create, :edit, :update, :destroy] do
    collection do
      get 'category_children', defaults: { format: 'json' }
      get 'category_grandchildren', defaults: { format: 'json' }
    end
  end
  resources :users, only: [:show]
  resources :cards, only: [:new, :create, :show, :destroy] do
  end
end