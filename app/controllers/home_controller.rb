class HomeController < ApplicationController
  def index
  end

  def show
  end

  def code
    redirect_to 'https://github.com/glenegbert/the_pivot'
  end
end
