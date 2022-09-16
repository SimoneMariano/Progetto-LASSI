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
    authorize! :read, @reservation, :message => "BEWARE: you are not authorized to see reservations."
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
    authorize! :create, @reservation, :message => "BEWARE: you are not authorized to create reservations."
  end

  # GET /reservations/1/edit
  def edit
    authorize! :edit, @reservation, :message => "BEWARE: you are not authorized to edit reservations."
  end

  # POST /reservations or /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)

    authorize! :create, @reservation, :message => "BEWARE: you are not authorized to create reservations."

    seat_id = params[:seats]
    @seat = Seat.find(seat_id)

    if @seat.available

      @user = User.find_by(email: params[:reservation][:email])

      if @reservation.present?
        #@reservation = @seat.reservation.create(reservation_params)
        @reservation.seat_id = @seat.id
        @reservation.user_id = @user.id
        @reservation.date = @reservation.startDate.to_date
      end

      if current_user.provider == "google_oauth2"      
        service = Google::Apis::CalendarV3::CalendarService.new
        service.authorization = session[:access_token]
        service.key = Rails.application.credentials.dig(:calendar_key)
        event = Google::Apis::CalendarV3::Event.new(
          summary: @reservation.seat.name,
          location: 'Sapienza Università di Roma, Piazzale Aldo Moro, 5, 00185 Roma RM, Italia',
          description:  @reservation.email,
          start: Google::Apis::CalendarV3::EventDateTime.new(
            date_time: @reservation.startDate.to_datetime,
            time_zone: 'Europe/Rome'
          ),
          end: Google::Apis::CalendarV3::EventDateTime.new(
            date_time: @reservation.endDate.to_datetime,
            time_zone: 'Europe/Rome'
          ),
          attendees: [
            Google::Apis::CalendarV3::EventAttendee.new(
              email: @reservation.email
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

      @check = true

      def checkFree(service, reservation)
        result = service.list_events('librarianassi@gmail.com')
        result.items.each do |e|
          if e.summary == @reservation.seat.name.to_s
            if e.start.date_time <= @reservation.startDate.to_datetime and e.end.date_time >= @reservation.endDate.to_datetime
              @check = false
            elsif e.start.date_time >= @reservation.startDate.to_datetime and  e.end.date_time <= @reservation.endDate.to_datetime
              @check = false
            elsif e.start.date_time <= @reservation.startDate.to_datetime and e.end.date_time >= @reservation.startDate.to_datetime
              @check = false
            elsif e.start.date_time >= @reservation.startDate.to_datetime and e.start.date_time <= @reservation.endDate.to_datetime
              @check = false
            end
          end
        end
        if @reservation.startDate.to_datetime < Date.today
          check = false
        end  
      end
    

      checkFree(service, @reservation)
      if @check
        if event_created = service.insert_event("primary", event)
          calendar_id = event_created.id
          @reservation.calendar_id = calendar_id

          @check = true
        end
      end

    end

    respond_to do |format|
      if @check and @reservation.save
        format.html { redirect_to reservation_url(@reservation), notice: "Reservation was successfully created." }
        format.json { render :show, status: :created, location: @reservation }
      else
        if calendar_id.present? 
          service.delete_event("primary", calendar_id)
        end
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
        if @seat.available
          flash[:alert] = "Prenotazione non valida."
        else
          flash[:alert] = "Posto non disponibile."
        end
      end
    end

  end

  # PATCH/PUT /reservations/1 or /reservations/1.json
  def update
    authorize! :edit, @reservation, :message => "BEWARE: you are not authorized to edit reservations."

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

    authorize! :destroy, @reservation, :message => "BEWARE: you are not authorized to destroy reservations."


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
      params.require(:reservation).permit(:seat_id, :user_id, :email, :startDate, :endDate)
    end
end