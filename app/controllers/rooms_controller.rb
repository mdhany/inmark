class RoomsController < ApplicationController
  before_action :authenticate_login!
  before_action :set_room, only: [:show]
  #before_action :is_owner?, only: [:show]

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    @title = "Aula ##{@room.id}"
    @videos = Admin::Page.find_by_url 'roomvideos'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

  def is_owner?
    objeto = Room.find(params[:id])
    if current_login.room_id == objeto.id
      return true
    else
      redirect_to root_path, alert: 'No tienes permisos para acceder a esta página'
    end
  end
end
