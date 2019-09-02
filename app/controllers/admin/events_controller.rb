class Admin::EventsController < Admin::ApplicationController
	before_action :set_events, only: [:show, :edit, :update, :destroy]
	respond_to :html
	
	def index
		@events = Event.all.map do |event|
			{ 
			 	id: event.id,
				title: event.title,
      	start: event.start,
      	end: event.end
			}
		end
		@events= Event.where(start: params[:start]..params[:end])
		@events = Event.order(:created_at).paginate( :page => params[:page], :per_page => 5).order(' id DESC ')
	end

	def show
		
	end

	def new
		@events = Event.new
		respond_with(@events)
	end

	def create
		@events = Event.new(events_params)
	    if @events.save
	    	@events.article = @events.article.gsub("/uploads/ckeditor/pictures/","http://edg.codecastle.com.sv/uploads/ckeditor/pictures/")
				@events.save
	      redirect_to admin_events_path, notice: "Evento creado con éxito."
	    else
	      redirect_to new_admin_event_path
	    end    
	end

	def edit
		@events = Event.find(params[:id])
	end

	def update
		@events.update(events_params)
		@events.article = @events.article.gsub("/uploads/ckeditor/pictures/","http://edg.codecastle.com.sv/uploads/ckeditor/pictures/")
		@events.save
    redirect_to admin_events_path, notice: "Evento actualizado con éxito."
	end

	def destroy
		events = Event.find(params[:id])
  	if events.destroy
  		redirect_to admin_events_path , notice: "Evento eliminado con éxito"
  	else
			if @events.errors.any?
			  render :new
				flash[:alert] = "Error! Por favor verifique la información."
			end
  	end
	end

	private
    def set_events
      @events = Event.find(params[:id])
    end

    def events_params
      params.require(:event).permit(:title, :start, :end, :first_moon_cycle, :second_moon_cycle, :third_moon_cycle, :quarter_moon_cycle, :description, :article, :status, :category_event_id)
    end
end