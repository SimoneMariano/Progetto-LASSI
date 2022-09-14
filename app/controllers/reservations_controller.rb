require "google/apis/calendar_v3"

class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[ show edit update destroy ]

  # GET /reservations or /reservations.json
  def index
    if current_user.admin?
      @reservations = Reservation.all
    else
      @reservations = Reservation.where(user_id: current_user.id)
    end
  end

  # GET /reservations/1 or /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations or /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)
    
    seat_id = params[:seats]
    @seat = Seat.find(seat_id)

    @user = current_user

    if @reservation.present?
      #@reservation = @seat.reservation.create(reservation_params)
      @reservation.seat_id = @seat.id
      @reservation.user_id = @user.id
    end

    if current_user.provider == "google_oauth2"      
      service = Google::Apis::CalendarV3::CalendarService.new
      service.authorization = session[:access_token]
      service.key = Rails.application.credentials.dig(:calendar_key)
      event = Google::Apis::CalendarV3::Event.new(
        summary: @reservation.seat.description,
        location: 'Sapienza Università di Roma, Piazzale Aldo Moro, 5, 00185 Roma RM, Italia',
        description:  @reservation.seat.name,
        start: Google::Apis::CalendarV3::EventDateTime.new(
          date_time: @reservation.startDate.to_datetime
        ),
        end: Google::Apis::CalendarV3::EventDateTime.new(
          date_time: @reservation.endDate.to_datetime
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

    if event_created = service.insert_event("primary", event)
      calendar_id = event_created.id
      @reservation.calendar_id = calendar_id
    end


    respond_to do |format|
      if @reservation.save
        format.html { redirect_to reservation_url(@reservation), notice: "Reservation was successfully created." }
        format.json { render :show, status: :created, location: @reservation }
      else
        if calendar_id.present? 
          service.delete_event("primary", calendar_id)
        end
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1 or /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to reservation_url(@reservation), notice: "Reservation was successfully updated." }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1 or /reservations/1.json
  def destroy

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = session[:access_token]
    service.key = Rails.application.credentials.dig(:key)
       
    service.delete_event("primary", @reservation.calendar_id)

    @reservation.destroy

    respond_to do |format|
      format.html { redirect_to reservations_url, notice: "Reservation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reservation_params
      params.require(:reservation).permit(:seat_id, :user_id, :startDate, :endDate)
    end
end
