class UserMailer < ActionMailer::Base
  default from: "no-reply@expense.com"

  def welcome_email user, password
    @password, @user = password, user
    mail(to: user.email, subject: "Registered Successfully", content_type: "text/html" )
  end
end
