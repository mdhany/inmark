class RoomsController < ApplicationController
  before_action :set_room, only: [:show]
  #before_action :is_owner?, only: [:show]

  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = Room.all
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    @title = "Aula ##{@room.id}"
    @l_one = @room.logins.level_one
    @l_two = @room.logins.level_two
    @l_three = @room.logins.level_three
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params[:room]
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
