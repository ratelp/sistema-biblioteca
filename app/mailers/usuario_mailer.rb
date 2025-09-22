class UsuarioMailer < ApplicationMailer

  default from: ENV["SMTP_USER"]

  def welcome_email
    @user = params[:user]
    @password = params[:password]
    mail(to: @user.email, subject: "Welcome to the Library System")
  end

end
