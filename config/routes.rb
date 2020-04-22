Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users, skip: :all

  devise_scope :user do
    root to: "users/sessions#new", as: :new_user_session
    get "sign_up", :to => "users/registrations#new", as: :new_user_registration
    post "sign_up", :to => "users/registrations#create", as: :user_registration
    get "sign_out", :to => "users/sessions#destroy", as: :destroy_user_session
    get "password/new", :to => "users/password#new", as: :new_user_password
  end

end
