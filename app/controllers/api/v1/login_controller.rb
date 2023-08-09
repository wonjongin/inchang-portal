class Api::V1::LoginController < ApplicationController
  require 'digest'

  def sign_in
    if session[:user_id] != nil
      redirect_to '/api/v1/diary/list'
    else
      @user_name_value = ""
      @user_name_value = session[:user_name]
      @user_name_value = session[:user_temp_name] if session[:user_temp_name] != nil
      @user_name_value = "" if @user_name_value == nil
      render
    end
  end
  def login
    u = User.find_by(name: params[:name])
    if u == nil
      flash.now[:alert] = "없는 회원입니다."
      redirect_to '/api/v1/login', alert: "없는 회원입니다." and return
    end
    encoded = Digest::SHA256.hexdigest(params[:pw] + ENV['SALT'])
    if encoded == u.pw
      session[:user_id] = u.id
      session[:user_name] = u.name if params[:save_name] == "1"
      session.delete(:user_name) if params[:save_name] == "0"
      session.delete(:user_temp_name)
      redirect_to '/api/v1/diary/list'
    else
      # flash.now[:alert] = "비밀번호가 잘못됐습니다."
      # 쿠키에 유저네임 저장했다가 꺼내든지 해야지
      session[:user_temp_name] = params[:name]
      redirect_to "/api/v1/login", alert: "비밀번호가 잘못됐습니다." and return

      # redirect_to '/api/v1/login/wrong_user_pw'
    end
  end

  def logout
    session.delete(:user_id)
    redirect_to '/api/v1/login/'
  end

  def sign_up

  end

  def signed_up

  end

  def wrong_admin_pw

  end
  def wrong_user_pw

  end

  def wrong_pw_check

  end

  def signingup
    if params[:pw] == params[:pw_check]
      if params[:admin_pw] == ENV['ADMIN_PW']
        pwsh = Digest::SHA256.hexdigest(params[:pw] + ENV['SALT'])
        u = User.create do |t|
          t.name = params[:name]
          t.pw = pwsh
          t.permission = params[:permission]
        end
        redirect_to '/api/v1/login/signed_up'
      else
        redirect_to '/api/v1/login/wrong_admin_pw'
      end
    else
      redirect_to '/api/v1/login/wrong_pw_check'
    end
  end
end
