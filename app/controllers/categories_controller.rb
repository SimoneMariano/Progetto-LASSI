class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]

  # GET /categories or /categories.json
  def index
    @categories = Category.all
  end

  # GET /categories/1 or /categories/1.json
  def show
    authorize! :read, @category, :message => "BEWARE: you are not authorized to read categories"
  end

  # GET /categories/new
  def new
    @category = Category.new
    authorize! :create, @category, :message => "BEWARE: you are not authorized to create categories"
  end

  # GET /categories/1/edit
  def edit
    authorize! :edit, @category, :message => "BEWARE: you are not authorized to edit categories"
  end

  # POST /categories or /categories.json
  def create
    @category = Category.new(category_params)
    authorize! :create, @category, :message => "BEWARE: you are not authorized to create categories"

    respond_to do |format|
      if @category.save
        format.html { redirect_to category_url(@category), notice: "Category was successfully created." }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    authorize! :edit, @category, :message => "BEWARE: you are not authorized to edit categories"
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to category_url(@category), notice: "Category was successfully updated." }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    authorize! :destroy, @category, :message => "BEWARE: you are not authorized to destroy categories"
    @category.destroy

    respond_to do |format|
      format.html { redirect_to library_url, notice: "Category was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name)
    end
end
