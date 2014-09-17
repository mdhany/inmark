# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Room.create!(
    id: 1000,
    level_id: 2,
    status: true
)
[1,2,3,4].each do |r|
  Room.create!(
      id: 100+r,
      level_id: 1,
      status: true
  )
end
#UserAdmins
Login.create!(
    id: 1000,
    email: "u1@a.com",
    password: 'themaster007',
    password_confirmation: 'themaster007',
    username: 'mdhany',
    first_name: 'Melvin',
    last_name: 'Danis',
    identification: '22500631258',
    phone: '8492660666',
    country: 'República Dominicana',
    city: 'Santo Domingo',
    account_type: 'Banco BHD',
    number_account: '12868740011',
    level_id: 2,
    room_id: 1000,
    position: 1,
    mlm_started: true,
    activated: true
)
Manager.create!(
    email: 'melvin.dani7@gmail.com',
    password: 'themaster007',
    password_confirmation: 'themaster007',
)


#Levels
Level.create!(
    name: 'basico',
    amount: 50
)
Level.create!(
    name: 'superior',
    amount: 95
)

#Pages
Page.create!(
    title: 'Dashboard',
    url: 'dashboard',
    content: "<p><strong>&iexcl;Bienvenido a INMARK!</strong></p>"
)
Page.create!(
    title: '¿Como Funciona INMARK?',
    url: 'como-funciona',
    content: @funciona
)



#superior room
[2,3].each do |p|
Login.create!(
    email: "u#{p}@a.com",
    password: 'im4rk2014',
    password_confirmation: 'im4rk2014',
    username: "Fer#{p}5#{p+2}",
    first_name: 'Melvin',
    last_name: 'Danis',
    identification: "2250061125#{p}",
    phone: '8492660666',
    country: 'República Dominicana',
    city: 'Santo Domingo',
    account_type: 'Banco BHD',
    number_account: "128681400#{p}",
    level_id: 2,
    room_id: 1000,
    sponsor_id: 1000,
    position: p,
    mlm_started: true,
    activated: true
)
end

#basica room 1
  [1,2,3].each do |p|
    Login.create!(
        email: "u#{p}@b.com",
        password: 'im4rk2014',
        password_confirmation: 'im4rk2014',
        username: "Fer#{p}5#{p+2}",
        first_name: 'Melvin',
        last_name: 'Danis',
        identification: "2252063125#{p}",
        phone: '8492660666',
        country: 'República Dominicana',
        city: 'Santo Domingo',
        account_type: 'Banco BHD',
        number_account: "128627400#{p}",
        level_id: 1,
        room_id: 1001,
        sponsor_id: 1001,
        position: p,
        mlm_started: true,
        activated: true
    )
  end
    #basica room 2
    [1,2,3].each do |p|
      Login.create!(
          email: "u#{p}@c.com",
          password: 'im4rk2014',
          password_confirmation: 'im4rk2014',
          username: "Al#{p}5#{p+2}",
          first_name: 'Melvin',
          last_name: 'Danis',
          identification: "2250063121#{p}",
          phone: '8492660666',
          country: 'República Dominicana',
          city: 'Santo Domingo',
          account_type: 'Banco BHD',
          number_account: "128687401#{p}",
          level_id: 1,
          room_id: 1002,
          sponsor_id: 1001,
          position: p,
          mlm_started: true,
          activated: true
      )
    end
      #basica room 3
      [1,2,3].each do |p|
        Login.create!(
            email: "u#{p}@d.com",
            password: 'im4rk2014',
            password_confirmation: 'im4rk2014',
            username: "Ael#{p}5#{p+2}",
            first_name: 'Melvin',
            last_name: 'Danis',
            identification: "2250061121#{p}",
            phone: '8492660666',
            country: 'República Dominicana',
            city: 'Santo Domingo',
            account_type: 'Banco BHD',
            number_account: "128637401#{p}",
            level_id: 1,
            room_id: 1003,
            sponsor_id: 1002,
            position: p,
            mlm_started: true,
            activated: true
        )
      end

#basica room 4
[1,2,3].each do |p|
  Login.create!(
      email: "u#{p}@e.com",
      password: 'im4rk2014',
      password_confirmation: 'im4rk2014',
      username: "Aff#{p}5#{p+2}",
      first_name: 'Melvin',
      last_name: 'Danis',
      identification: "2350261121#{p}",
      phone: '8492660666',
      country: 'República Dominicana',
      city: 'Santo Domingo',
      account_type: 'Banco BHD',
      number_account: "12337401#{p}",
      level_id: 1,
      room_id: 1004,
      sponsor_id: 1002,
      position: p,
      mlm_started: true,
      activated: true
  )
end

#Pages contents
@funciona = "<div>Primero:&nbsp;</div>

<div>&nbsp;</div>

<div>Debes registrarte como participante, siendo referido por alguien que a su vez est&eacute; participando en uno de los seminarios del sistema INMARK.</div>

<div>&nbsp;</div>

<div>Activar la cuenta de participante, haciendo un unico pago de US$50.00 (Cincuenta Dolares) por concepto de inscripci&oacute;n, este pago habilitara tu oficina virtual en la cual tendras aceso a todos los seminarios de aprendizaje y capacitacion en el mundo del network marketing, ademas del sistema de capacitaci&oacute;n &nbsp;te ayudar&aacute; a entrar a uno de los negocios que promueve la empresa, (SWISSGOLDEN). &nbsp;All&iacute; podras emprender tu propio negocio.</div>

<div>&nbsp;</div>

<div>Segundo:</div>

<div>&nbsp;</div>

