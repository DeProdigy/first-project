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

    @player_1 = user_fb_id



    # url = "graph.facebook.com/#{user_id}/friends/#{@player_choice_1.identifier}?fields=mutualfriends.fields(gender,name)&access_token=CAACEdEose0cBACh8Ok5U0ZBC6AlSafxDkIZCgGjyMeMSBDAa5LyGzn4YsuEZAO3xpndFPJMs9NL7CEjxZBzbCopvCC0pgVh9CKOuoSHVWI8y6i2rEjV3p3rZCsMZBNpKFkjTEOZBZAg4bwizIIUPVAQe2SziXBErDAtNM07s5GgMWY70tBvYB7i53Sm8E5lU8N4ZD"

    # fql_2 = "SELECT name, mutual_friends FROM user WHERE uid IN(SELECT uid2 FROM friend WHERE uid1=me())"
    # fql = "SELECT uid, first_name, last_name, pic_small FROM user WHERE uid IN (SELECT uid2 FROM friend WHERE uid1 = 638291797) AND uid IN (SELECT uid2 FROM friend WHERE uid1 = 806667714)"

    # #mutual_friends = FbGraph::Query.new(fql_2).fetch(:access_token => oauth_token)

    # # queries = '{"user_friends":"SELECT uid2 FROM friend WHERE uid1 = 638291797",
    # # "mutual_friends":"SELECT uid1, uid2 FROM friend WHERE uid1 IN (SELECT uid2 FROM #{user_friends}) AND uid2 IN (SELECT uid2 FROM #user_friends)"}';
    # mutual_friends = HTTParty.get('url')
    # raise
  end

  def create
    game = params[:game]
    player_1 = game[:player_1]
    player_2 = game[:player_2]
    gender = game[:gender]

    new_game = Game.new
    new_game.player_1 = player_1
    new_game.player_2 = player_2
    new_game.gender = gender
    new_game.save

    redirect_to("/games/#{new_game.id}/edit")
  end

  def show
  end

  def edit
    @choice = Choice.new

    # @graph = Koala::Facebook::API.new(oauth_token)

    # friend_id = 'the_friend_id'
    # @graph.get_connections("me", "mutualfriends/#{friend_id}")

    @random_person_1 = "Maya"
    @random_person_2 = "Mika"
    @random_person_3 = "Jules"
  end

  def update
    choice = params[:choice]


  end

  def destroy
  end

end