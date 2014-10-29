class StoresController < ApplicationController

  def show
  	@store = Store.where(name: params[:id]).first
  	if @store
  		render :show
  	else
  		redirect_to root_path
  	end
  end
end
