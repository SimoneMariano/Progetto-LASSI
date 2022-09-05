class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy addToFauvorites]
  # GET /books or /books.json
  def index
    @books = Book.all
  end

  def filter

    query = params[:search]
    @books = Book.where("title LIKE (?)", "%#{query}%").or(Book.where(ISBN: params[:search]))

    if(params[:checkCourse] == "Your Course of study" )
      #Da implementare con autenticazione 
    
    elsif (params[:checkCourse] == "Categories")
      @books = @books.joins(:category).where("categories.id in (?)", params[:categories][:category])
    else
      #Da implementare con autenticazione
    end
  end

  # GET /books/1 or /books/1.json
  def show
    #autorizzazione a leggere
    id = params[:id]
		@book = Book.find(id)
    authorize! :read, @book, :message => "BEWARE: you are not authorized to read books."
    
  end

  def addToFavorites
    @user = current_user
    @book  = Book.find(params[:id])

    authorize! :addToFauvorites, @book, :message => "BEWARE: you are not authorized to addToFauvorites books."

    if @user.book.where(id: @book.id).blank?
      @user.book << @book
      added = true
    else
      @user.book.delete(@book)
      added = false
    end

    respond_to do |format|
      if added
        format.html { redirect_to book_url(@book), notice: "Book was successfully added to favourites." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { redirect_to book_url(@book), notice: "Book was successfully removed from favourites." }
        format.json { render :show, status: :created, location: @book }
      end
    end

  end

  def removeFromFavorites
    @user = current_user
    @book  = Book.find(params[:id])

    authorize! :addToFauvorites, @book, :message => "BEWARE: you are not authorized to addToFauvorites books."
    @user.book.delete(@book)

    respond_to do |format|
      format.html { redirect_to profile_path, notice: "Book was successfully removed from favourites." }
      format.json {  head :no_content}
    end

  end

  # GET /books/new
  def new
    @book = Book.new
    if authorize! :create, @book, :message => "BEWARE: you are not authorized to create new books."
    end

  end

  # GET /books/1/edit
  def edit
    authorize! :edit, @book, :message => "BEWARE: you are not authorized to edit books."

  end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)
    #autorizzazione a creare
    authorize! :create, @book, :message => "BEWARE: you are not authorized to create new books."

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

    authorize! :edit, @book, :message => "BEWARE: you are not authorized to edit books."
    
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
    authorize! :destroy, @book, :message => "BEWARE: you are not authorized to destroy books."

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
