class ViewReservationsController < ApplicationController
  before_action :set_view_reservation, only: %i[ show edit update destroy ]

  # GET /view_reservations or /view_reservations.json
  def index
    @view_reservations = ViewReservation.all
  end

  # GET /view_reservations/1 or /view_reservations/1.json
  def show
  end

  # GET /view_reservations/new
  def new
    @view_reservation = ViewReservation.new
  end

  # GET /view_reservations/1/edit
  def edit
  end

  # POST /view_reservations or /view_reservations.json
  def create
    @view_reservation = ViewReservation.new(view_reservation_params)

    respond_to do |format|
      if @view_reservation.save
        format.html { redirect_to view_reservation_url(@view_reservation), notice: "View reservation was successfully created." }
        format.json { render :show, status: :created, location: @view_reservation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @view_reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /view_reservations/1 or /view_reservations/1.json
  def update
    respond_to do |format|
      if @view_reservation.update(view_reservation_params)
        format.html { redirect_to view_reservation_url(@view_reservation), notice: "View reservation was successfully updated." }
        format.json { render :show, status: :ok, location: @view_reservation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @view_reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /view_reservations/1 or /view_reservations/1.json
  def destroy
    @view_reservation.destroy

    respond_to do |format|
      format.html { redirect_to view_reservations_url, notice: "View reservation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_view_reservation
      @view_reservation = ViewReservation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def view_reservation_params
      params.fetch(:view_reservation, {})
    end
end
