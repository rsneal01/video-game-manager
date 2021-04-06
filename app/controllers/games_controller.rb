
  class GamesController < ApplicationController

    get '/games' do
        if Helpers.is_logged_in?(session)
            @user = Helpers.current_user(session)
            erb :'/games/games'
        else
            redirect to("/login")
        end
    end

    get '/games/new' do
        if Helpers.is_logged_in?(session)
            erb :'/games/new'
        else
            redirect to("/login")
        end
    end

    post '/games' do
        if Helpers.is_logged_in?(session) && params[:name] != "" && params[:name] != nil
            @user = Helpers.current_user(session)
            # binding.pry
            @game = Game.find_or_create_by(:name => params[:name])
            @game.genre = params[:genre]
            @user.games << @game
            @user.save
            redirect to("/games")
        else
            redirect to("/games/new")
        end
        # may need .authenticate in here
        # checks to make sure current user = user who is creating game
        # does not allow a game to be blank
    end

    get '/games/:id' do
        if Helpers.is_logged_in?(session)
            @game = Game.find_by(params[:id])
            erb :'/games/show_game'
        else
            redirect to("/login")
        end
        # provides a link to edit page
        # provides a link to delete page, delete page will just be a form with submit button to POST to delete /games/:id
        # if not logged in redirect to("/login") 
    end

    get '/games/:id/edit' do
        if Helpers.is_logged_in?(session)
            @game = Game.find_by(params[:id])
            erb :'/games/edit_tweet'
        else
            redirect to("/login")
        end
    end

    patch '/games/:id' do
        # if user owns game :id, lets them edit, else redirects
        # does not let user edit text with blank content
        @user = User.find_by(params[:id])
        @tweet = Tweet.find_by(params[:id])
        if params[:content] != "" && @user.id == @tweet.user_id
            @tweet.update(content: params[:content])
            # @tweet.content = params[:content]
        else
            redirect to("/tweets/#{@tweet.id}/edit")
        end
    end

    delete '/games/:id' do
        # if logged in and game belongs to user, lets user delete their game
        @user = User.find_by(params[:id])
        @game = Game.find_by(params[:id])
        if Helpers.is_logged_in?(session) && @game.user_id == @user.id
            @game.delete
        else
            # if not logged in redirect to("/login")
            redirect to("/login")
        end
    end

end
