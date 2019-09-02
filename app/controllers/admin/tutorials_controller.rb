class Admin::TutorialsController < Admin::ApplicationController
	before_action :set_tutorial, only: [:destroy, :show]
	def index
		@tutorials = Tutorial.order(:name).paginate( :page => params[:page], :per_page => 15)
		@tutorial = Tutorial.new	
	end

	def create
		tutorial = Tutorial.new(tutorial_params)
		@tutorials = Tutorial.all
		respond_to do |format|
			if tutorial.save
	      format.js
	    else
	    	format.html { redirect_to admin_tutorials_path, notice: 'Error al guardar' }
	    end
    end
	end

	def destroy
		@tutorials = Tutorial.all
		respond_to do |format|
			if @tutorial.destroy
	      format.js
	    else
	    	format.html { redirect_to admin_tutorials_path, notice: 'Error al eliminar' }
	    end
    end
	end

	def show
		
	end

	private

		def set_tutorial
			@tutorial = Tutorial.find(params[:id])
		end

		def tutorial_params
			params.require(:tutorial).permit(:name, :video_link)
		end

end