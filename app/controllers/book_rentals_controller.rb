require "google/apis/calendar_v3"

class BookRentalsController < ApplicationController
  before_action :set_book_rental, only: %i[ show edit update destroy ]

  # GET /book_rentals or /book_rentals.json
  def index
    if current_user.admin?
      @book_rentals = BookRental.all
    else
      @book_rentals = BookRental.where(user_id: current_user.id)
    end
  end

  # GET /book_rentals/1 or /book_rentals/1.json
  def show
    authorize! :read, @book_rental, :message => "BEWARE: you are not authorized to read book rental."
    
  end

  # GET /book_rentals/new
  def new

    @book_rental = BookRental.new
    if params[:ISBN].blank?
      redirect_to(library_path)
    end

    authorize! :create, @book_rental, :message => "BEWARE: you are not authorized to rent books"

  end

  # GET /book_rentals/1/edit
  def edit
  authorize! :edit, @book_rental, :message => "BEWARE: you are not authorized to edit books"

  end

  

  # POST /book_rentals or /book_rentals.json
  def create
    @book_rental = BookRental.new(book_rental_params) 
    authorize! :create, @book_rental, :message => "BEWARE: you are not authorized to rent books"


    isbn_book = params[:book_rental][:ISBN]
    @book = Book.find_by(ISBN: isbn_book)


    if @book.present?
      @book_rental = @book.book_rental.create(book_rental_params)
      @book_rental.book_id = @book.id
      @book_rental.user_id = current_user.id
    end

    @book_rental.startDate = Date.today

    
    

      if current_user.provider == "google_oauth2"      
        service = Google::Apis::CalendarV3::CalendarService.new
        service.authorization = session[:access_token]
        service.key = Rails.application.credentials.dig(:key)
        event = Google::Apis::CalendarV3::Event.new(
          summary: @book_rental.book.ISBN,
          location: 'Sapienza Università di Roma, Piazzale Aldo Moro, 5, 00185 Roma RM, Italia',
          description:  @book_rental.book.title,
          start: Google::Apis::CalendarV3::EventDateTime.new(
            date_time: @book_rental.startDate.to_datetime
          ),
          end: Google::Apis::CalendarV3::EventDateTime.new(
            date_time: @book_rental.endDate.to_datetime
          ),
          attendees: [
            Google::Apis::CalendarV3::EventAttendee.new(
              email: current_user.email
            ),
            Google::Apis::CalendarV3::EventAttendee.new(
              email: "librarianassi@gmail.com"
            )
          ],
          reminders: Google::Apis::CalendarV3::Event::Reminders.new(
            use_default: false,
            overrides: [
              Google::Apis::CalendarV3::EventReminder.new(
                reminder_method: 'email',
                minutes: 24 * 60
              ),
              Google::Apis::CalendarV3::EventReminder.new(
                reminder_method: 'popup',
                minutes: 10
              )
            ]
          )
        )
      end
  
    check = false  

    if checkStock(service, @book)
      if event_created = service.insert_event("primary", event)
        calendar_id = event_created.id
        @book_rental.calendar_id = calendar_id

        check = true
      end
    end
#
    respond_to do |format|
      if check && @book_rental.save
        format.html { redirect_to book_rental_url(@book_rental), notice: "book_rental was successfully created." }
        format.json { render :show, status: :created, location: @book_rental }
      else
        if calendar_id.present? 
          service.delete_event("primary", calendar_id)
        end
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book_rental.errors, status: :unprocessable_entity }
      end
    end
  end

  def checkStock(service, book)
    count = 0
    result = service.list_events('librarianassi@gmail.com')
    result.items.each do |e|
      if e.summary == book.ISBN.to_s
        count += 1
      end
    end

    if count < book.stock
      true
    else
      false
    end
 
  end

 

  # PATCH/PUT /book_rentals/1 or /book_rentals/1.json
  def update
    authorize! :edit, @book_rental, :message => "BEWARE: you are not authorized to edit books rental"

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
    authorize! :destroy, @book_rental, :message => "BEWARE: you are not authorized to delete book rental"

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = session[:access_token]
    service.key = Rails.application.credentials.dig(:key)
       
    service.delete_event("primary", @book_rental.calendar_id)
    
    @book_rental.destroy

    respond_to do |format|
      format.html { redirect_to library_url, notice: "Book rental was successfully destroyed." }
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
      params.require(:book_rental).permit(:book_id, :user_id, :startDate, :endDate)
    end
end
