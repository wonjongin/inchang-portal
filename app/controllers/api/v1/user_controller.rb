class Api::V1::UserController < ApplicationController
  include AuthRequest
  before_action :current_user

  def list
    @users = User.all
    @hashs = [
      { name: '이름', render: lambda(&:name), class_name: 'text-center' },
      { name: '사번', render: lambda(&:eid), class_name: 'text-center' },
      { name: '입사일', render: lambda(&:hire_date), class_name: 'text-center' },
      { name: '상태', render: lambda(&:status_kr), class_name: 'text-center' },
      { name: '직급', render: lambda(&:position), class_name: 'text-center' },
      { name: '수정', render: ->(row) { helpers.link_to '✏️', "/api/v1/user/edit/#{row.id}" }, class_name: 'text-center' }
    ]
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
      position: params[:position],
      eid: params[:eid]
    )
    render json: {
      status: :ok,
      message: 'Success!',
      code: :success,
      user_id: user.id
    }
  end
end
