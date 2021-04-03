class Helpers < ActiveRecord::Base
    def self.current_user(session)
        # user = User.find_by(id: session[:user_id])
        User.find(session[:user_id]) if session[:user_id]
        user
    end

    def self.is_logged_in?(session)
        if current_user(session) == nil
            false
        elsif current_user(session).id == session[:user_id]
            true
        end
    end

    end
