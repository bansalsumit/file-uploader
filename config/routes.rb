Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"

  devise_for :users

  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
    get 'sign_up', to: 'devise/registrations#new'
    get '/sign_out', to: 'devise/sessions#destroy', as: :signout
  end

  resources :attachments, only: [:index, :new, :create, :destroy]
  get 'files/:link_id', to: 'attachments#link'
end
