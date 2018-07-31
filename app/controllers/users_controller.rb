class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(show new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: %i(destroy)
  before_action :load_user, only: %i(show edit update destroy)

  def new
    @user = User.new
  end

  def index
    @users = User.things.order_by_name.
      page(params[:page]).per Settings.per_page
  end

  def show; end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      UserMailer.account_activation(@user).deliver_now
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

  private

    def user_params
      params.require(:user).permit :name, :email, :password,
      :password_confirmation
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = t ".login_message"
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find_by id: params[:id]
      redirect_to root_url unless current_user? @user
    end

    def admin_user
      redirect_to root_url unless current_user.admin?
    end

    def load_user
      @user = User.find_by id: params[:id]
      return if @user
      flash[:danger] = t ".notfound"
      redirect_to root_url
    end
end
