class UserMailer < ApplicationMailer
	default from: "no-reply@edgarapp.com"

	def forgot_user(user)
    		@user = user
    		mail(to: @user.email, subject: 'Cambiar contraseña')
    		puts "******Enviado"
  end
end
