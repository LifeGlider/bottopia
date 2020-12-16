class SpotifyController < ApplicationController
  def redirect
    redirect_to '/auth/spotify'
  end

  def callback
    authorization = request.env['omniauth.auth']
    DiscordBotService.call(authorization)
  end

  def index
  end
end
