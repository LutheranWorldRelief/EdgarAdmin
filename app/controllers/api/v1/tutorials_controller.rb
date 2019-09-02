class Api::V1::TutorialsController < Api::V1::ApplicationController

	def index
		@tutorials = Tutorial.all.map do |document|
		  { :id => document.id, 
		  	:name => document.name,
		  	:video_link => document.video_link.split("?v=").last
		  }
		end
		render json: { tutorials: @tutorials }.to_json
	end
end