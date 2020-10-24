class PostCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    @post_comment = PostComment.new(post_comment_params)
    @post_comment.user_id = current_user.id
    @post_comment.book_id = @book.id
    @post_comment.save
    # コメント成功失敗に限らず、create.js.erbを通ることで、成功の際にはコメントの追加とテキストエリアを空白にし、失敗の際はエラーコメント出す
  end

  def destroy
    PostComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    @book = Book.find(params[:book_id])
    # destroy.js.erbのレンダーで@bookを渡す必要があるためここで作成しておく
  end

  private
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
