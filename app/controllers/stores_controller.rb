class StoresController < ApplicationController

  def show
    @store = Store.where(slug: params[:store_name]).first
    if @store
      render :show
    else
      redirect_to root_path
    end
  end

  def create
    @store = Store.create(store_params)
    current_user.update(:role => "seller")
    if @store.save
      flash[:notice] = "Thanks for your store request, check your inbox for a response."
      redirect_to root_path
    else
      flash[:notice] = "Unable to process your request."
      render :new
    end
  end

  def new
    @store = Store.new
  end

  private
  def store_params
    params.require(:store).permit(:name, :description, :image, :slug, :request_message, :user_id)
  end
end
