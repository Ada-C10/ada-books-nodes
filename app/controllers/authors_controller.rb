class AuthorsController < ApplicationController
  def index
    @authors = Author.order(:name)
  end
  
  def show
    id = params[:id].to_i
    @author = Author.find_by(id: id)


    if @author.nil?
     render :notfound, status: :not_found
    end
  end
end
