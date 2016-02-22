class UsersController < ApplicationController
  include Session
  before_action :accepted_term?, only: :create

  def new
    gon.company_names = Company.pluck(:name)
  end

  def create
    @user = User.new(user_parameters)
    if @user.save
      set_user_id(@user)
      redirect_to root_path and return
    else
      render :new
    end
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_parameters)
      set_user_id(@user)
    end
    redirect_to mypage_path
  end

private
  def accepted_term?
    render :new and return unless params[:accept]
  end

  def user_parameters
    params.permit(:name, :password, :password_confirmation, :email)
  end
end
