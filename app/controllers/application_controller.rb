class ApplicationController < ActionController::Base
  before_action :set_cache_headers
  before_action :find_user


    private

    def find_user
      @current_user = Author.find_by(id: session[:user_id])
    end

    def set_cache_headers
      response.headers["Cache-Control"] = "no-cache, no-store"
      response.headers["Pragma"] = "no-cache"
      response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
    end
end
