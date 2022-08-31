class FollowingController < ApplicationController
  before_action :logged_in_user, :find_by_id

  def index
    @title = t "text.followersU"
    @pagy, @users = pagy @user.following,
                         items: Settings.pagination.user_per_page
    render "users/show_follow"
  end
end
