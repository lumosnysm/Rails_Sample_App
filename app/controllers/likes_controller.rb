class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    @post = Micropost.find_by id: params[:micropost_id]
    current_user.like @post
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @post = Like.find_by(id: params[:id]).micropost
    current_user.unlike @post
    respond_to do |format|
      format.js
    end
  end
end
