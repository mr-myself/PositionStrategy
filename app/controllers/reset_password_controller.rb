class ResetPasswordController < ApplicationController

  def forgot_form
  end

  def send_mail
    begin
      ResetToken.create(token: SecureRandom.hex(16), email: params[:email])
      Mail::PasswordReset.send_mail(email, token).deliver
    rescue => exception
      mail_error(exception)
    end
    redirect_to root_path
  end

  def reset_form
    raise unless params[:token]

    reset_token = ResetToken.find_by(token: params[:token])
    raise if reset_token.blank?

    user = User.find_by(email: reset_token.email)
    raise if user.blank?

    session[:email] = email.email
  end

  def reset
    raise unless session[:email]

    User.reset_password(session[:email], params[:password])
    redirect_to root_path
  end

private
  def mail_error(exception)
    if exception.message.include?("Name or service not known")
      Rails.logger.info I18n.t('logger.errors.smtp')
      raise
    else
      Rails.logger.info I18n.t('logger.errors.sending_mail')
      raise
    end
  end
end
