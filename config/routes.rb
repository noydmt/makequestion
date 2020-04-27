Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions' 
  }
  
  devise_scope :user do
    root to: "users/sessions#new", as: :new_login
    get "signup", :to =>"users/registrations#new", as: :new_signup
  end

end
