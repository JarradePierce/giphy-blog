Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :blogs do
    resources :users, only: [:index, :show]
  end

  resources :users do
    resources :blogs, only: [:edit, :update, :destroy, :show, :create, :new, :index]
    resources :categories, only: [:show, :create, :update, :destroy, :edit, :new, :index]
  end

  resources :sessions, only: [:create, :new, :destroy]

  delete '/logout' => 'sessions#destroy'
  post '/login' => 'sessions#create'
  get '/login' => 'sessions#new'

  root "users#new"
end
