class PairRequestsController < ApplicationController
  before_action :set_pair_request, only: %i[show destroy]

  # GET /pair_requests or /pair_requests.json
  def index
    @pair_request = PairRequest.new
    filter = params[:filter] == 'past' ? :past : :upcoming
    @pair_requests = policy_scope(PairRequest).public_send(filter).order_by_status.order_by_date
  end

  # GET /pair_requests/1 or /pair_requests/1.json
  def show
    authorize @pair_request
  end

  # POST /pair_requests or /pair_requests.json
  # rubocop:disable Metrics/AbcSize
  def create
    @pair_request = current_user.authored_pair_requests.new(pair_request_params)
    @pair_request.duration = @pair_request.duration.minutes

    respond_to do |format|
      if @pair_request.save
        PairRequest::CreationNotification.with(pair_request: @pair_request).deliver(@pair_request.invitee)
        format.html { redirect_to @pair_request, notice: 'Pair request was successfully created.' }
        format.turbo_stream do
          @persisted_pair_request = @pair_request
          @pair_request = PairRequest.new
          flash.now[:notice] = 'Pair request was successfully created.'
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { flash.now[:form_errors] = @pair_request.errors.full_messages }
      end
    end
  end
  # rubocop:enable Metrics/AbcSize

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
