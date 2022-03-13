class SearchesController < ApplicationController
  def search
    @range = params[:range]

    if @range == "User"
      @users = User.looks(params[:word])
    else
      @courses = Course.looks(params[:word])
    end
  end
end
