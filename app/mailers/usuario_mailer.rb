class UsuarioMailer < ApplicationMailer

  default from: ENV["SMTP_USER"]

  def welcome_email
    @user = params[:user]
    @password = params[:password]
    mail(to: @user.email, subject: "Bem vindo a biblioteca Municipal Ney Pontes!")
  end

  def borrow_ending_warning(borrow)
    @borrow = borrow
    @user = borrow.usuario
    mail to: @user.email, subject: "⚠️ Seu empréstimo encerrará em breve"
  end
end
