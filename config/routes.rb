Rails.application.routes.draw do
  # Registration
  post '/signup', to: 'registration#signup'
  post '/login', to: 'registration#login'

  # Users and Friendships
  get '/users/me/friends' => 'users#friends'
  post '/users/:email/friendship' => 'friendships#create', :constraints => { email: /.+@.+\..*/ }
  patch '/users/:email/friendship/accept' => 'friendships#accept', :constraints => { email: /.+@.+\..*/ }
  patch '/users/:email/friendship/unfriend' => 'friendships#unfriend', :constraints => { email: /.+@.+\..*/ }

  # Notes
  resources :notes, only: %i[create update destroy]
end
