class PaymentsController < ApplicationController
  before_action :authenticate_login!
  before_action :set_payment, only: [:show, :edit, :update, :destroy]
  before_action :is_beneficiary?, only: [:confirmation]
  before_action :is_owner?, only: [:show]

  # GET /payments
  # GET /payments.json
  def index
    @payments = current_login.payments

  end

  # GET /payments/1
  # GET /payments/1.json
  def show
  end

  # GET /payments/new
  def new
    if view_context.have_capacity?(params[:level_id].to_i)
      @turnp = Turn.find params[:turn_id]
      @payment = Payment.new
      @gateways = [
          [@turnp.login.account_type, @turnp.login.account_type],
          ['Western Union', 'Western Union'],
          ['Paypal', 'Paypal']
      ]
      @gateways.delete(2) if !@turnp.login.paypal.nil?

    else
      redirect_to root_path, alert: 'Actualmente no tienes Capacidad para realizar un Pago. Espera que tu Turno este completado'
    end

  end


  # GET /payments/1/edit
  def edit
  end

  # POST /payments
  # POST /payments.json
  def create
    @payment = Payment.new(permitir)
    @payment.login_id = current_login.id #Usado para asignar el pago al usuario que esta logueado

    respond_to do |format|
      if @payment.save
        format.html { redirect_to @payment, notice: 'La solicitud ha sido enviada exitosamente. Se estará procesando en máximo 24 horas.' }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { redirect_to root_path, alert: @payment.errors }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to @payment, notice: 'Payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end


  def upload
    uploaded_io = params[:receipt]
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
      redirect_to @payment, notice: 'Imagen subida'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params[:payment]
    end

    def get_t_position
      Turn.find_by_status('active')
    end

  def permitir
    params.require(:payment).permit(:amount, :gateway, :login_id, :level_id, :coupon_id, :type_p, :receipt, :comment)
  end

  def is_owner?
    @payment = Payment.find(params[:id])
    if current_login.id == @payment.login_id
      return true
    else
      redirect_to root_path, alert: 'No tienes permisos para acceder a esta página'
    end
  end


end
