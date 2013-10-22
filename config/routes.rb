Thebigshake::Application.routes.draw do
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  root 'home#index'

  resources :bands, only: [:show]

end
