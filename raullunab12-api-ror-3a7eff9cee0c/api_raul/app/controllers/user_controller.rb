class UserController < ApplicationController

  def signin
    @msg
    if User.where(:user=>params[:username]).where(:password=>params[:password]).first#si existe el usuario en Users
      if ApiKey.where(:userId=>params[:username]).first#si ya tiene sesion
        update = ApiKey.where(:userId=>params[:username]).first#se busca el token del user
          update.generate_access_token
          update.update(current: DateTime.now)#se actualiza a la fecha actual y se cambia de token
          if update != nil
            msg = { status: 201 , auth_token: update.access_token}
          else
            msg = { status: 422}
          end
        respond_to do |format|
          format.html { render json: msg }
          format.json { render json: msg }
        end
      else
        token = ApiKey.create(userId: params['username'], current: DateTime.now)#si no tiene sesion creada se le crea una
        if token != nil
          msg = { status: 201 , auth_token: token.access_token}
        else
          msg = { status: 422 }
        end
        respond_to do |format|
          format.html { render json: msg }
          format.json { render json: msg }
        end
      end
    else #si no existe el usuario en users
      msg = { status: 401 , response: {error:'Username or password invalid.'}}
      respond_to do |format|
        format.html { render json: msg }
        format.json { render json: msg }
      end    
    end
  end
  
  def signout
    @msg
    token = ApiKey.find_by(access_token: request.headers['authtoken'])
    if token != nil
      token.destroy
      msg = { status: 200 , notice: 'Token was successfully destroyed.'}
    else
     msg = { status: 422 , error: 'Token not found!.'}
    end
    respond_to do |format|
    format.html { render json: msg }
    format.json { render json: msg }
    end
  end
end