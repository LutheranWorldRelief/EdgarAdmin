class Admin::AssignationsController < Admin::ApplicationController
    before_action :set_user_chat, only: [:update]

    def index
        @tecnhicals = User.with_role(:tecnhical)
    end

    def update
	puts params[:tecnhical].inspect
	puts params[:tecnhical].to_i
        if params[:tecnhical].present?
            url = "https://api-0F630D9E-5FAC-47E3-AC70-E5BC29618273.sendbird.com/v3/group_channels/#{@user_chat.url_chat}/leave"
            paramsBody = {
                "user_ids" => ["#{@user_chat.user_technical}"]
            }
            uri = URI.parse(url)
            http = Net::HTTP.new(uri.host, uri.port)
            http.use_ssl = true

            request = Net::HTTP::Put.new(uri.path,'Content-Type'  => 'application/json;charset=utf-8', "Api-Token" =>"76bb7387e25f6403bd6e6fd6726ddb06ce87976d")
            request.body = paramsBody.as_json.to_json
            response = http.request(request) 
            puts response.body
            if @user_chat.update(user_technical: params[:tecnhical].to_i)
                url = "https://api-0F630D9E-5FAC-47E3-AC70-E5BC29618273.sendbird.com/v3/group_channels/#{@user_chat.url_chat}/invite"
                paramsBody = {
                "user_ids" => ["#{@user_chat.user_technical}"]
                }
                uri = URI.parse(url)
                http = Net::HTTP.new(uri.host, uri.port)
                http.use_ssl = true

                request = Net::HTTP::Post.new(uri.path,'Content-Type'  => 'application/json;charset=utf-8', "Api-Token" =>"76bb7387e25f6403bd6e6fd6726ddb06ce87976d")
                request.body = paramsBody.as_json.to_json
                response = http.request(request) 
                puts response.body
                render json: { message: "Guardado correctamente" }
            else
                render json: { message: "Ocurrio un error" }
            end
        else
            render json: { message: "Ocurrio un error" }
        end
    end

    private
        def set_user_chat
            @user_chat = UserChat.find(params[:id])
        end
end
