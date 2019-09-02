class Admin::CountriesController < Admin::ApplicationController
	before_action :set_countries, only: [:show, :edit, :update, :destroy]
	respond_to :html
	
	def index
		@countries = Country.order(:name).paginate( :page => params[:page], :per_page => 8).order(' id DESC ')
	end

	def show
		
	end

	def new
		@countries = Country.new
		respond_with(@countries)
	end

	def create
		@countries = Country.new(countries_params)
	    if @countries.save
	      redirect_to admin_countries_path, notice: "País creado con éxito."
	    else
	      if @countries.errors.any?
				  render :new
					flash[:alert] = "Error! Por favor verifique la información."
				end
	    end    
	end

	def edit
		@countries = Country.find(params[:id])
	end

	def update
		if @countries.update(countries_params)
    	redirect_to admin_countries_path, notice: "País actualizado con éxito."
		else
		  if @countries.errors.any?
			  render :edit
				flash[:alert] = "Error! Por favor verifique la información."
			end
		end
	end

	def destroy
		countries = Country.find(params[:id])
  	if countries.destroy
  		redirect_to admin_countries_path , notice: "País eliminado con éxito"
  	else
			if @countries.errors.any?
			  render :new
				flash[:alert] = "Error! Por favor verifique la información."
			end
  	end
	end

	private
    def set_countries
      @countries = Country.find(params[:id])
    end

    def countries_params
      params.require(:country).permit(:name)
    end
end