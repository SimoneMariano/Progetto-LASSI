class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy]
  # GET /books or /books.json
  def index
    
      @books = Book.all
    
    
  end

  def filter

    query = params[:search]
    @books = Book.where("title LIKE (?)", "%#{query}%").or(Book.where(ISBN: params[:search]))

    if(params[:checkCourse] == "Corso di studi" )
      #Da implementare con autenticazione 
    
    elsif (params[:checkCourse] == "Categorie")
      @books = @books.joins(:category).where("categories.id in (?)", params[:categories][:category])
    else
      #Da implementare con autenticazione
    end
  end

  # GET /books/1 or /books/1.json
  def show
    @authors = Author.joins(:book).where("books.id = (?)", params[:id])
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)

    if  params[:categories].present?
      for category in params[:categories] do
        @cat = Category.find(category)
        @book.category << @cat
      end
    end

    if  params[:courses].present?
      for course in params[:courses] do
        @course = Course.find(course)
        @book.course << @course
      end
    end

    if params[:authors].present?
      for author in params[:authors] do
        @aut = Author.find(author)
        @book.author << @aut
      end
    end
    
    

    respond_to do |format|
      if @book.save
        format.html { redirect_to book_url(@book), notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    
    @book.author.clear
    @book.category.clear

    for category in params[:categories] do
      @cat = Category.find(category)
      @book.category << @cat
    end

    for author in params[:authors] do
      @aut = Author.find(author)
      @book.author << @aut
    end


    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to book_url(@book), notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy

    respond_to do |format|
      format.html { redirect_to library_url, notice: "Book was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:ISBN, :title, :placeholder, :stock, :description)
    end
end
