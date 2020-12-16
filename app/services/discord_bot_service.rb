require 'discordrb'
require 'opus-ruby'
require 'ffi'

include Rails.application.routes.url_helpers

class DiscordBotService

  def self.call(authorization)
    new(authorization).call
  end

  def initialize(authorization)
    @bot = Discordrb::Commands::CommandBot.new token: ENV['BOT_TOKEN'], client_id: ENV['CLIENT_ID'], prefix: '>'
    # @admin = RSpotify::User.new(authorization)
    # @player = @admin.player

    at_exit { @bot.stop }
  end

  def call
    call_glider
    music_player

    @bot.run(true)
  end

  private

  def call_glider
    @bot.message(containing: [/(?i)глайдер/, /(?i)глидер/, /(?i)glider/, /(?i)lifeglider/]) do |event|
      event.send_file File.open('app/assets/images/1432896573721.gif', 'r')
    end
  end

  def music_player
    @bot.command(:play) do |event|
      song = event.message.content.split(' ')[1]
      if event.author.voice_channel
        event.respond "Погнали!"
        # @player.play_context(nil, song)
        @bot.voice_connect(event.author.voice_channel, false)
        event.voice.play_file('app/assets/media/cyberpunk_2077_01 - Marcin Przybylowicz - V.mp3')
      else
        event.respond "Шо ты, отэто именно, грузишь меня? #{ event.author.name }"
      end
    end

    @bot.command(:stop) do |event|
      event.respond "Тормозим!"
    end
  end
end
