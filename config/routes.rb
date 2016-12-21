Rails.application.routes.draw do
  resources :entries
  devise_for :authors, path_names: { sign_in: "login", sign_out: "logout"},
    controllers: { omniauth_callbacks: "users/omniauth_callbacks", registrations: 'users/registrations', sessions: 'users/sessions' }
  root 'entries#index'
end
