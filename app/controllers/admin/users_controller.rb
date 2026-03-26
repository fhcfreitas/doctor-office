class Admin::UsersController < ApplicationController
  before_action :require_authentication
  before_action :require_admin!

  def show
    @user = Current.user
  end

  def edit
    @user = Current.user
  end

  def update
    @user = Current.user
    if @user.update(user_params)
      redirect_to edit_admin_user_path, flash: { success: "User updated." }
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    user = Current.user
    user.destroy
    redirect_to admin_root_path, notice: "User deleted."
  end

  private

  def user_params
    permitted = params.require(:user).permit(
      :email_address, :password, :password_confirmation,
      :name, :bio, :city, :state, :specialty
    )

    if permitted[:password].blank?
      permitted.except(:password, :password_confirmation)
    else
      permitted
    end
  end
end
