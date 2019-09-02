class Admin::DocumentsController < Admin::ApplicationController
	before_action :set_documents, only: [:show, :edit, :update, :destroy]
	respond_to :html
	
	def index
		@documents = Document.order(:name).paginate( :page => params[:page], :per_page => 15).order(' id DESC ')
	end

	def show
		
	end

	def new
		@documents = Document.new
		respond_with(@documents)
	end

	def create
	 @documents = Document.new(documents_params)
		if @documents.save
		  redirect_to admin_documents_path, notice: "Documento creado con éxito."
		else
			if @documents.errors.any?
			  render :new
				flash[:alert] = "Error! Por favor verifique la información."
			end
		end
	end

	def edit
		@documents = Document.find(params[:id])
	end

	def update
		if @documents.update(documents_params)
		  redirect_to admin_documents_path, notice: "Documento actualizado con éxito."
		else
		  if @documents.errors.any?
			  render :edit
				flash[:alert] = "Error! Por favor verifique la información."
			end
		end
	end

	def destroy
		documents = Document.find(params[:id])
  	if documents.destroy
  		redirect_to admin_documents_path , notice: "Documento eliminado con éxito"
  	else
			if @documents.errors.any?
			  render :new
				flash[:alert] = "Error! Por favor verifique la información."
			end
  	end
	end

	private
    def set_documents
      @documents = Document.find(params[:id])
    end

    def documents_params
      params.require(:document).permit(:name, :file, :status)
    end
end