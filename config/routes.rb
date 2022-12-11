Rails.application.routes.draw do
  # Registration
  post '/signup', to: 'registration#signup'
  post '/login', to: 'registration#login'

  # Users and Friendships
  resources :users, only: %i[index]
  get '/users/me/friends' => 'users#friends'
  post '/users/:email/friendship' => 'friendships#create', :constraints => { email: /.+@.+\..*/ }
  patch '/users/:email/friendship/accept' => 'friendships#accept', :constraints => { email: /.+@.+\..*/ }
  patch '/users/:email/friendship/unfriend' => 'friendships#unfriend', :constraints => { email: /.+@.+\..*/ }

  # Notes
  resources :notes, only: %i[create update destroy]

  # Labels
  resources :labels, only: %i[create update destroy index]
end
