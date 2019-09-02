class HomeController < ActionController::Base
	before_action :set_user, only: [:update_user]
	layout false
	
	def index
		
	end

	def user_configuration
		if params[:token].present?
			@user = User.find_by(token: params[:token])
			if @user.nil?
				redirect_to "/404"
			end
		else
			redirect_to "/404"
		end
	end

	def update_user
		if @user.update(user_params)
			@user.token = nil
			@user.save
			redirect_to finish_home_index_path
		else
			redirect_to user_configuration_home_index_path(token: @user.token)
		end
	end

	def finish
		
	end

	private

		def user_params
			params.require(:user).permit(:password, :password_confirmation)
		end

		def set_user
			@user = User.find(params[:home_id])
		end
end
