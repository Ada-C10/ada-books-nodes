class SessionsController < ApplicationController
  def login
    author = Author.find_by(name: params[:author][:name])

    if author.nil?
      # Create a new author
      author = Author.create(name: params[:author][:name])
    end

    session[:user_id] = author.id
    flash[:success] = "#{author.name} Successfully logged in!"
    redirect_to root_path
  end

  def new
    @author = Author.new
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'Successfully logged out'
    redirect_back fallback_location: root_path
  end
end
