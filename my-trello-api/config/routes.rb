Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  # resources :boards
  resources :tasks
  #
  # resources :lists do
  #   resource :task, except: [:destroy]#only: [:show, :create, :update]
  # end
  #
  # resources :boards do
  #   resource :list, only: [:show, :update, :create] do
  #     resource :task, except: [:destroy]
  #   end
  # end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "boards#index"


  #FROM BOARDS
  get "boards/:id", to: "boards#show"
  post "boards", to: "boards#create"
  patch "boards/:id", to: "boards#update"
  delete "boards/:id", to: "boards#destroy"

  # FROM LISTS
  post "boards/:id/lists", to: "lists#create"
  get "lists/:id", to: "lists#show"
  patch "lists/:id", to: "lists#update"

  # FROM TASKS
  post "boards/:id/lists/task", to: "tasks#create"
  get "tasks/:id", to: "tasks#show"
  patch "tasks/:id", to: "tasks#update"
  delete "tasks/:id", to: "tasks#destroy"

  #FROM USERS
  post "auth", to: "devise_token_auth/registrations#create" # Create user
  post "auth/sign_in", to: "devise_token_auth/sessions#create" # Login of user

end
