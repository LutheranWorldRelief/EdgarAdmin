class Api::V1::DocumentsController < Api::V1::ApplicationController

	def index
		@documents = Document.where(status: 1).all.map do |document|
		  { :id => document.id, 
		  	:name => document.name,
		  	:file => "http://panel.proyectoedgar.com#{document.file.url}",
		  	:status => document.status
		  }
		end
		render json: { documents: @documents }.to_json
	end
end