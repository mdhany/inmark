class Admin::PaymentsController < ApplicationController
  before_action :authenticate_manager!
  before_action :set_admin_payment, only: [:activate, :show, :edit, :update, :destroy]

  # GET /admin/payments
  # GET /admin/payments.json
  def index
    @admin_payments = Admin::Payment.all.reverse_order
  end

  def activations
    @admin_payments = Admin::Payment.where type_p: 0, status: 0
  end

  def activate #Esta accion es para los logins del level 1
    if activating_user(@admin_payment)
      if @admin_payment.login.room.logins.size == 7
        #CERRAR CICLO en ROOM si tiene 7 logins
        close_cycle_room(@admin_payment.login.room.logins.level_three.first)
      end
      redirect_to admin_activations_path, notice: 'Usuario Fue Activado y ubicado en Aula.'
    else
      redirect_to admin_activations_path, alert: 'El Usuario no pudo ser Activado'
      logger.debug "No pudo Activar Pago y el Usuario"
    end
  end

  def close_room
    login = Login.find params[:id]
    if close_cycle_room(login)
      redirect_to dashboard_path, notice: 'Room fue Cerrada'
    end
    render false
  end

  # GET /admin/payments/1
  # GET /admin/payments/1.json
  def show
  end

  # GET /admin/payments/new
  def new
    @admin_payment = Admin::Payment.new
  end

  # GET /admin/payments/1/edit
  def edit
  end

  # POST /admin/payments
  # POST /admin/payments.json
  def create
    @admin_payment = Admin::Payment.new(admin_payment_params)

    respond_to do |format|
      if @admin_payment.save
        format.html { redirect_to admin_payments_path, notice: 'Payment was successfully created.' }
        format.json { render :show, status: :created, location: @admin_payment }
      else
        format.html { render :new }
        format.json { render json: @admin_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/payments/1
  # PATCH/PUT /admin/payments/1.json
  def update
    respond_to do |format|
      if @admin_payment.update(admin_payment_params)
        format.html { redirect_to edit_admin_payment_path(@admin_payment), notice: 'Payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_payment }
      else
        format.html { render :edit }
        format.json { render json: @admin_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/payments/1
  # DELETE /admin/payments/1.json
  def destroy
    @admin_payment.destroy
    respond_to do |format|
      format.html { redirect_to admin_payments_url, notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_payment
      @admin_payment = Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_payment_params
      params.require(:admin_payment).permit(:amount, :coupon_id, :status, :gateway, :level_id, :login_id, :type_p)
    end


end
