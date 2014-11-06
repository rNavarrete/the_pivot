class StoresController < ApplicationController

  def show
    @store = Store.where(slug: params[:store_name]).first
    if @store
      render :show
    else
      redirect_to root_path
    end
  end

  def new
    @store = Store.new
  end
end
