class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @booking_conversations = Conversation.all.where('borrower_id = ?', current_user.id).page params[:page]
    @loan_conversations = Conversation.all.where('lender_id = ?', current_user.id).page(params[:page])
    @full_sanitizer = Rails::Html::FullSanitizer.new
  end

end
