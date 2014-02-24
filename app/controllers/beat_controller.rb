class BeatController < ApplicationController
  def index
    @matches = {}
    @users = User.all
    for user in @users
      for otherUser in @users
        if !(user == otherUser || user.level == 0)
          if (user.level == otherUser.level)
	    @matches[user.id] = otherUser.id
	    @users.delete user
	    @users.delete otherUser
	  end
	end
      end
    end  
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end
  def beaten
    @winner = User.find_by_id(params[:winner])
    @loser = User.find_by_id(params[:loser])
    @winner.level += 1
    @loser.level = 0
    @winner.save
    @loser.save
  end
end
