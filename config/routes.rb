Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "questions#index"
  resources :questions, except: :edit
 
  resources :emails, only: [:new, :create]
 
  get 'answers/new/:user_id', to: 'answers#new', as: :new_answer
  post 'answer', to: 'answers#create', as: :answer
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions' 
  }
end
