class HomeController < ApplicationController

  def index
    redirect_to search_index_path if logged_in? and !request.smart_phone?
  end

  def search
    redirect_to root_path if request.smart_phone?
  end
end
