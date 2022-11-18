# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :user, only: %i[update]

  def index
    @users = User.all.order(created_at: :desc).page(params[:page]).per(5)
    authorize @users
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    authorize @user
    if user.update(user_params)
      redirect_to users_path, notice: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user
    @user ||= User.find(params[:id])
  end

  def user_params
    params.require(:user).permit({ role_ids: [] })
  end
end
