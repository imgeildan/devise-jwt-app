Rails.application.routes.draw do
  devise_for :users,
           controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
           }
  get '/member-data', to: 'members#show'
  resources :goals, only: %w[index create show]
  resources :key_results, only: %w[index create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
