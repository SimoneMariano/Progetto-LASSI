class SecondhandsController < ApplicationController
  before_action :set_secondhand, only: %i[ show edit update destroy ]

  # GET /secondhands or /secondhands.json
  def index
    @secondhands = Secondhand.all
    for secondhand in @secondhands do
      @book_info = Book.find(secondhand.book_id)
    end
  end

  # GET /secondhands/1 or /secondhands/1.json
  def show
    @book_info = Book.find(@secondhand.book_id)
  end

  # GET /secondhands/new
  def new
    @secondhand = Secondhand.new
  end

  # GET /secondhands/1/edit
  def edit
  end

  # POST /secondhands or /secondhands.json
  def create    
    isbn_book = params[:secondhand][:ISBN]
    #@book = Book.find_by("ISBN", isbn_book)
    @book = Book.find_by(ISBN: isbn_book)

    #Da implementare con autenticazione
    #@user = current_user
    #id_user = params[:user_id]
    id_user = 1
    @user = User.find(id_user)

    @secondhand = @book.secondhand.create(secondhand_params)
    @secondhand.user_id = @user.id
    @secondhand.book_id = @book.id
    
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
    respond_to do |format|
      if @secondhand.update(secondhand_params)
        format.html { redirect_to secondhand_url(@secondhand), notice: "Secondhand was successfully updated." }
        format.json { render :show, status: :ok, location: @secondhand }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @secondhand.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /secondhands/1 or /secondhands/1.json
  def destroy
    @secondhand.destroy

    respond_to do |format|
      format.html { redirect_to secondhands_url, notice: "Secondhand was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def filter 
    query = params[:search]
    
    @secondhands = Secondhand.joins(:book).where("books.title LIKE (?)", "%#{query}%").or(Secondhand.joins(:book).where("books.ISBN = (?)", params[:search] ))

    if(params[:checkCourse] == "Corso di studi" )
      #Da implementare con autenticazione 
    
    elsif (params[:checkCourse] == "Categorie")
      @books = Book.joins(:category).where("categories.id in (?)", params[:categories][:category])
      @secondhands = @secondhands.where("book_id in (?)", @books.map {|book| book.id})
    else
      #Da implementare con autenticazione
    end

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
