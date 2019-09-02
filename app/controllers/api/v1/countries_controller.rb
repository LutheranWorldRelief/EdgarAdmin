class Api::V1::CountriesController < Api::V1::ApplicationController

	def index
		@countries = Country.all.map do |country|
		  { :id => country.id, 
		  	:name => country.name
		  }
		end
		render json: { countries: @countries }.to_json
	end
end