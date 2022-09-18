class SecondhandsController < ApplicationController
  before_action :set_secondhand, only: %i[ show edit update destroy approve]

  # GET /secondhands or /secondhands.json
  def index
    if current_user.admin?
      @secondhands = Secondhand.all
    else
      approved
    end
  end

  # GET /secondhands/1 or /secondhands/1.json
  def show
    authorize! :read, @secondhand, :message => "BEWARE: you are not authorized to read secondhands"
  end

  # GET /secondhands/new
  def new
    @secondhand = Secondhand.new
    authorize! :create, @secondhand, :message => "BEWARE: you are not authorized to create secondhands"
  end

  # GET /secondhands/1/edit
  def edit
    authorize! :edit, @secondhand, :message => "BEWARE: you are not authorized to edit secondhands"
    if current_user.id != @secondhand.user_id
      redirect_to library_path, alert: "BEWARE: you are not authorized to edit secondhands"
    end
  end

  # POST /secondhands or /secondhands.json
  def create    
    @secondhand = Secondhand.new
    
    authorize! :create, @secondhand, :message => "BEWARE: you are not authorized to create secondhands"
    

    isbn_book = params[:secondhand][:ISBN]
    @book = Book.find_by(ISBN: isbn_book)


    if @book.present?
      @secondhand = @book.secondhand.create(secondhand_params)
      @secondhand.book_id = @book.id
    end
      @secondhand.user_id = current_user.id
      
    
    
    respond_to do |format|
      if @secondhand.save
        format.html { redirect_to secondhand_url(@secondhand), notice: "Secondhand was successfully created." }
        format.json { render :show, status: :created, location: @secondhand }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @secondhand.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /secondhands/1 or /secondhands/1.json
  def update
    authorize! :edit, @secondhand, :message => "BEWARE: you are not authorized to edit secondhands"
    if current_user.id != @secondhand.user_id
      redirect_to library_path, alert: "BEWARE: you are not authorized to edit secondhands"
    end

    @secondhand.approved = false

    respond_to do |format|
      if @secondhand.update(secondhand_params)
        format.html { redirect_to secondhand_url(@secondhand), notice: "Secondhand was successfully updated, wait for new approvation." }
        format.json { render :show, status: :ok, location: @secondhand }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @secondhand.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /secondhands/1 or /secondhands/1.json
  def destroy

    authorize! :destroy, @secondhand, :message => "BEWARE: you are not authorized to destroy secondhands"

    @secondhand.destroy

    respond_to do |format|
      format.html { redirect_to library_url, notice: "Secondhand was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def display_to_approve
    @secondhands = Secondhand.where(approved: false)
  end

  def approved
    @secondhands = Secondhand.where(approved: true)
  end

  def display_my_adv
    #Da completare
    @secondhands = Secondhand.where(user_id: current_user.id)
  end

  def approve
    authorize! :approve, @secondhand, :message => "BEWARE: you are not authorized to approve secondhands"

    already_approved = false
    if @secondhand.approved == true
      already_approved = true
    end
    @secondhand.approved = true
    

    respond_to do |format|
      if already_approved == false && @secondhand.save
        format.html { redirect_to secondhand_url(@secondhand), notice: "Secondhand was successfully approved." }
        format.json { render :show, status: :ok, location: @secondhand }
      else
        format.html { redirect_to secondhand_url(@secondhand), alert: "Secondhand was already approved." }
        format.json { render :show, status: :ok, location: @secondhand }
      end
    end
  end

  def filter 
    query = params[:search]
    
    @secondhands = Secondhand.joins(:book).where("books.title LIKE (?)", "%#{query}%").or(Secondhand.joins(:book).where("books.ISBN = (?)", params[:search] ))

    if(params[:checkCourse] == "Your Course of study" )
      @books =  Book.joins(:course).where("courses.id = (?)", current_user.course_id)
      

    elsif (params[:checkCourse] == "All" )
      @books = Book.all

    elsif (params[:checkCourse] == "Favorites" )
      @books = current_user.book.where("title LIKE (?)", "%#{query}%").or(Book.where(ISBN: params[:search]))
    elsif (params[:checkCourse] == "Categories")
      @books = Book.joins(:category).where("categories.id in (?)", params[:categories][:category])
    
    end
      
    

    @secondhands = @secondhands.where("book_id in (?)", @books.map {|book| book.id})

    for secondhand in @secondhands do
      @book_info = Book.find(secondhand.book_id)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_secondhand
      @secondhand = Secondhand.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def secondhand_params
      params.require(:secondhand).permit(:book_id, :user_id, :image, :description)
    end
end
