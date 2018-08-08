class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @conversation = Conversation.find(params[:conversation_id])
    message = @conversation.messages.build(message_params)
    if message.save
      redirect_to conversation_path(@conversation)
      Rails.logger.debug("Message envoyé avec succès.")
    else
      render "conversations/show"
      Rails.logger.debug("Impossible d'envoyer votre message. Veuillez réessayer.")
    end
  end

  private

  def message_params
    params.require(:message).permit(:body).merge(user_id: current_user.id)
  end

end
