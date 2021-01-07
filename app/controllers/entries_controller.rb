class EntriesController < ApplicationController
  
  def create
    @room = Room.create
    # roomには他にカラムは必要ないためこのまま作成
    @joinCurrentUser = Entry.create(user_id: current_user.id, room_id: @room.id)
    # curretn_userのuser_idと１行目で作ったroom IDの入ったentryレコードを作成
    @joinUser = Entry.create(entry_params)
    # フォームで受け取ったuser_idと、１行目で作った@roomのidをストロングパラメータにmergeして作成したjoin_room_paramsを入れたEntryのインスタンスをcreate
    @first_message = @room.messages.create(user_id: current_user.id, message: "初めまして！")
    # ルームを作成した一言目の挨拶を自動生成
    redirect_to room_path(@room.id)
    # 今作成したroomのshowページにリダイレクト
  end
  
  private
  def entry_params
    params.require(:entry).permit(:user_id).merge(room_id: @room.id)
  end
  
  
end
