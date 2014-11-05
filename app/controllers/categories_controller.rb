class CategoriesController < ApplicationController
  def index
    @category = Category.all
  end

  def show
  	@category = Category.find(params[:id])
    @items = @category.items.includes(:store)
  	if @category
  		render :show
  	else
  		redirect_to root_path
  	end
  end
end
