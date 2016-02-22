module Session

  def set_user_id(user)
    session[:user_id] = user.id
  end
end
