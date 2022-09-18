class BulletinsController < ApplicationController
  before_action :set_bulletin, only: %i[ show edit update destroy ]

  # GET /bulletins or /bulletins.json
  def index
    @bulletins = Bulletin.all.order('bulletins.created_at DESC')
    @c=0
  end

  # GET /bulletins/1 or /bulletins/1.json
  def show
    authorize! :read, @bulletin, :message => "BEWARE: you are not authorized to read bulletin board"
  end

  # GET /bulletins/new
  def new
    @bulletin = Bulletin.new
    authorize! :create, @bulletin, :message => "BEWARE: you are not authorized to create bulletins"
  end

  # GET /bulletins/1/edit
  def edit
    authorize! :edit, @bulletin, :message => "BEWARE: you are not authorized to edit bulletins"
  end

  # POST /bulletins or /bulletins.json
  def create
    @bulletin = Bulletin.new(bulletin_params)
    authorize! :create, @bulletin, :message => "BEWARE: you are not authorized to create bulletins"

    respond_to do |format|
      if @bulletin.save
        format.html { redirect_to bulletin_url(@bulletin), notice: "Bulletin was successfully created." }
        format.json { render :show, status: :created, location: @bulletin }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bulletin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bulletins/1 or /bulletins/1.json
  def update
    authorize! :edit, @bulletin, :message => "BEWARE: you are not authorized to edit bulletins"

    respond_to do |format|
      if @bulletin.update(bulletin_params)
        format.html { redirect_to bulletin_url(@bulletin), notice: "Bulletin was successfully updated." }
        format.json { render :show, status: :ok, location: @bulletin }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bulletin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bulletins/1 or /bulletins/1.json
  def destroy
    authorize! :destroy, @bulletin, :message => "BEWARE: you are not authorized to delete bulletins"
    @bulletin.destroy

    respond_to do |format|
      format.html { redirect_to bulletins_url, notice: "Bulletin was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bulletin
      @bulletin = Bulletin.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bulletin_params
      params.require(:bulletin).permit(:title, :description)
    end
end
