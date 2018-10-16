class SessionsController < ApplicationController
  # def login
  #   author = Author.find_by(name: params[:author][:name])
  #
  #   if author.nil?
  #     # Create a new author
  #     author = Author.create(name: params[:author][:name])
  #   end
  #
  #   session[:user_id] = author.id
  #   flash[:success] = "#{author.name} Successfully logged in!"
  #   redirect_to root_path
  # end
  #
  # def new
  #   @author = Author.new
  # end
  #
  # def destroy
  #   session[:user_id] = nil
  #   flash[:success] = 'Successfully logged out'
  #   redirect_back fallback_location: root_path
  # end

  def create
    auth_hash = request.env['omniauth.auth']
    user = User.find_by(uid: auth_hash[:uid], provider: 'github')
    if user
      # User was found in the database
      flash[:success] = "Logged in as returning user #{user.name}"
    else
      # User doesn't match anything in the DB
      # Attempt to create a new user
      user = User.build_from_github(auth_hash)

      if user.save
        flash[:success] = "Logged in as new user #{user.name}"

      else
        # Couldn't save the user for some reason. If we
        # hit this it probably means there's a bug with the
        # way we've configured GitHub. Our strategy will
        # be to display error messages to make future
        # debugging easier.
        flash[:error] = "Could not create new user account: #{user.errors.messages}"
        redirect_to root_path
        return
      end
    end

    session[:user_id] = user.id
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Successfully logged out!"

    redirect_to root_path
  end
end
