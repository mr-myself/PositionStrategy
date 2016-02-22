class SessionsController < ApplicationController
  include Session

  def new
    redirect_to search_index_path unless request.smart_phone?
  end

  def create
    if user = User.login(params[:name], params[:password])
      set_user_id(user)

      redirect_to env['HTTP_REFERER'] and return if env['HTTP_REFERER']
      redirect_to search_index_path and return
    else
      flash[:alert] = I18n.t('flash.failed_signin')
      redirect_to :back and return
    end
  end

  def create_via_sns
    auth = request.env['omniauth.auth']
    user = User.find_by(uid: auth['uid']) || UserFactory.via_sns(auth)
    set_user_id(user)

    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
