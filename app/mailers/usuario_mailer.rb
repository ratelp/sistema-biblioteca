class UsuarioMailer < ApplicationMailer

  default from: ENV["SMTP_USER"]

  def welcome_email
    @user = params[:user]
    @password = params[:password]
    mail(to: @user.email, subject: "Bem vindo a biblioteca Municipal Ney Pontes!")
  end

end
