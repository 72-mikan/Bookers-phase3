class RoomsController < ApplicationController
  before_action :authenticate_user!

  def create
    room = Room.create
    Entry.create(user_id: current_user.id, room_id: room.id)
    Entry.create(user_id: params[:entry][:user_id], room_id: room.id)
    redirect_to room_path(room.id)
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages.all
    @message = Message.new
    @entries = @room.entries
    @another_entry = @entries.where.not(user_id: current_user.id).first
    #相互フォローしていない
    @entries.each do |entry|
      unless entry.user_id == current_user.id
        unless current_user.following?(entry.user) && entry.user.following?(current_user)
          #binding.pry
          redirect_to user_path
        end
      end
    end
  end
end
