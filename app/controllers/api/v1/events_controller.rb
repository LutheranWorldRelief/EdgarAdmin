class Api::V1::EventsController < Api::V1::ApplicationController
	def index

		@events = Event.all.limit(15)

		if params[:paginate].present?
			count = 0
			if params[:paginate].to_i > 0
				for i in 0..params[:paginate].to_i
			   		count = count + 15
				end
			else
				count = 0
			end
			@events = @events.offset(count)
		end

		if params[:year].present?
			@events = @events.where('extract(year from start) = ?', params[:year])
		else
			@events = @events.where('extract(year from start) = ?', Date.today.year)
		end

		@events = @events.where(status: true).map do |event|
		  { :id => event.id, 
		  	:title => event.title,
		  	:first_moon_cycle => event.first_moon_cycle,
		  	:second_moon_cycle => event.second_moon_cycle,
		  	:third_moon_cycle => event.third_moon_cycle,
		  	:quarter_moon_cycle => event.quarter_moon_cycle,
		  	:article => event.article,
		  	:description => event.description,
		  	:status => event.status,
		  	:start_date => event.start.strftime('%d-%m-%Y'),
		  	:end_date => event.end.strftime('%d-%m-%Y'),
		  	:category_event_id => event.category_event.id,
		  	:name => event.category_event.name,
		  	:color => event.category_event.color
		  }
		end

		@years = Event.select("start").map{ |item| item.start.year }.uniq

		render json: { events: @events, years: @years }.to_json

	end
end
