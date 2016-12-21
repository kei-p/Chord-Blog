class Users::RegistrationsController < Devise::RegistrationsController
  http_basic_authenticate_with name: ENV['BASIC_AUTH_USERNAME'] || 'admin', password: ENV['BASIC_AUTH_PASSWORD'] || 'password'
end
