class PairRequestsController < ApplicationController
  before_action :set_pair_request, only: %i[show destroy]

  # GET /pair_requests or /pair_requests.json
  def index
    Rails.logger.info "Turbo-Frame: #{request.headers['Turbo-Frame']}"

    case params[:filter]
    when 'past'
      @pair_requests = policy_scope(PairRequest).past.order_by_status.order_by_date
      render "index", locals: { pair_requests: @pair_requests }
    when 'upcoming'
      @pair_requests = policy_scope(PairRequest).upcoming.order_by_status.order_by_date
    end
    @pair_requests = policy_scope(PairRequest).order_by_status.order_by_date

   respond_to do |format|
    format.html
    format.turbo_stream {
      if request.headers["Turbo-Frame"]
        render partial: "pair_requests_table", locals: { pair_requests: @pair_requests }
      end
    }
   end
  end

  # GET /pair_requests/1 or /pair_requests/1.json
  def show
    authorize @pair_request
  end

  # GET /pair_requests/new
  def new
    @pair_request = PairRequest.new
  end

  # POST /pair_requests or /pair_requests.json
  def create
    @pair_request = current_user.authored_pair_requests.new(pair_request_params)
    @pair_request.duration = @pair_request.duration.minutes

    respond_to do |format|
      if @pair_request.save
        format.html do
          redirect_to pair_request_url(@pair_request),
            notice: 'Pair request was successfully created.'
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pair_requests/1 or /pair_requests/1.json
  def destroy
    authorize @pair_request
    @pair_request.destroy

    respond_to do |format|
      format.html do
        redirect_to pair_requests_url, notice: 'Pair request was successfully destroyed.'
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_pair_request
    @pair_request = PairRequest.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def pair_request_params
    params.require(:pair_request).permit(:invitee_id, :when, :duration)
  end
end
