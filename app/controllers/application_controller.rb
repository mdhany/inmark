class ApplicationController < ActionController::Base
  #Settings

  #layout 'admin'
  layout :layout_by_resource

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #Permitir cambiar los campos añadidos al Logins
  before_action :configure_permitted_parameters, if: :devise_controller?


  protected
  def layout_by_resource
    if devise_controller? && controller_name == 'sessions' && action_name == 'new' || controller_name == 'passwords' && action_name == 'new'
      'login'
    else
      'admin'
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:username, :first_name, :last_name, :identification, :phone, :mobile, :country, :city, :state, :address, :account_type, :number_account, :paypal, :skype,
               :email, :password, :password_confirmation, :current_password)
    end

    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:username, :first_name, :last_name, :identification, :phone, :mobile, :sponsor_id, :country, :city, :state, :address, :account_type, :number_account, :paypal, :skype,
               :email, :password, :password_confirmation, :current_password, :level_id)
    end
  end

  # Change status of Model after payment creation
  def change_status(object, status)
    object.update_attribute :status, status
  end

  # Para conceder permisos si tiene ese nivel
  def is_your_level?
    if current_login.level_id >= params[:level_id].to_i
      return true
    else
      redirect_to root_path, alert: 'No tienes permisos para acceder a esta página'
    end
  end

  def complete_payment(p)
    p.update_attribute :status, true
  end

  def change_login_activated(l)
    l.update_attribute :activated, true
  end



  def activating_user(payment)
    if complete_payment(payment) #Confirmando Pago
      if change_login_activated(payment.login) #Cambiar a Login Activado
        register_in_room(payment.login) #Registrar en Room
      end
    end
  end


  def pay_login_comision(login, amount)
    #Se crea un pago, con status true porque ya estara en su billetera disponible
    @admin_payment = Payment.new(
        amount: amount,
        login_id: login.id,
        level_id: login.level_id,
        comment: "Comisión por Ciclo Finalizado",
        type_p: 2,
        coupon_id: login.coupons.comision.id,
        status: true
    )
    #si se crea el pago, actualizar balance
    if @admin_payment.save
      #actualizar cupon del login
      a_actual = login.coupons.comision.amount
      total = a_actual + amount
      login.coupons.comision.update_attribute :amount, total
    end

  end

  def pay_login_mlm(login, amount)
    #Este Pago se crea con status false, hasta que el admin genere el cupón OKPAY y entonces lo modifique
    @admin_payment = Payment.create!(
        amount: amount,
        login_id: login.id,
        level_id: login.level_id,
        comment: "ID OKPAY: En proceso...",
        type_p: 2,
        coupon_id: login.coupons.mlm.id,
        status: false
    )
    #si se crea el pago, actualizar balance
    if @admin_payment.save
      #actualizar cupon del login
      a_actual = login.coupons.mlm.amount
      total = a_actual + amount
        if login.coupons.mlm.update_attribute :amount, total #Si le emite el pago
          login.update_attribute :mlm_started, true #Actualizar que ya tiene el cupon para SWISS
        end
    end
  end

  def dividing_room(values={})
    #crear las 2 nuevas Room
    @room = Room.create!(level_id: values[:level])
    #actualizar los 6 usuarios, room_id y position
    [values[:l_one],values[:l_two], values[:l_three]].each_with_index do |l, i|
      l.update_attributes! room_id: @room.id, position: i+1
    end

    @room2 = Room.create!(level_id: values[:level])
    #actualizar los 6 usuarios, room_id y position
    [values[:r_one],values[:r_two], values[:r_three]].each_with_index do |l, i|
      l.update_attributes! room_id: @room2.id, position: i+1
    end

  end

  def close_cycle_room(login) #El Login es el posicion 1 del room a cerrar (l.level_three)

    #cambiar status de ROOM a completado que es FALSE
    if change_status(login.room, false)
      #Pagar al posicion 1
      if login.level_id == 1 && login.mlm_started == false
        #si es level 1, pagar comision
        pay_login_comision(login, 50) #dolares
      elsif login.level_id == 2 && login.mlm_started == false
        #si es level 2, por primera vez, pagar cupon MLM
        pay_login_mlm(login, 220) #euro
      elsif login.level_id >= 2 && login.mlm_started == true
        #si es level 2, por segunda y más, pagar comision
        pay_login_comision(login, 225) #dolares
      else
        logger.debug "No se pudo Pagar Comision del login #{login}"
      end

      #DIVIDIR EN 2 ROOM
      #Aqui se listan todos los usuarios de la Room a dividir y se asigna el nuevo room al position 1
      log = login.room.logins
      l2 = log.level_two
      l1 = log.level_one

      if  dividing_room(
          l_one: l2.first, l_two: l1.first, l_three: l1.second,
          r_one: l2.last, r_two: l1.third, r_three: l1.fourth,
          level: login.level_id
      )
        #Cambiar status del login que cobro
        if login.level_id == 1
          login.update_attribute :level_id, 2
        end
        #asignarle una nueva room
        if register_in_room(login)
          logger.debug "El Login fue registrado en el aula: #{login.room.id}"

          #------------------------
          #ROOM LEVEL 2
          #si el NUEVO room donde se ha registrado a este login es nivel 2 y esta LLENO (7)
          ro = login.room
          if ro.logins.size == 7
            close_cycle_room(lo.logins.level_three.first)
          end
          #CERRAR el ROOM

        else
          logger.debug "No se pudo REGISTRAR en el Room: #{login.id}"
        end

      else
        logger.debug "No se pudo DIVIDIR el Room: #{login.room}"
      end
    end
  end

  #Actualizar los espacios disponibles del Room
  def update_room_position_free(room, side)
    if side == "left_nextp" && room.left_nextp == 5
      room.update_attribute side.to_sym, 0
    elsif side == "left_nextp" && room.left_nextp == 4
      room.update_attribute side.to_sym, 5
    elsif side == "right_nextp" && room.right_nextp == 7
      room.update_attribute side.to_sym, 0
    elsif side == "left_nextp" && room.right_nextp == 6
      room.update_attribute side.to_sym, 7
    else
      logger.debug "Room Lleno #{room.logins}"
    end
  end

  def get_next_position(l)
    ps = l.sponsor.position
    rs = l.sponsor.room

    if ps == 2 #Si es el lado izq del segundo nivel
      if rs.left_nextp == 0 #si el lado izq esta lleno, enviar al derecho

        if rs.right_nextp != 0 #si el lado der no esta lleno, enviar la posicion
          position = rs.right_nextp

        else #Entonces, la derecha Tambien esta llena, enviar posicion 0, la cual sera rechazada.
          position = 0
          logger.debug "ROOM lleno. No hay posiciones disponibles. Tiene #{rs.logins.size} logins"
        end

      else #Entonces, si el izq no esta lleno, enviar posicion
        position = rs.left_nextp
        #update_room_position_free(rs, 'left_nextp') #actualizar sigt posicion en room
      end

    elsif ps == 3 #Si es igual a 3 la posicio del sponsor

      if rs.right_nextp == 0 #si el lado derecho esta lleno, enviar al izq

        if rs.left_nextp != 0 #si el lado izq no esta lleno, enviar la posicion
          position = rs.left_nextp

        else #Entonces, la izq Tambien esta llena, enviar posicion 0, la cual sera rechazada.
          position = 0
          logger.debug "ROOM lleno. No hay posiciones disponibles. Tiene #{rs.logins.size} logins"
        end

      else #Entonces, si el izq no esta lleno, enviar posicion
        position = rs.right_nextp
      end

    else #De lo contrario, la posicion del sponsor es igual a 1,4,5,6 ó 7

      if rs.left_nextp != 0 #si el lado izq no esta lleno, enviar la posicion
        position = rs.left_nextp

      elsif rs.right_nextp != 0
        position = rs.right_nextp

      else #Entonces, la derecha Tambien esta llena, enviar posicion 0, la cual sera rechazada.
        position = 0
        logger.debug "ROOM lleno. No hay posiciones disponibles. Tiene #{rs.logins} logins"
      end

    end #Fin de if rs == 2

    position #retornar position
  end

  def find_room_for_alpha(login)
    #Buscar el room que tenga espacios disponibles y que sea del mismo nivel que Login
    r = Room.where(["status = ? AND (left_nextp IN (?,?) OR right_nextp IN (?,?)) AND level_id = ?", true, 4,5, 6,7, login.level_id]).first
  end

  def register_in_room(login)

    if login.id == 1000 #Registrar LOGIN ALPHA
      #conseguir el proximo room para Alpha
      lo = find_room_for_alpha(login)
      #Almacenar la nueva posición para Alpha y luego modificarla al final de este metodo
      position = lo.left_nextp || lo.right_nextp

      #Actualizar LOGIN ALPHA
      if login.update_attributes! room_id: lo.id, position: position
        logger.debug "El LOGIN Alpha ha sido registrado en el room #{lo.id}"
      else
        logger.debug "El LOGIN Alpha NO ha sido registrado en el ROOM"
      end

    else #REGISTRAR cualquier usuario

      #si login.level != al sponsor.level
        #buscar aula con el mismo level del Login
        #EXPLICACION
        #Esto soluciona si el s.level == 2 y el l.level == 1,
        # lo registra en una aula nivel 1, pero para cuando
        # desarrolle la seleccion de nivel en que registrar un login funcione bien.
        # AHORA bien si el sponsor: 1 y login: 2 porque la aula del login corrió más rápido,
        # tambien buscara el aula más proxima de su mismo nivel

      if login.level_id != login.sponsor.level_id
        #conseguir el proximo room
        lo = find_room_for_alpha(login)
        #Almacenar la nueva posición y luego modificarla al final de este metodo
        position = lo.left_nextp || lo.right_nextp

        #Actualizar LOGIN
        if login.update_attributes! room_id: lo.id, position: position
          logger.debug "El LOGIN ha sido registrado en el room #{lo.id}"
        else
          logger.debug "El LOGIN NO ha sido registrado en el ROOM"
        end

      else

        #Normal Registring
        room = login.sponsor.room
        position = get_next_position(login)

          if position != 0
            #Modificar los campos del mismo login
            login.update_attributes! room_id: room.id, position: position
          end
      end #Fin de login.level_id

    end
    #Re definiendo el ROOM
    room = nil
    room = login.room

    #Si se actualizo el Login correctamente. Osea si ya esta en el nuevo room
    if position == login.position
      #Actualizar los espacios disponibles del ROOM
      if position == 4
        room.update_attribute :left_nextp, 5
      elsif position == 5
        room.update_attribute :left_nextp, 0
      elsif position == 6
        room.update_attribute :right_nextp, 7
      elsif position == 7
        room.update_attribute :right_nextp, 0
      else
        return false
        logger.debug "ROOM lleno. No se actualizó Room."
      end
    else
      logger.debug "El Login #{login.id} no pudo ser registrado en la nueva ROOM"
    end

  end


end
