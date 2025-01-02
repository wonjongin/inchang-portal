class Api::V1::UserController < ApplicationController
  include AuthRequest
  before_action :current_user

  def list
    @users = User.all
  end

  def edit
    @user = User.find(params[:user_id])
  end

  def update
    user = User.find(params[:user_id])
    user.update(
      name: params[:name],
      hire_date: params[:hire_date],
      status: params[:status],
      position: params[:position]
    )
    render json: {
      status: :ok,
      message: 'Success!',
      code: :success,
      user_id: user.id
    }
  end
end
