class AcceptancesController < ApplicationController
  before_action :find_pair_request

  def create
    if @pair_request.acceptor.blank?
      if @pair_request.update(acceptor: current_user)
        flash[:notice] = 'You have accepted this pair request.'
      else
        flash[:alert] = 'Something went wrong.'
      end
    else
      flash[:alert] = 'This pair request has already been accepted.'
    end
    redirect_to pair_request_path(@pair_request)
  end

  def destroy
    if @pair_request.acceptor == current_user
      if @pair_request.update(acceptor: nil)
        flash[:notice] = 'You have unaccepted this pair request.'
      else
        flash[:alert] = 'Something went wrong.'
      end
    else
      flash[:alert] = 'You cannot unaccept this pair request.'
    end
    redirect_to pair_request_path(@pair_request)
  end

  private

  def find_pair_request
    @pair_request = PairRequest.find(params[:pair_request_id])
  end
end
