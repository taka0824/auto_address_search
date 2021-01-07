class PracticesController < ApplicationController

  def search
    @range = params[:range]
    word = params[:word]
    if @range == "1"
      @users = User.where('name like ?',"%#{word}%")
    elsif @range == "2"
      @books = Book.where('title like ?',"%#{word}%")
    end
  end

  def search_box
  end

end
