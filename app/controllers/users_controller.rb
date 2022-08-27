class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(show new create)
  before_action :find_by_id, except: %i(new create index)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: %i(destroy)

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = t "text.activation_msg"
      redirect_to @user
    else
      flash.now[:danger] = t "text.sign_up_failed"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = t("text.success_update")
      redirect_to @user
    else
      flash.now[:danger] = t("text.fail_update")
      render :edit
    end
  end

  def index
    @pagy, @users = pagy User.order_by_update,
                         items: Settings.pagination.user_per_page
  end

  def destroy
    if @user.destroy
      flash[:success] = t("text.success_delete")
      redirect_to users_url
    else
      flash[:danger] = t("text.fail_delete")
    end
  end
  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def correct_user
    return if current_user?(@user)

    flash[:danger] = t "text.unauthorized_msg"
    redirect_to(root_url)
  end

  def admin_user
    return if current_user.admin

    flash[:danger] = t "text.unauthorized_msg"
    redirect_to(root_url)
  end

  def find_by_id
    @user = User.find_by(id: params[:id])
    return if @user

    flash[:danger] = t "text.user_not_found"
    redirect_to root_path
  end

  def logged_in_user
    return logged_in?
    store_location
    flash[:danger] = t("text.login_required")
    redirect_to login_url
  end
end
