Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :kinds

  scope module: 'v1' do
    resources :contacts, :constraints => lambda { |request| request.params[:version] == "1"}
  end

  scope module: 'v2' do
    resources :contacts, :constraints => lambda {|request| request.params[:version] = "2"}
  end

  #From Contacts
  # get "/contacts", to: "contacts#index"
  # get "/contacts/:id", to: "contacts#show"
  # post "/contacts", to: "contacts#create"
  # patch "/contacts/:id", to: "contacts#update"
  #
  # #From Addresses
  # get "/contacts/:id/address", to: "addresses#show"
  # delete "/contacts/:id/address/:id", to: "addresses#destroy"
  #
  # #From Phones
  # get "/contacts/:id/phones", to: "phones#show"
  # delete "/contact/:id/phones/:id", to: "phones#destroy"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
