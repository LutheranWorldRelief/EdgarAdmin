class Admin::UsersController < Admin::ApplicationController
	layout "application"
	
	before_action :set_user, only: [:change_user_role, :destroy_admin, :destroy, :edit_password, :edit, :update, :edit_admin_password , :edit_admin, :update_admin]
	
	def index

		if current_user.has_role? :admin

			@users = User.all
			@s1 = ""
			@s2 = ""
			@s3 = ""
			age = ""
			query = ""
			conditions = [query]

			if params[:filter].present?
				
				if params[:filter][:gender].present?
					if query.blank?
						query += " genre = ? "
					else
						query += " AND genre = ? "
					end
					conditions << params[:filter][:gender]
					@s2 = params[:filter][:gender]
				end

				if params[:filter][:age].present?
					min = 0
					max = 0
					case params[:filter][:age]
					when "a1"
						max = 14
					when "a2"
						min = 15
						max = 24
					when "a3"
						min = 25
						max = 34
					when "a4"
						min = 35
						max = 44
					when "a5"
						min = 45
						max = 54
					when "a6"
						min = 55
						max = 64
					when "a7"
						min = 65
						max = 100
					end
					if query.blank?
						query += " age_time BETWEEN ? AND ? "
					else
						query += " AND age_time BETWEEN ? AND ? "
					end
					conditions << min
					conditions << max
					@s3 = params[:filter][:age]
				end

				conditions[0] = query

				if query != ""
					@users = @users.where(conditions)
				end

				if params[:filter][:role].present?
					if params[:filter][:role] == "tecnhical"
						@users = @users.with_role(:tecnhical)
					else
						@users = @users.with_role(:producer)
					end
					@s1 = params[:filter][:role]
				end

			end

			@data_f = [0, 0, 0, 0, 0, 0, 0, 0]
			@data_m = [0, 0, 0, 0, 0, 0, 0, 0]

			@users.each do |u|
				unless u.has_role? :admin
					if (0...14).include?(u.user_age) == true
						if u.genre == 'f'
							@data_f[0] += 1
						else
							@data_m[0] += 1
						end
					end
					if (15...24).include?(u.user_age) == true
						if u.genre == 'f'
							@data_f[1] += 1
						else
							@data_m[1] += 1
						end
					end
					if (25...34).include?(u.user_age) == true
						if u.genre == 'f'
							@data_f[2] += 1
						else
							@data_m[2] += 1
						end
					end
					if (35...44).include?(u.user_age) == true
						if u.genre == 'f'
							@data_f[3] += 1
						else
							@data_m[3] += 1
						end
					end
					if (45...54).include?(u.user_age) == true
						if u.genre == 'f'
							@data_f[4] += 1
						else
							@data_m[4] += 1
						end
					end
					if (55...64).include?(u.user_age) == true
						if u.genre == 'f'
							@data_f[5] += 1
						else
							@data_m[5] += 1
						end
					end
					if (65...100).include?(u.user_age) == true
						if u.genre == 'f'
							@data_f[6] += 1
						else
							@data_m[6] += 1
						end
					end
					if u.user_age == ''
						if u.genre == 'f'
							@data_f[7] += 1
						else
							@data_m[7] += 1
						end
					end
				end
			end
		else
			redirect_to admin_events_path
		end
	end

	def admins
		if current_user.has_role? :admin
			@admins = User.with_role(:admin)
		else
			redirect_to admin_events_path
		end
	end

	def new_admin
		
	end

	def new
		if current_user.has_role? :admin
			@user = User.new
		else
			redirect_to admin_events_path
		end
	end

	def new_admin
		if current_user.has_role? :admin
			@user = User.new
		else
			redirect_to admin_events_path
		end
	end

	def create
		user = User.new(user_params)
		if user.save!
			user.add_role :tecnhical
			user.save

			url = "https://api-0F630D9E-5FAC-47E3-AC70-E5BC29618273.sendbird.com/v3/users"
      paramsBody = {
      	"user_id" => "#{user.id}",
  			"nickname": "#{user.username}",
  			"profile_url": ""
      }
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(uri.path,'Content-Type'  => 'application/json;charset=utf-8', "Api-Token" =>"76bb7387e25f6403bd6e6fd6726ddb06ce87976d")
      request.body = paramsBody.as_json.to_json
      response = http.request(request) 
      puts response.body

			redirect_to admin_users_path, notice: "Usuario creado"
		else
			render :new
			flash[:alert] = "Ocurrio un error"
		end
	end

	def create_admin
		user = User.new(user_params)
		if user.save!
			user.add_role :admin
			user.save
			redirect_to admins_admin_users_path, notice: "Administrador creado"
		else
			render :new_admin
			flash[:alert] = "Ocurrio un error"
		end
	end

	def change_user_role
		if @user.has_role? :tecnhical
			@user.remove_role :tecnhical
			@user.add_role :producer
		else
			@user.remove_role :producer
			@user.add_role :tecnhical
		end
		redirect_to admin_users_path, notice: "Rol cambiado"
	end

	def edit
	end

	def edit_password
	end

	def edit_admin
	end

	def edit_admin_password
	end

	def update
		if @user.update(user_params)
			redirect_to admin_users_path, notice: "Usuario actualizado"
		else
			redirect_to admin_users_path, notice: "Ocurrio un error"
		end
	end

	def update_admin
		if @user.update(user_params)
			redirect_to admins_admin_users_path, notice: "Usuario actualizado"
		else
			render :edit_admin
			flash[:alert] = "Ocurrio un error"
		end
	end
	
	def destroy
		user_id = @user.id
		if @user.destroy
			url = "https://api-0F630D9E-5FAC-47E3-AC70-E5BC29618273.sendbird.com/v3/users/#{user_id}"
      paramsBody = {}
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Delete.new(uri.path,'Content-Type'  => 'application/json;charset=utf-8', "Api-Token" =>"76bb7387e25f6403bd6e6fd6726ddb06ce87976d")
      request.body = paramsBody.as_json.to_json
      response = http.request(request) 
      puts response.body

			redirect_to admin_users_path, notice: "Usuario eliminado"
		else
			redirect_to admin_users_path, notice: "Ocurrio un error"
		end
	end

	def destroy_admin
		if User.with_role(:admin).all.size > 1
			if @user.destroy
				redirect_to admins_admin_users_path, notice: "Usuario eliminado"
			else
				redirect_to admins_admin_users_path, notice: "Ocurrio un error"
			end
		else
				redirect_to admins_admin_users_path, notice: "No se puede borrar el admin"
		end
	end

	private

		def user_params
			params.require(:user).permit(:username, :birth_date, :password, :password_confirmation, :genre, :phone, :email, :country_id)
		end

		def set_user
			@user = User.find(params[:id])
		end
end