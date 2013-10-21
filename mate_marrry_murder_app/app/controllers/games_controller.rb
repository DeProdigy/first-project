class GamesController < ApplicationController

  def index
  end

  def new
    friends_array = []
    #get the current user's id from cookies
    user_id = session[:user_id]

    # create_table "users", :force => true do |t|
    # t.string   "provider"
    # t.string   "uid"
    # t.string   "name"
    # t.string   "oauth_token"
    # t.datetime "oauth_expires_at"
    # t.datetime "created_at",       :null => false
    # t.datetime "updated_at",       :null => false

    #retreive the current user from the local database
    user = User.find(user_id)
    #get the user's facebook graph id
    user_fb_id = user.uid
    #get the user's facebook authentication token
    oauth_token = user[:oauth_token]
    #this is where they turn into a player, get all of their facebook information
    player = FbGraph::User.fetch(user_fb_id, :access_token => oauth_token)

    friends = player.fetch.friends

    friends.each do |friend|
      friends_array << friend
    end
      #each friend in the array looks like this:
      # <FbGraph::User:0x007fed4ed7c998 @identifier="558107821",
      # @endpoint="https://graph.facebook.com/558107821",
      # @access_token="CAAUSHbZCDPZCwBAN5iZA6Lp05oeWZAdKfFQVwvU9CzD9rb1BKbeWbnMzv3NZCagOeHZAuNvubgWqp59zys80azsjAaQXugcHGZAi0HhLZCOkNOcGbuLZAdAVVV9CEcuxghnvDKSJjuGhLIjJFkgQQNCiY7DQg7Dsw77bTZBQRb10lfbj1AUjTXMaeu",
      # @raw_attributes={"name"=>"Arseniy Shukin", "id"=>"558107821", "access_token"=>"CAAUSHbZCDPZCwBAN5iZA6Lp05oeWZAdKfFQVwvU9CzD9rb1BKbeWbnMzv3NZCagOeHZAuNvubgWqp59zys80azsjAaQXugcHGZAi0HhLZCOkNOcGbuLZAdAVVV9CEcuxghnvDKSJjuGhLIjJFkgQQNCiY7DQg7Dsw77bTZBQRb10lfbj1AUjTXMaeu"},
      # @cached_collections={},
      # @name="Arseniy Shukin",
      # @first_name=nil,
      # @middle_name=nil,
      # @last_name=nil,
      # @gender=nil,
      # @locale=nil,
      # @link=nil,
      # @username=nil,
      # @third_party_id=nil,
      # @timezone=nil, @verified=nil,
      # @about=nil,
      # @bio=nil,
      # @email=nil,
      # @political=nil,
      # @quotes=nil,
      # @relationship_status=nil,
      # @relationship=nil,
      # @video_upload_limits=nil,
      # @website=nil,
      # @mobile_phone=nil,
      # @installed=nil,
      # @rsvp_status=nil,
      # @security_settings=nil,
      # @currency=nil,
      # @religion=nil,
      # @languages=[],
      # @education=[],
      # @interested_in=[],
      # @favorite_teams=[],
      # @work=[],
      # @devices=[],
      # @sports=[],
      # @favorite_athletes=[],
      # @inspirational_people=[]>

    #
    @player_choice_1 = friends_array.sample
    @player_choice_2 = friends_array.sample
    @player_choice_3 = friends_array.sample
    @player_choice_4 = friends_array.sample
    @player_choice_5 = friends_array.sample

  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

end