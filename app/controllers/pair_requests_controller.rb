class PairRequestsController < ApplicationController
  before_action :set_pair_request, only: %i[ show edit update destroy add_feedback]

  # GET /pair_requests or /pair_requests.json
  def index
    @pair_requests = PairRequest.all
  end

  # GET /pair_requests/1 or /pair_requests/1.json
  def show
  end

  # GET /pair_requests/new
  def new
    @pair_request = PairRequest.new
  end

  # GET /pair_requests/1/edit
  def edit
  end

  # POST /pair_requests or /pair_requests.json
  def create
    @pair_request = current_user.pair_requests_as_author.new(pair_request_params)

    respond_to do |format|
      if @pair_request.save
        format.html { redirect_to pair_request_url(@pair_request), notice: "Pair request was successfully created." }
        format.json { render :show, status: :created, location: @pair_request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @pair_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pair_requests/1 or /pair_requests/1.json
  def update
    respond_to do |format|
      if @pair_request.update(pair_request_params)
        format.html { redirect_to pair_request_url(@pair_request), notice: "Pair request was successfully updated." }
        format.json { render :show, status: :ok, location: @pair_request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @pair_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pair_requests/1 or /pair_requests/1.json
  def destroy
    @pair_request.destroy

    respond_to do |format|
      format.html { redirect_to pair_requests_url, notice: "Pair request was successfully destroyed." }
      format.json { head :no_content }
    end
  end 

  
  def add_feedback
    render :feedback_form
  end

  def feedback_by_author
    rendr :feedback_form
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pair_request
      @pair_request = PairRequest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pair_request_params
      params.require(:pair_request).permit(:when, :duration, :author_overall_rating, :acceptor_overall_rating, :author_partner_rating, :acceptor_partner_rating, :author_comment, :acceptor_comment, :author_id, :acceptor_id )
    end
end
