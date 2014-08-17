class MessagesController < ApplicationController
  def index
    @messages = current_user.sent_messages + current_user.received_messages
    @messages.sort_by(&:created_at)
    render :layout => false
    #respond_to do |format|
    #  format.html { redirect_to messages_path(current_user)}
    #end
  end

  def destroy
    @message = Message.find(params[:id])
    if(@message.id%2 == 0)
    	Message.find(params[:id].to_i-1).destroy
    else
    	Message.find(params[:id].to_i+1).destroy
    end
    @message.destroy
    flash[:success] = "Message deleted."
    redirect_to root_url
  end
end