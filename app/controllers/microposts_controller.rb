class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  respond_to :html, :xml

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
    else
      flash[:error] = "Invalid micropost content error."
      @feed_items = []
    end
    respond_with(@micropost) do |format|
      format.html { redirect_to root_url }
      format.xml
    end
  end

  def destroy
    @micropost.destroy
    respond_with(@micropost) do |format|
      format.html { redirect_to root_url }
      format.xml
    end
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