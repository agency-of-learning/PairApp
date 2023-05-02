class AcceptancesController < ApplicationController
  before_action :find_pair_request

  def create
    @pair_request.accepted!
    flash[:notice] = 'You have accepted this pair request.'

    redirect_to pair_request_path(@pair_request)
  end

  def destroy
    @pair_request.rejected!
    # if @pair_request.acceptor == current_user
    #   if @pair_request.update(acceptor: nil)
    #     flash[:notice] = 'You have unaccepted this pair request.'
    #   else
    #     flash[:alert] = 'Something went wrong.'
    #   end
    # else
    #   flash[:alert] = 'You cannot unaccept this pair request.'
    #
    # end
    flash[:notice] = 'You have rejected this pair request'
    redirect_to pair_request_path(@pair_request)
  end

  private

  def find_pair_request
    @pair_request = PairRequest.find(params[:pair_request_id])
  end
end
