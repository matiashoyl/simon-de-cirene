class UserMailer < ActionMailer::Base
  include Devise::Mailers::Helpers

  default from: "formulariossdc@gmail.com"

  def welcome(user, password)
    @user = user
    @password = password
    mail(:to => user.email, :subject => "Registrado en Simón de Cirene")
    mail(:to => "formulariossdc@gmail.com", :subject => "Registrado en Simón de Cirene")
  end

  def password_changed(user, password)
    @user = user
    @password = password
    mail(:to => user.email, :subject => "Contraseña cambiada")
  end
end
