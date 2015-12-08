class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception fuck this line
   before_action :check_token, except: [:signout, :signin]
  def check_token
    if ApiKey.where("access_token = :token", { token: request.headers['authtoken']}).first
            key = ApiKey.where({ current: (DateTime.now - 30.minutes)..DateTime.now}).first
            if key != nil
                key.update(current: DateTime.now)
                return true;
            else
                msg = { status: 401 , response: {error:'Your token has been expired.'}}
                respond_to do |format|
                format.html { render json: msg }
                format.json { render json: msg }
                end
            end
    else
            msg = { status: 401 , response: {error:'Invalid token.'}}
            respond_to do |format|
                format.html { render json: msg }
                format.json { render json: msg }
            end
    end
  end    
end