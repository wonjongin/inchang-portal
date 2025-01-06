class Api::V1::VacationsController < ApplicationController
  include AuthRequest
  before_action :current_user

  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::NumberHelper
  include ActionView::Context

  ## 엑셀 형식과 같은 테이블 형태
  def index
    year = params[:year].blank? ? Date.today.year : params[:year].to_i
    @users = User.where(status: :employed)
    @hashs = [
      { name: '이름', render: lambda(&:name), class_name: 'text-center' },
      { name: '입사일', render: lambda(&:hire_date), class_name: 'text-center' },
      { name: '발생연차', render: ->(user) { user.total_vacations_in(year) }, class_name: 'text-center' },
      { name: '사용연차', render: lambda { |user|
        number_with_precision(user.used_vacations_in(year), strip_insignificant_zeros: true)
      }, class_name: 'text-center' },
      { name: '잔여연차', render: lambda { |user|
        number_with_precision(user.remaining_vacations_in(year), strip_insignificant_zeros: true)
      }, class_name: 'text-center' },
      { name: '연차사용현황', render: lambda { |user|
        tag.table(class: 'table table-bordered') do
          tag.tbody do
            tag.tr do
              capture do
                user.vacation_histories_array_in(year).each do |vacation|
                  # start_date = vacation.start_date&.strftime('%-m/%-d') || ''
                  # end_date = vacation.end_date&.strftime('%-m/%-d') || ''
                  concat(
                    tag.td(class: 'text-center') do
                      tag.div("#{vacation[:date]}") +
                      tag.div("#{vacation[:type]}")
                    end
                  )
                end
              end
            end
          end
        end
      }, class_name: 'text-center' }
    ]
  end

  def list
    @vacation_histories = VacationHistory.all
    @hashs = [
      { name: '이름', render: ->(row) { row.user.name }, class_name: 'text-center' },
      { name: '사유', render: lambda(&:reason), class_name: 'text-center' },
      { name: '승인여부', render: lambda(&:is_approved), class_name: 'text-center' },
      { name: '시작일', render: lambda(&:start_date), class_name: 'text-center' },
      { name: '종료일', render: lambda(&:end_date), class_name: 'text-center' },
      { name: '휴가타입', render: lambda(&:vacation_type_kr), class_name: 'text-center' },
      { name: '수정', render: lambda { |row|
        helpers.link_to '✏️', "/api/v1/vacations/edit/#{row.id}"
      }, class_name: 'text-center' },
      { name: '삭제', render: lambda { |row|
        helpers.link_to '❌', "/api/v1/vacations/delete/#{row.id}"
      }, class_name: 'text-center' }
    ]
  end

  def detail
  end

  def new
  end

  def create
    v = VacationHistory.create(
      user: @current_user,
      reason: params[:reason],
      is_approved: false,
      start_date: params[:start_date],
      end_date: params[:end_date],
      vacation_type: params[:vacation_type]
    )

    render json: {
      status: :ok,
      message: 'Success!',
      code: :success,
      vacation_id: v.id
    }
  end

  def edit
    @vacation = VacationHistory.find(params[:vacation_id])
  end

  def update
    v = VacationHistory.find(params[:vacation_id])
    v.update(
      reason: params[:reason],
      start_date: params[:start_date],
      end_date: params[:end_date],
      vacation_type: params[:vacation_type]
    )

    render json: {
      status: :ok,
      message: 'Success!',
      code: :success,
      vacation_id: v.id
    }
  end

  def approve
    v = VacationHistory.find(params[:vacation_id])
    v.update(is_approved: true)

    render json: {
      status: :ok,
      message: 'Success!',
      code: :success,
      vacation_id: v.id
    }
  end

  def delete
  end
end
