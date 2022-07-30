class BookRentalsController < ApplicationController
  before_action :set_book_rental, only: %i[ show edit update destroy ]

  # GET /book_rentals or /book_rentals.json
  def index
    @book_rentals = BookRental.all
  end

  # GET /book_rentals/1 or /book_rentals/1.json
  def show
  end

  # GET /book_rentals/new
  def new
    @book_rental = BookRental.new
  end

  # GET /book_rentals/1/edit
  def edit
  end

  # POST /book_rentals or /book_rentals.json
  def create
    isbn_book = params[:book_rental][:ISBN]
    @book = Book.find_by(ISBN: isbn_book)

    #Da implementare con autenticazione
    #@user = current_user
    #id_user = params[:user_id]
    id_user = 1
    @user = User.find(id_user)

    @book_rental = @book.book_rental.create(book_rental_params)
    @book_rental.user_id = @user.id
    @book_rental.book_id = @book.id
#
    respond_to do |format|
      if @book_rental.save
        format.html { redirect_to book_rental_url(@book_rental), notice: "book_rental was successfully created." }
        format.json { render :show, status: :created, location: @book_rental }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book_rental.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /book_rentals/1 or /book_rentals/1.json
  def update
    respond_to do |format|
      if @book_rental.update(book_rental_params)
        format.html { redirect_to book_rental_url(@book_rental), notice: "Book rental was successfully updated." }
        format.json { render :show, status: :ok, location: @book_rental }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book_rental.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /book_rentals/1 or /book_rentals/1.json
  def destroy
    @book_rental.destroy

    respond_to do |format|
      format.html { redirect_to book_rentals_url, notice: "Book rental was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book_rental
      @book_rental = BookRental.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_rental_params
      params.require(:book_rental).permit(:start, :end)
    end
end
