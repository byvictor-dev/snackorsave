class BlacklistsController < ApplicationController

  before_action :authenticate_user!

  def index
    @blacklists = current_user.blacklists
  end

  def new
    @blacklist = Blacklist.new
  end

  def edit
    @blacklist = Blacklist.find(params[:id])
  end

  def create
    @blacklist = Blacklist.new(blacklist_params)
    @blacklist.user = current_user
    if @blacklist.save
      redirect_to blacklists_path and return
    end
  end

  def update
    @blacklist = Blacklist.find(params[:id])
    if @blacklist.update(blacklist_params)
      redirect_to blacklists_path and return
    end
  end

  private

    def blacklist_params
      params.require(:blacklist).permit(:id, :blocked, :title, :merchant_name)
    end
end
