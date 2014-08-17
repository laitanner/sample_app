class MessagesController < ApplicationController
  def index
    @messages = current_user.message_feed
    render :layout => false
    #respond_to do |format|
    #  format.html { redirect_to messages_path(current_user)}
    #end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    flash[:success] = "Message deleted."
    redirect_to root_url
  end
end