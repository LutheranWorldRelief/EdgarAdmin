class Api::V1::UsersController < Api::V1::ApplicationController
  skip_before_action :verify_authenticity_token, only: [:user_update]
  before_action :set_user, only: [:user_profile, :user_update]
		# /api/v1/users/get_countries
  	def get_countries
  		render json: { countries: Country.all }
  	end

  	# /api/v1/users/get_user?phone=&password=
  	def get_user

  		user = User.where(phone: request.parameters['phone'].to_i).first
  		puts user.inspect
  		unless user.nil?
  			if user.valid_password?(request.parameters['password'].to_s)
  				user_chat = UserChat.find_by(user_producer: user.id)
          puts user_chat.inspect
          role = ""
          if user.has_role? :producer
            role = "producer"
          end
          if user.has_role? :tecnhical
            role = "tecnhical"
          end
          @user = {
            :id => user.id,
            :username => user.username,
            :email => user.email,
	    :another_email => user.another_email,
            :gender => user.genre,
            :phone => user.phone,
            :area_code => user.area_code,
            :birthdate => user.birth_date,
            :country => user.country.name,
            :role => role,
            :chat => {
              :id_chat => (user_chat.id rescue 0),
              :user_tecnhical => (user_chat.user_technical rescue 0),
              :url_chat => (user_chat.url_chat rescue '')
            }
          }
  				render json: { user: @user }
        else
				  render json: { error: "Usuario no registrado"}, status: 400
			  end
  		else
	 		  render json: { error: "Usuario no registrado" }, status: 400
		  end
  	end

  	# /api/v1/users/assign_user?id=
    def assign_user
      user = User.find(params[:id])
      if user
        user.assign_user(user.id)
        user_chat = UserChat.find_by(user_producer: user.id)
          role = ""
          if user.has_role? :producer
            role = "producer"
          end
          if user.has_role? :tecnhical
            role = "tecnhical"
          end
        @user = {
            :user_chat_id => (user_chat.id rescue 27),
            :user_tecnhical => (user_chat.user_technical rescue 0),
            :url_chat => (user_chat.url_chat rescue '')
          }
          render json: { user: @user }
      else
        render json: { error: "Usuario no registrado"}, status: 400
      end
    end

    # /api/v1/users/save_url_chat?id=&id_chat=&url_chat=
  	def save_url_chat
  		user = User.find(params[:id])
  		if user
        user.save_url_chat(params[:id_chat], params[:url_chat])
				@user = {
          :success=>true
        }
        render json: { user: @user }
			else
				render json: {success: false, error: "Usuario no registrado"}, status: 400
			end
  	end

  	# /api/v1/users/create_user?username=&password=&password_confirmation=&country_id=&gender=&birth_date=
  	def create_user
  		user = User.new(user_params)
  		if user.save!
  			user.add_role :producer
  			role = ""
          if user.has_role? :producer
            role = "producer"
          end
          if user.has_role? :tecnhical
            role = "tecnhical"
          end
        @user = {
            :id => user.id,
            :username => user.username,
            :email => user.email,
	    :another_email => user.another_email,
            :gender => user.genre,
            :phone => user.phone,
            :area_code => user.area_code,
            :birthdate => user.birth_date,
            :country => user.country.name,
            :role => role
        }
        render json: { user: @user }
  		else
  			render json: { error: "Ocurrio un problema" }, status: 400
  		end
  	end

    def validate_social
      role = ""
      user = User.where(social_id: params[:social_id], social_network: params[:social_network]).first
      unless user.nil?
        user_chat = UserChat.find_by(user_producer: user.id)
        if user.has_role? :producer
          role = "producer"
        end
        if user.has_role? :tecnhical
          role = "tecnhical"
        end
        @user = {
            :id => user.id,
            :username => user.username,
            :email => user.email,
            :another_email => user.another_email,
	    :gender => user.genre,
            :phone => user.phone,
            :area_code => user.area_code,
            :birthdate => user.birth_date,
            :country => user.country.name,
            :role => role,
            :chat => {
              :id_chat => (user_chat.id rescue 0),
              :user_tecnhical => (user_chat.user_technical rescue 0),
              :url_chat => (user_chat.url_chat rescue '')
            }
          }
          render json: { success: true, user: @user }
      else
        render json: { success: false, message: "Usuario no existe en la BD" }
      end
    end

    def forgot_password
      user = User.find_by(email: params[:email])
      if user
        user.token = SecureRandom.hex
        user.save
        UserMailer.forgot_user(user).deliver
        render json: { message: "Correo electronico enviado" }, status: 200
      else
        render json: { error: "Usuario no encontrado" }, status: 400
      end
    end

    def user_profile
      role = ""
          if @user.has_role? :producer
            role = "producer"
          end
          if @user.has_role? :tecnhical
            role = "tecnhical"
          end
      @user = {
            :profile => @user,
            :country => @user.country.name,
            :role => role
          }
      render json: { user: @user }
    end

    def user_update
      if @user.update!(user_params)
        role = ""
        if @user.has_role? :producer
          role = "producer"
        end
        if @user.has_role? :tecnhical
          role = "tecnhical"
        end
        @user = {
              :profile => @user,
              :country => @user.country.name,
              :role => role
            }
        render json: { user: @user }
      else
        render json: { error: "Ocurrio un problema" }, status: 400
      end
    end

    private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.permit(:area_code, :phone, :email, :username, :password, :password_confirmation, :country_id, :genre, :birth_date, :social_id, :social_network, :another_email)
      end

end
