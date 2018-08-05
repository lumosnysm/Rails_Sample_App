class SearchController < ApplicationController
  def index
    @search_key = params[:search]
    @users = User.search(params[:search]).
      page(params[:page]).per Settings.per_page
  end
end
