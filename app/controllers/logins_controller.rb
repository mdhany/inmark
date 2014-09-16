class LoginsController < ApplicationController
  before_action :authenticate_login!
  before_action :set_login, only: [:wizard_turn, :ref_selection, :my_turns]
  before_action :is_your_level?, only: :wizard_turn
  before_action :is_sponsor?, only: :login_activity

  def index
    @logins = current_login.referrals
  end

  def dashboard
    #Busca la primera página que es la del DAHSBOARD
    @dash_page = Admin::Page.find 1

  end

  def salir
    sign_out :login if login_signed_in?
    sign_out :manager if manager_signed_in?
  end

  def activation
    @title = "Activa tu cuenta"
    @payment = Payment.new
    @payment.level_id = current_login.level_id
    @payment.type_p = 0
    #@payment.coupon_id = current_login.coupons.find_by(type_c: 0).id
    @payment.amount = current_login.level.amount


  end

  def wizard_turn
    @login_level = view_context.what_level(params[:level_id].to_i, @logged)
    #Buscar TODOS ó un referidos que su capacidad de esa fila este en status = 'pagado'
    @referrals = @logged.referrals.where("level_id >= ? AND used = ?", params[:level_id].to_i, false)
  end

  #P: Si es el Sponsor
  def login_activity
    #Buscar el login y almacenar
    @login = Login.find params[:id]

  end

private
  def set_login
    @logged = Login.find current_login
  end

  def is_sponsor?
    @login = Login.find params[:id]
    if current_login.id == @login.sponsor_id
      return true
    else
      redirect_to mis_referidos_path, alert: 'No tienes permisos para acceder a esta página'
    end
  end

end
