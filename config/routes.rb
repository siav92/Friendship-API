Rails.application.routes.draw do
  resources :users
  post '/signup', to: 'registration#signup'
  post '/login', to: 'registration#login'
  post '/users/:email/friendship' => 'friendships#create', :constraints => { email: /.+@.+\..*/ }
  get '/users/me/friends' => 'users#friends'
end
