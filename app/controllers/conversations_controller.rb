class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_full_sanitizer, only: [:index, :show]

  def index
    @booking_conversations = Conversation.all.where('borrower_id = ?', current_user.id).page(params[:page]).per(10)
    @loan_conversations = Conversation.all.where('lender_id = ?', current_user.id).page(params[:page]).per(10)
  end

  def show
    @conversation = Conversation.find(params[:id])
    @recever = @conversation.borrower_id != current_user.id ? User.find(@conversation.borrower_id) : User.find(@conversation.lender_id)
  end

  def set_full_sanitizer
    @full_sanitizer = Rails::Html::FullSanitizer.new
  end

end
