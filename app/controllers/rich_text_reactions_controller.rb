class RichTextReactionsController < ApplicationController
  before_action :build_rich_text_reaction, only: %i[create]
  before_action :set_rich_text_reaction, only: %i[destroy]

  # POST /rich_text_reactions.turbo_stream
  def create
    if @rich_text_reaction.save
      render :create, status: :created
    else
      flash.now[:alert] = 'Reaction could not be created.'
    end
  end

  # DELETE /rich_text_reactions/:id.turbo_stream
  def destroy
    msg = 'Reaction could not be deleted.'
    flash.now[:alert] = msg unless @rich_text_reaction.destroy
  end

  private

  def build_rich_text_reaction
    @rich_text_reaction = current_user.rich_text_reactions.build(
      rich_text_reaction_params
    )
  end

  def set_rich_text_reaction
    @rich_text_reaction = RichTextReaction.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash.now[:alert] = "RichTextReaction with id #{params[:id]} could not be found."
  end

  def rich_text_reaction_params
    params.require(:rich_text_reaction).permit(:emoji_caption, :rich_text_id)
  end
end
