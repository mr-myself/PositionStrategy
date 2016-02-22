class PasswordReset < ActionMailer::Base
  default from: PositionStrategy::Application.config.email

  def send_mail(email, token)
    @host = PSConfig.host
    @token = token
    mail to: email, subect: I18n.t('mail.password_reset.send_mail.subject')
  end
end
