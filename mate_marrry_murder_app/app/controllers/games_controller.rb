class GamesController < ApplicationController

  def index
    #@games_all = []
    if session[:user_id]
      @current_user_session = session[:user_id]

      current_user_db = User.find(@current_user_session)
      @games_started = Game.order("created_at DESC").where(player_1: current_user_db.uid)
      @games_in = Game.order("created_at DESC").where(player_2: current_user_db.uid)
      # @games_all << games_started
      # @games_all << games_in
    end

    #<Game id: 59, player_1: "806667714", player_2: "1301303370", created_at: "2013-10-23 19:06:43", updated_at: "2013-10-23 19:06:43", gender: "female", player_1_name: "Alex Hint", player_2_name: "Alex Rogozin">]

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
    # #this is where they turn into a player, get all of their facebook information
    # player = FbGraph::User.fetch(user_fb_id, :access_token => oauth_token)

    @graph = Koala::Facebook::API.new(oauth_token)

    profile = @graph.get_object("me")

    #graph.get_connections("me", "friends", "fields"=>"name,birthday,gender")  (name,id,gender,username)
    friends = @graph.get_connections("me", "friends", "fields" => "name,id,gender,username")

    # three-part queries are easy too!
    #@graph.get_connections("me", "mutualfriends/#{friend_id}")


    friends.each do |friend|
      friends_array << friend
    end

    #DONT LET PEOPLE WITH LESS THAN 20 MUTUAL FRIENDS, TO BE DISPLAYED
    # !!! loop that will get the mutual friends, check the amount and don't show the person unless mutual friends are more than
    # mutual_friends_count = 0
    # if mutual_friends_count < 20
    #   while mutual_friends_count < 20
    #     @player_choice_1 = friends_array.sample

    #     player_2_id = @player_choice_1["id"]
    #     @graph = Koala::Facebook::API.new(oauth_token)

    #     friend_id = player_2_id
    #     mutual_friends = @graph.get_connections("me", "mutualfriends/#{friend_id}")
    #     mutual_friends_count = mutual_friends.length
    #   end
    # else
    #   @player_choice_1 = friends_array.sample
    # end

    # mutual_friends_count = 0
    # if mutual_friends_count < 20
    #   while mutual_friends_count < 20
    #     @player_choice_2 = friends_array.sample

    #     player_2_id = @player_choice_1["id"]
    #     @graph = Koala::Facebook::API.new(oauth_token)

    #     friend_id = player_2_id
    #     mutual_friends = @graph.get_connections("me", "mutualfriends/#{friend_id}")
    #     mutual_friends_count = mutual_friends.length
    #   end
    # else
    #   @player_choice_2 = friends_array.sample
    # end

    # mutual_friends_count = 0
    # if mutual_friends_count < 20
    #   while mutual_friends_count < 20
    #     @player_choice_3 = friends_array.sample

    #     player_2_id = @player_choice_1["id"]
    #     @graph = Koala::Facebook::API.new(oauth_token)

    #     friend_id = player_2_id
    #     mutual_friends = @graph.get_connections("me", "mutualfriends/#{friend_id}")
    #     mutual_friends_count = mutual_friends.length
    #   end
    # else
    #   @player_choice_3 = friends_array.sample
    # end

    # mutual_friends_count = 0
    # if mutual_friends_count < 20
    #   while mutual_friends_count < 20
    #     @player_choice_4 = friends_array.sample

    #     player_2_id = @player_choice_1["id"]
    #     @graph = Koala::Facebook::API.new(oauth_token)

    #     friend_id = player_2_id
    #     mutual_friends = @graph.get_connections("me", "mutualfriends/#{friend_id}")
    #     mutual_friends_count = mutual_friends.length
    #   end
    # else
    #   @player_choice_4 = friends_array.sample
    # end

    # mutual_friends_count = 0
    # if mutual_friends_count < 20
    #   while mutual_friends_count < 20
    #     @player_choice_5 = friends_array.sample

    #     player_2_id = @player_choice_1["id"]
    #     @graph = Koala::Facebook::API.new(oauth_token)

    #     friend_id = player_2_id
    #     mutual_friends = @graph.get_connections("me", "mutualfriends/#{friend_id}")
    #     mutual_friends_count = mutual_friends.length
    #   end
    # else
    #   @player_choice_5 = friends_array.sample
    # end

    #every users looks like this: {"id"=>"13617126", "gender"=>"female", "name"=>"Olga Safronova", "username"=>"olga.safronova.180"}


    unique_friend_array = friends_array.sample(5)
    @player_choice_1 = unique_friend_array[0]
    @player_choice_2 = unique_friend_array[1]
    @player_choice_3 = unique_friend_array[2]
    @player_choice_4 = unique_friend_array[3]
    @player_choice_5 = unique_friend_array[4]

    @player_1 = user_fb_id
    @player_1_name = profile["name"]

  end

  def create

    game = params[:game]
    player_1 = game[:player_1]
    player_2 = game[:player_2]
    gender = game[:gender]
    params[:game][:player_1_name]
    player_1_name = game[:player_1_name]

    player_1_from_db = User.where(uid: player_1).last
    player_1_oauth_token = player_1_from_db[:oauth_token]

    @graph = Koala::Facebook::API.new(player_1_oauth_token)

    friend_id = player_2
    player_2_from_api = @graph.get_connections("me", "friends/#{friend_id}", "fields" => "name")
    player_2_name = player_2_from_api.first["name"]


    new_game = Game.new
    new_game.player_1 = player_1
    new_game.player_2 = player_2
    new_game.player_1_name = player_1_name
    new_game.player_2_name = player_2_name
    new_game.gender = gender
    new_game.save

    redirect_to("/games/#{new_game.id}/edit")
  end

  def show

    game_id = params[:id]
    game = Game.where(id: game_id).first
    choices = Choice.where(game_id: game_id).first

    #if is player 1
    current_player= game.player_1

    @other_player = game.player_2
    @other_player_name = game.player_2_name
    #right code for, if is player 2.... !!!!!

    #pull that specific person from API
    #given_3.split(', ')
    #getting a string...turnin into an array
    @given_1 = choices[:given_1].split(', ')
    @answered_1 = choices[:answered_1]

    @given_2 = choices[:given_2].split(', ')
    @answered_2 = choices[:answered_2]

    @given_3 = choices[:given_3].split(', ')
    @answered_3 = choices[:answered_3]

    #given = ["female", "Kamila Podvisotskaya", "kamila.podvisotskaya", "1103693780"]

    @game_id = choices[:game_id]

  end

  def edit # TODO WEEKEND, this hsould not be 'edit' this should be 'new' for choices
    @choice = Choice.new
    #params => {"action"=>"edit", "controller"=>"games", "id"=>"12"}
    game_id = params[:id]
    game = Game.find(game_id)
    #<Game id: 12, player_1: "806667714", player_2: "1376919385", created_at: "2013-10-22 21:29:57", updated_at: "2013-10-22 21:29:57", gender: "female">
    gender = game.gender
    player_1_id = game.player_1
    player_2_id = game.player_2

    player_1 = User.where(:uid => player_1_id).first
    #<User id: 2, provider: "facebook", uid: "806667714", name: "Alex Hint", oauth_token: "CAAUSHbZCDPZCwBAOYotzuXZCZA8KR58bnR4ONBw71B513f95Es...", oauth_expires_at: "2013-10-22 21:59:59", created_at: "2013-10-20 22:42:34", updated_at: "2013-10-22 20:20:56">
    oauth_token = player_1.oauth_token

    @graph = Koala::Facebook::API.new(oauth_token)

    friend_id = player_2_id
    mutual_friends = @graph.get_connections("me", "mutualfriends/#{friend_id}", "fields" => "username,gender,name")  #(username,gender,name) , "fields" => "name,id,gender,username")

    mutual_friends_male = []
    mutual_friends_female = []

    mutual_friends.each do |friend|
      if friend["gender"] == "male"
        mutual_friends_male << friend
      else
        mutual_friends_female << friend
      end
    end

    #check if male or female
    if gender == "male"
      mutual_friends_base = mutual_friends_male
    else
      mutual_friends_base = mutual_friends_female
    end

    #if less than 3 mutual friends, redirect back
    if mutual_friends_base.length > 3
      unique_friend_array = mutual_friends_base.sample(3)
      @random_person_1 = unique_friend_array[0]
      @random_person_2 = unique_friend_array[1]
      @random_person_3 = unique_friend_array[2]
    else
      flash[:notice] = "Weak sauce, not enough mutual mates"
      redirect_to(new_game_path)
    end

    #stick three choices into the array to render out with .sample(3) to have 3 unique people

    @user_1_id = player_1_id

  end

  def update # TODO same fix as edit

    if (params[:choice][:answered_1] == params[:choice][:answered_2]) || (params[:choice][:answered_2] == params[:choice][:answered_3]) || (params[:choice][:answered_1] == params[:choice][:answered_3])

      redirect_to :back, :notice => "BRAH, One choice per person! Here's some fresh ones."


    else
      choice = params[:choice]

      given_1_unparsed_rocker = choice[:given_1]
      answered_1 = choice[:answered_1]

      given_2_unparsed_rocker = choice[:given_2]
      answered_2 = choice[:answered_2]

      given_3_unparsed_rocker = choice[:given_3]
      answered_3 = choice[:answered_3]

      user_id = choice[:user_id]

      game_id = params[:id]

      given_1_unparsed = given_1_unparsed_rocker.gsub("=>", ": ")
      given_1_to_s = Yajl::Parser.parse(given_1_unparsed)
      given_1 = given_1_to_s.values.join(', ')

      given_2_unparsed = given_2_unparsed_rocker.gsub("=>", ": ")
      given_2_to_s = Yajl::Parser.parse(given_2_unparsed)
      given_2 = given_2_to_s.values.join(', ')

      given_3_unparsed = given_3_unparsed_rocker.gsub("=>", ": ")
      given_3_to_s = Yajl::Parser.parse(given_3_unparsed)
      given_3 = given_3_to_s.values.join(', ')

      new_choice = Choice.new
      new_choice.given_1 = given_1
      new_choice.answered_1 = answered_1
      new_choice.given_2 = given_2
      new_choice.answered_2 = answered_2
      new_choice.given_3 = given_3
      new_choice.answered_3 = answered_3
      new_choice.user_id = user_id
      new_choice.game_id = game_id
      new_choice.save

      redirect_to(game_path)
    end
  end

  def destroy
  end

end

