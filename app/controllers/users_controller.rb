class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @currentUserEntry = Entry.where(user_id: current_user.id)
    # showページのuserのuser_idが含まれるEntryレコードを探す
    @userEntry = Entry.where(user_id: @user.id)
    # current_userのuser_idが含まれるEntryレコードを探す
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id
            # お互いに同じroom_idのentryレコードを持っているとき = 既にルームが作成されている
            @haveRoom = true
            ルーム持っている
            @roomId = cu.room_id
            # 作成済みのルームにアクセスするためのキー
            # ルームIDはcuでもuでもどちらでも同じ
          end
        end
      end
    end
    unless @haveRoom
      # @haveRoomがtrueでないとき = 自分のshowページを見ている||共通のルームIDを持っていない（まだルームの作成がされていない）
      @room = Room.new
      @entry = Entry.new
      # 新しいRoomレコードとentryレコードを作成する準備
    end
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "users/edit"
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render "users/edit"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
