class AlertNotifier < ActionMailer::Base
  default from: "Antonio Jha <antoniojha@gmail.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.alert_notifier.alert.subject
  #
  def alert
    @greeting = "Hi"

    mail to: "antoniojha@gmail.com", subject: 'Alert'
  end
end
