class Admin::StoresController < Admin::BaseController

  def index
    @authorized_stores = Store.where(:authorized => true)
    @stores_waiting_approval = Store.where(:authorized => false)
  end

  def show
  end

  def new
    @store = Store.new
  end

  def create
    @store = Store.create(store_params)
    if @store.save
      flash[:notice] = "Thanks for your store request, check your inbox for a response."
      redirect_to root_path
    else
      flash[:notice] = "Unable to process your request."
      render :new
    end
  end

  def update
    @store = Store.find(params[:id])
    @store.update(store_params)
    redirect_to admin_stores_path
  end

  def destroy
    Store.find(params[:id]).destroy
    redirect_to admin_stores_path
  end
  def store_params
    params.require(:store).permit(:name, :description, :image, :slug, :request_message, :user_id, :authorized, :online)
  end
end