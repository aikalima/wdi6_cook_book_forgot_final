class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new()
  end

  def create
    new_user = params.require(:user).permit(:name, :email, :password, :password_confirmation)
    @user=User.new(new_user)
    if @user.save
      flash[:success] = "Welcome to the Cook Book app!"
      sign_in @user
      #UserMailer.welcome_email(@user).deliver
      redirect_to @user
    else
      render'new'
    end
  end

 #get '/reset/:token' => 'user#reset_password'
  def reset_password
    @token = params[:token]
    @user = User.find_by_remember_token @token
    render :reset_password
  end

  #post '/send_reset' => 'user#reset_password'
  def send_reset
    # email in param
    email = params[:email]
    user = User.find_by_email email
    if user.nil?
      flash[:error] = "No such email:" + email
    else
      #UserMailer.forgot_password_email(user).deliver
      flash[:success] = "Please check your email for reset instructions ..."
    end
    render :forgot_password
  end

  def update
    user_params = params.require(:user).permit(:name, :email)
    @user = User.find(user_params[:id])
    @user.update_attributes(name: user_params[:name], email: user_params[:email])
    render :show
  end

end

