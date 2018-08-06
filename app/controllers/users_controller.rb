class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(show new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: %i(destroy)
  before_action :load_user, except: %i(new index create)

  def new
    @user = User.new
  end

  def index
    @users = User.things.order_by_name.
      page(params[:page]).per Settings.per_page
  end

  def show
    @microposts = @user.microposts.latest
      .page(params[:page]).per Settings.per_page
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t ".check_email"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".success_message"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".deleted"
    else
      flash[:danger] = t ".delete_error"
    end
    redirect_to users_url
  end

  def following
    @title = t ".following"
    @users = @user.following.page(params[:page]).per Settings.per_page
    render :show_follow
  end

  def followers
    @title = t ".followers"
    @users = @user.followers.page(params[:page]).per Settings.per_page
    render :show_follow
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def correct_user
    @user = User.find_by id: params[:id]
    return if current_user? @user
    flash[:danger] = t ".not_correct_user"
    redirect_to root_url
  end

  def admin_user
    return if current_user.admin?
    flash[:danger] = t ".not_admin"
    redirect_to root_url
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t ".notfound"
    redirect_to root_url
  end
end