<div>Recibir&aacute;s un paquete de instructivos que podr&aacute;s descargaran a tu PC al hacer tu activaci&oacute;n, y los Links de v&iacute;deos turoriales para que aprendas a desarrollar tu organizaci&oacute;n.</div>

<div>&nbsp;</div>

<div>En este momento quiero ense&ntilde;arte el sistema de capitalizaci&oacute;n en la que podras participar.</div>

<div>&nbsp;</div>

<div>&iquest;Como Funciona el sistema de capitalizaci&oacute;n de INMARK?</div>

<div>&nbsp;</div>

<div>&nbsp;</div>

<div>Desarrollo del sistema INMARK - AULA B&Aacute;SICA</div>

<div>&nbsp;</div>

<div>Aparecer&aacute; una tabla con siete puestos como esta, que llamaremos AULA.</div>

<div>Esta AULA cuenta con tres NIVELES...</div>

<div>Siempre y sin excepci&oacute;n los niveles dos y tres estar&aacute;n ocupadas y tu ocuparas una de estas cuatro posiciones en el nivel uno como referido de una de las personas que est&aacute;n en el AULA.</div>

<div>&nbsp;</div>

<div>Luego cuando las cuatro posiciones del AULA est&eacute;n llenas con los referidos tra&iacute;dos, sin importar quien los haya referido, el aula se divide en dos partes y el que esta en el nivel n&uacute;mero tres pasa a una AULA SUPERIOR y recibe un bono de UD$ 50.00 DOLARES, por haber cumplido el ciclo y traer sus dos referidos.</div>

<div>&nbsp;</div>

<div>Al dividirse el AULA en dos partes, tu y las personas que se encontraban en el primer nivel ocuparan el 2do nivel en dos aulas diferentes y simult&aacute;neamente.</div>

<div>&nbsp;</div>

<div>Ahora se traen cuatro nuevos referidos referidos, y &nbsp;el AULA vuelve a dividirse. Ahora tu y la persona que estaba a tu lado ocuparan el tercer nivel en dos AULAS al mismo tiempo.&nbsp;</div>

<div>&nbsp;</div>

<div>Y cuando tu y tus dos referidos traigan a su vez sus cuatro nuevos referidos, el AULA se divide y tu pasas al AULA SUPERIOR y recibes tu bono de UD$50.00 Dolares, por haber cumplido trayendo tus dos referidos y finalizado tu primer ciclo, para entrar al AULA SUPERIOR.</div>

<div>&nbsp;</div>

<div>Desarrollo del sistema INMARK - AULA SUPERIOR</div>

<div>&nbsp;</div>

<div>Ya has pasado al primer nivel del AULA SUPERIOR.</div>

<div>Al igual que en el aula b&aacute;sica, el aula superior se comenzara a llenar, pero ahora con los referidos que al igual que tu, hayan terminado el primer ciclo del aula b&aacute;sica, y que autom&aacute;ticamente vendr&aacute;n a ocupar los cuatro lugares del primer nivel del aula superior.</div>

<div>&nbsp;</div>

<div>De esta manera el aula se divide, dando lugar a cuatro personas m&aacute;s, que &nbsp;hayan terminado el aula basica. &nbsp;Y tu ahora ocuparas el segundo nivel del aula. &nbsp;Que al llenarse nueva mente se dividir&aacute; y tu ahora pasar&aacute;s al tercer nivel del aula.</div>

<div>Cuando el aula, estando tu en el tercer nivel se haya completado con los cuatro referidos que viene desde el aula b&aacute;sica, la mesa se divide otra vez y tu cobras una entrada a la mesa preliminar de SWISSGOLDEN , valorada en 220 euros.</div>

<div>&nbsp;</div>

<div>Y tambi&eacute;n, como si esto fuera poco, pasaras a una tercera aula en la cual, al completar el ciclo se te dar&aacute; otro bono de 225 dolares y esto se repetir&aacute; una y otra vez indefinidamente, mientras tu y tu equipo trabaje o hasta que decidas retirarte.</div>

<div>&nbsp;</div>

<div>De esta manera hemos logrado varias cosas dentro de este extraordinario sistema:</div>

<div>&nbsp;</div>

<div>1.- Al cumplir con tu requisito de traer dos referidos, recibiste un pago de 50 dolare en el aula b&aacute;sica.</div>

<div>&nbsp;</div>

<div>2.- &nbsp;Fuiste creando junto a otros y dentro de tu equipo, una red de personas que al obtener su entrada a SWISSGOLDEN te seguir&aacute;n de igual modo, ayud&aacute;ndote a cobrar tu mesa y lo mejor de todo, con un m&iacute;nimo de esfuerzo, cero riesgo y poca inversi&oacute;n.</div>

<div>&nbsp;</div>

<div>3.- Aprendiste a traves de INMARK, trabajar en equipo, hacer red de mercadeo, viste los v&iacute;deos tutoriales, has le&iacute;do libros de motivaci&oacute;n que te ayudaran para lograr el &eacute;xito en tus negocio, y &nbsp;has creado un equipo de apoyo permanente.</div>

<div>&nbsp;</div>

<div>4.- Mientras cobras tus mesas en SWISSGOLDEN, iras recibiendo pagos de 225 dolares cada vez que pases de un aula a otra, dentro del sistema INMARK.</div>

<div>&nbsp;</div>

<div>Maravilloso!!!! &nbsp;&iquest;Verdad?</div>

<div>&nbsp;</div>

<div>Por eso es que:</div>

<div>&nbsp;</div>

<div>INMARK &amp; BUSINESS SCHOOL, es el mejor sistema de capacitaci&oacute;n, y capitalizaci&oacute;n del mundo.</div>

<div>&nbsp;</div>
"