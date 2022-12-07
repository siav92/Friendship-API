Rails.application.routes.draw do
  # Registration
  post '/signup', to: 'registration#signup'
  post '/login', to: 'registration#login'

  resources :friendships, only: %i[destroy]

  get '/users/me/friends' => 'users#friends'
  post '/users/:email/friendship' => 'friendships#create', :constraints => { email: /.+@.+\..*/ }
end
