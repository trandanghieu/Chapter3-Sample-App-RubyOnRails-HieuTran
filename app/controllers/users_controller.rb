class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :activated_user, only: [:show]

  def index
    @users = User.activated.paginate(page: params[:page], per_page: 10)
  end

  def new
    @user = User.new
  end

  def show
    @microposts = @user.microposts.paginate(page: params[:page], per_page: 10)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = 'Please check your email to activate your account.'
      redirect_to root_url
    else
      render 'new'
    end
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = 'Please log in.'
    redirect_to login_url
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:success] = 'User deleted' and redirect_to users_url
  end

  def following
    @title = 'Following'
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def correct_user
    redirect_to(root_url) unless @user == current_user
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'User not found.'
    redirect_to users_path
  end

  def activated_user
    redirect_to root_url unless @user.activated?
  end
end
