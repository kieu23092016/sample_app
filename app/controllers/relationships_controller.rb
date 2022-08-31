class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :find_followed_user, only: :create
  before_action :load_relationship, :load_followed_user, only: :destroy
  def create
    current_user.follow(@user)
    redirect_to @user
  end

  def destroy
    current_user.unfollow(@user)
    redirect_to @user
  end

  private

  def find_followed_user
    @user = User.find_by id: params[:followed_id]
    return if @user
    flash[:danger] = t("text.user_notfound")
    redirect_to users_url
  end

  def load_relationship
    @relationship = Relationship.find_by(id: params[:id])
    return if @relationship
    flash[:danger] = t("text.relationship_notfound")
    redirect_to users_url
  end

  def load_followed_user
    @user = @relationship.followed
    return if @user
    flash[:danger] = t("text.user_notfound")
    redirect_to users_url
  end
end
