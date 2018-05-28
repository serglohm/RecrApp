class TelegramMessageService
  def initialize(params)
    @chat = params[:chat].name
    @message = params[:message]
    @user = params[:user]
    @api_id = @user.telegram_api_id
    @api_hash = @user.telegram_api_hash
    @session_name = @user.name.downcase.split.join("_")
  end

  def perform
    message = "\"#{@message}\""
    Process.spawn("python3.6 script/send_message.py #{@chat} #{@api_id} #{@api_hash} #{@session_name} #{message}")
  end
end
