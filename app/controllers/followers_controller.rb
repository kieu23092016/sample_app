class FollowersController < ApplicationController
  before_action :logged_in_user, :find_by_id
  def index
    @title = t "text.followingU"
    @pagy, @users = pagy @user.followers,
                         items: Settings.pagination.user_per_page
    render "users/show_follow"
  end
end
