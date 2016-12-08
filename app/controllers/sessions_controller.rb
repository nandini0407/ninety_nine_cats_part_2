class SessionsController < ApplicationController

  def new
    if current_user
      redirect_to cats_url
    else
      render :new
    end
  end

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if @user.nil?
      flash.now[:messages] = ["Invalid username or password"]
      render :new
    else
      @user.reset_session_token!
      login(@user)
      
      redirect_to cats_url
    end
  end

  def destroy
    if current_user
      logout
    end
    redirect_to new_session_url
  end

  private

  def session_params
    params.require(:session).permit(:username, :password, :session_token)
  end

end
