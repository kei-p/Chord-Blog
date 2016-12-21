Rails.application.routes.draw do
  root 'entries#index'

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks",
                                    registrations: 'users/registrations',
                                    sessions: 'users/sessions' }

  resources :entries
end
