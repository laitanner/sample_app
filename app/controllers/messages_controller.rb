class MessagesController < ApplicationController
  def index
    respond_to do |format|
      format.html { redirect_to root_path } #for my controller, i wanted it to be JS only
      format.js
    end
    #@messages = Message.paginate(page: params[:page])
  end
end