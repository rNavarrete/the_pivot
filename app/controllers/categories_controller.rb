class CategoriesController < ApplicationController
  def index
    @category = Category.all
  end

  def show
  	@category = Category.find(params[:id])
    @items = @category.items_from_active_and_online_stores
  	if @category
  		render :show
  	else
  		redirect_to root_path
  	end
  end
end
