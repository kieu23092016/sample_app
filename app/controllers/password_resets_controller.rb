class PasswordResetsController < ApplicationController
  before_action :get_user, :valid_user, :check_expiration, only: %i(edit update)

  def new; end

  def edit; end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t("text.password_reset_noti")
      redirect_to root_url
    else
      flash.now[:danger] = t("text.email_notfound")
      render :new
    end
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, t("text.empty_error"))
      render :edit
    elsif @user.update(user_params)
      log_in @user
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = t "text.reset_password_noti"
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user
    @user = User.find_by(email: params[:email])
    return if @user

    store_location
    flash[:danger] = t("text.user_notfound")
    redirect_to new_password_reset_path
  end

  def valid_user
    return if @user && @user.activated? && @user.authenticated?(:reset,
                                                                params[:id])

    flash[:danger] = t("text.invalid_activate_link")
    redirect_to root_url
  end

  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = t("text.reset_password_expired")
    redirect_to new_password_reset_url
  end
end
