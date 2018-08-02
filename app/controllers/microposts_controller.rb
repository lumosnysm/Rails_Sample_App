class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build micropost_params
    if @micropost.save
      flash[:success] = t ".created"
    else
      @feed_items = []
    end
    redirect_to root_url
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t ".deleted"
    else
      flash[:danger] = t ".delete_error"
    end
    redirect_to request.referrer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit :content, :picture
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    return if @micropost
    flash[:danger] = t ".not_correct_user"
    redirect_to root_url
  end
end
