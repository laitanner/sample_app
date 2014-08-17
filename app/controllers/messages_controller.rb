class MessagesController < ApplicationController
  def index
    @messages = current_user.message_feed
    render :layout => false
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    flash[:success] = "Message deleted."
    redirect_to root_url
  end
end