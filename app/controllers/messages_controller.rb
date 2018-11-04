class MessagesController < ApplicationController

  before_action :authenticate_user!
  before_action :find_listing
  before_action :set_conversation, only: [:create]

  def new
  end

  def create
    message = @conversation.messages.build(body: params[:body], user_id: current_user.id)
    if message.save
      flash[:success] = "Message envoyé avec succès."
      redirect_to conversation_path(@conversation)
    else
      render "conversations/show"
      Rails.logger.debug("Impossible d'envoyer votre message. Veuillez réessayer.")
    end
  end

  private

  def find_listing
    @listing = Listing.find(params[:listing_id])
  end

  def set_conversation
    conversations = Conversation.all.where('borrower_id = ? and lender_id = ?', current_user.id, @listing.user.id)
    if conversations.present?
      @conversation = conversations.last
    else
      @conversation = Conversation.create(borrower_id: current_user.id, lender_id: @listing.user.id)
    end
  end

end
