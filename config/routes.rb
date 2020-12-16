Rails.application.routes.draw do
  get '/auth/spotify/redirect', to: 'spotify#redirect'
  get '/auth/spotify/callback', to: 'spotify#callback'
  get '/home', to: 'spotify#index'

  root 'spotify#index'
end
