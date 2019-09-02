class Admin::CategoryEventsController < Admin::ApplicationController
	before_action :set_category_events, only: [:show, :edit, :update, :destroy]
	respond_to :html
	
	def index
		@category_events = CategoryEvent.order(:name).paginate( :page => params[:page], :per_page => 15).order(' id DESC ')
	end

	def show
		
	end

	def new
		@category_events = CategoryEvent.new
		respond_with(@category_events)
	end

	def create
		@category_events = CategoryEvent.new(category_events_params)
	    if @category_events.save
	      redirect_to admin_category_events_path, notice: "Categoria de Evento creado con éxito."
	    else
	      redirect_to new_admin_category_event_path
	    end    
	end

	def edit
		@category_events = CategoryEvent.find(params[:id])
	end

	def update
		@category_events.update(category_events_params)
    	redirect_to admin_category_events_path, notice: "Categoria de Evento actualizado con éxito."
	end

	def destroy
		category_events = CategoryEvent.find(params[:id])
  	if category_events.destroy
  		redirect_to admin_category_events_path , notice: "Categoría de Evento eliminada con éxito"
  	else
			if @category_events.errors.any?
			  render :new
				flash[:alert] = "Error! Por favor verifique la información."
			end
  	end
	end

	private
    def set_category_events
      @category_events = CategoryEvent.find(params[:id])
    end

    def category_events_params
      params.require(:category_event).permit(:name, :color)
    end
end