class Api::V1::LoginController < ApplicationController
  require 'digest'

  def sign_in

  end
  def login
    u = User.find_by(name: params[:name])
    encoded = Digest::SHA256.hexdigest(params[:pw] + ENV['SALT'])
    if encoded == u.pw
      session[:user_id] = u.id
    else
      redirect_to '/api/v1/login/wrong_user_pw'
    end
    redirect_to '/api/v1/diary/list'
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

  def signingup
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
  end
end
