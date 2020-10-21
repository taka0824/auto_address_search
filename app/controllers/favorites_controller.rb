class FavoritesController < ApplicationController
    before_action :authenticate_user!

def create
    @book = Book.find(params[:book_id])
    favorite = Favorite.new(book_id: @book.id)
    favorite.user = current_user
    favorite.save
end

def destroy
    @book = Book.find(params[:book_id])
    favorite = Favorite.find_by(book_id: @book.id)
    favorite.user = current_user
    favorite.destroy
end

end
