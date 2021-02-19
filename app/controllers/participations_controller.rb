class ParticipationsController < ApplicationController
  before_action :set_participation, only: %i[ show edit update destroy ]
  before_action :set_event, only: %i[ create ]


  # GET /participations or /participations.json
  def index
    @participations = Participation.all
  end

  # GET /participations/1 or /participations/1.json
  def show
  end

  # GET /participations/new
  def new
    @participation = Participation.new
  end

  # GET /participations/1/edit
  def edit
  end

  # POST /participations or /participations.json
  def create

    if current_user == nil
      redirect_to @event
      flash.alert = "Not connected cannot participate"
    elsif current_user != nil && current_user.id != @event.user.id

      @participation = Participation.new(user_id: current_user.id, event_id: params[:event_id] )

      if @participation.save
        redirect_to @event
        flash.notice = "Participation bien enregistré"
      else
        render :new
      end

    elsif current_user != nil && current_user.id == @event.user.id
      redirect_to @event
      flash.notice = "owner => u can't participate"
    end

    

  end

  # PATCH/PUT /participations/1 or /participations/1.json
  def update
    respond_to do |format|
      if @participation.update(participation_params)
        format.html { redirect_to @participation, notice: "Participation was successfully updated." }
        format.json { render :show, status: :ok, location: @participation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @participation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participations/1 or /participations/1.json
  def destroy
    @participation.destroy
    respond_to do |format|
      format.html { redirect_to participations_url, notice: "Participation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_participation
      @participation = Participation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def participation_params
      params.fetch(@event.user.id)
    end

    def set_event
      @event = Event.find(params[:event_id])
    end

end

