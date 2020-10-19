class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @book = Book.new
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have creatad book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render 'books/index'
    end
  end

  def show
    @book = Book.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "books/edit"
    else
      redirect_to books_path
    end
  end

  def update
      @book = Book.find(params[:id])
    if  @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render "books/edit"
    end
  end

  def destroy
    book = Book.find(params[:id])
    if book.destroy
      flash[:notice] = "You have deleted book successfully."
      redirect_to books_path
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

end
