class ChatsController < ApplicationController
  
  def show
    user_id = params[:id]
    followed_id = params[:user_id]
    @chat = Chat.new
    @chats = Chat.where(user_id: user_id, followed_id: followed_id)
    # フォローしているユーザーの取得
    @user = User.find(followed_id)
  end
  
  def create
    @chat = Chat.new(chat_params)
    @chat.user_id = current_user.id
    @chat.save
    redirect_to user_chat_path(@chat.followed_id, @chat.user_id)
  end
  
  def destroy
  end
  
  private
  
  def chat_params
    params.require(:chat).permit(:body, :followed_id)
  end
  
end
