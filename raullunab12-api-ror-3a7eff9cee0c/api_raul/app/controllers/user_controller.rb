class UserController < ApplicationController
  def signin
    username = params[:username].to_s.strip
    password = params[:password].to_s

    if username.empty? || password.empty?
      msg = { status: 400, response: { error: 'Username and password are required.' } }
      render_auth_response(msg, :bad_request)
      return
    end

    user = User.find_by(user: username, password: password)
    unless user
      msg = { status: 401, response: { error: 'Username or password invalid.' } }
      render_auth_response(msg, :unauthorized)
      return
    end

    existing_token = ApiKey.find_by(userId: username)
    if existing_token
      existing_token.generate_access_token
      if existing_token.update(current: DateTime.now)
        render_auth_response({ status: 201, auth_token: existing_token.access_token }, :created)
      else
        render_auth_response({ status: 422, error: 'Could not refresh token.' }, :unprocessable_entity)
      end
    else
      token = ApiKey.create(userId: username, current: DateTime.now)
      if token && token.persisted?
        render_auth_response({ status: 201, auth_token: token.access_token }, :created)
      else
        render_auth_response({ status: 422, error: 'Could not create token.' }, :unprocessable_entity)
      end
    end
  end

  def signout
    raw_token = request.headers['authtoken'].to_s.strip
    token = raw_token.empty? ? nil : ApiKey.find_by(access_token: raw_token)
    if token
      token.destroy
      render_auth_response({ status: 200, notice: 'Token was successfully destroyed.' }, :ok)
    else
      render_auth_response({ status: 422, error: 'Token not found.' }, :unprocessable_entity)
    end
  end

  private

  def render_auth_response(msg, http_status)
    respond_to do |format|
      format.html { render json: msg, status: http_status }
      format.json { render json: msg, status: http_status }
    end
  end
end
