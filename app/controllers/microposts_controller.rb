class MicropostsController < ApplicationController
  include ApplicationHelper
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if(@micropost.message_recipient != 0)
      make_message(current_user, @micropost)
      flash[:success] = "Message created!"
      redirect_to root_url
    else
      if (@micropost.save)
        @micropost.set_to_id
        flash[:success] = "Micropost created!"
        redirect_to root_url
      else
        @feed_items = []
        render 'static_pages/home'
      end
    end
  end

  def destroy
    @micropost.destroy
    redirect_to root_url
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end