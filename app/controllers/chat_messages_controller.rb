class ChatMessagesController < ApplicationController
  before_action :set_chat_message, only: [:show, :edit, :update]
  before_action :set_chat, only: :send_message

  # GET /chat_messages/1
  # GET /chat_messages/1.json
  def show
  end

  # GET /chat_messages/1/edit
  def edit
  end

  # PATCH/PUT /chat_messages/1
  # PATCH/PUT /chat_messages/1.json
  def update
    respond_to do |format|
      if @chat_message.update(chat_message_params)
        format.html { redirect_to @chat_message.chat, notice: 'Chat was successfully updated.' }
        format.json { render :show, status: :ok, location: @chat_message }
      else
        format.html { render :edit }
        format.json { render json: @chat_message.errors, status: :unprocessable_entity }
      end
    end
  end

  def send_message
    msg = TelegramMessageService.new(chat: @chat,
                                     message: @chat_message.message,
                                     user: current_user)
    msg.perform
    @chat_message.update(last_sent: DateTime.now)
    flash[:notice] = "Message has been sent."
    redirect_to chat_path(@chat)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat_message
      @chat_message = ChatMessage.find(params[:id])
    end

    def set_chat
      @chat_message = ChatMessage.find(params[:message_id])
      @chat = @chat_message.chat
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chat_message_params
      params.require(:chat_message).permit(:message)
    end
end
