Thebigshake::Application.routes.draw do
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  root 'home#index'

  resources :bands, only: [:show]

  get 'project', to: 'home#project'
  get 'team', to: 'home#team'
  get 'comments', to: 'home#comments'

end
