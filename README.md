# Aplicacion de turnos de banco para Ruby TTPS
# Autor: Lautaro Torchia | Legajo: 17824/4

## Manual de Instalacion:
### Prerequsitos
    * Ruby version 3.0.4
    * Ruby on rails gem 7.0.4 (gem install rails)
    * Postgresql DBMS y crear una database llamada turnosbanco_development

Para crear Postgresql seguir cualquier guia que indique como descargarlo para su sistema operativo. https://www.postgresql.org/download/. Puede que requiera de librerias adicionales para funcionar con ruby. Si es el caso instalarla libreria: libpq-dev (sudo apt install libpq-dev)
Una vez descargado, se debe crear una base de datos
con el nombre turnosbanco_development para el funcionamiento de la app y el usuario de postgress que debe usarla sera:
   - lautarotorchia (username)
   - password1 (contraseña)
 
   
### una vez con todos los pre-requisitos descargados, para ejecutar el servidor Web local se deben hacer los siguientes 3 comandos

  * bundle install (Que instalara todas las dependencias de la aplicacion, detalladas luego) 
  * rails db:create (creara la base de datos)
  * rails db:migrate (Que realizara todas las migraciones)
  * rails db:seed (Que llenara la base de datos con informacion del seeds.rb)
  * rails server (Que iniciara el servidor de prueba)
 
Usuarios Inicial:
email=admin@admin.com
contraseña=aaaaaa
CUENTA DE ADMINISTRADOR

para el resto de cuentas debe crearla desde la interfaz de la aplicacion

## Decisiones de diseño destacadas:

### Modelos
En cuanto a los modelos, decidi ir por un esquema con las siguientes clases:
   - Appointment (que modela a un turno)
   - Branch (que modela a una sucursal)
   - Schedule (que modela a un horario de una sucursal)
   - User (que modela a un usuario en el sistema)
   - Ability (modelo utilizado por una gema para modelar permisos)

La decision de usar este esquema de clases se tomo a partir de los requerimientos de la aplicacion. Al necesitar un CRUD tanto de sucursales, horarios,turnos y Usuarios decidi que un Modelo para cada uno permitia generar un CRUD muchisimo mas facil que cualquier otra alternativa que pudiera presentarse. A su vez, decidi no modelar como un Modelo a los roles, ya que la complejidad generada por estos podia resolverla con una gema que explicare mas adelante, por lo cual el modelo User era suficiente para representar todos los datos que se necesitaban de cada usuario.

### Borrado

En cuanto a las constrains de borrado dentro de la aplicacion, se presentaron varias decisiones y estas fueron las decisiones que tome:

   - Appointment no se puede borrar fisicamente por su cuenta, pero los turnos cancelados o aceptados pueden ser borrados en algunos casos
   - Branch se puede borrar solo si no existen turnos pendientes en esa sucursal y no existe personal asignado a ella
   - Schedule se puede borrar siempre
   - User se puede borrar siempre

   En cuanto a la decision de la sucursal, determine que no tendria sentido borrar una sucursal en donde hay un turno con estado pendiente, ya que este quedaria en el vacio y no me parecia correcto eliminarlo sin aviso al usuario, por lo que determine no permitir el borrado en ese caso. En cuanto al personal, decidi no poder borrar si el personal esta asignado a ella ya que las alternativas, como por ejemplo el borrado del personal asociado a una sucursal cuando se borra la misma, no me parecio optimo
   Por otra parte, el borrado de los turnos, tome la decision de que no se puedan borrar los turnos por su cuenta ya que me parecia una tarea innecesaria y que era mejor conservar la informacion dentro de la BD. Eso si, si una sucursal es borrada, tambien se borran todos sus turnos cancelados o aceptados. Esto es asi ya que sino permitirian que existan turnos fantasmas las cuales su sucursal no existe y por eso tome esta decision.

### Gemas utilizadas

   - Can can can (https://github.com/CanCanCommunity/cancancan)
   - Devise (https://github.com/heartcombo/devise)
   - Faker (https://github.com/faker-ruby/faker)
   - y todas las librerias dependientes de Ruby on Rails

Para la explicacion de la eleccion de cada una: Can can can es una gema encargada de resolver de manera mas bonita y efectiva el tema de los permisos segun el rol que posea el usuario. Decidi usarla porque para la lista de acciones permitidas segun el rol especificadas en la consigna se podia resolver rapidamente en un simple archivo ability.rb, asi disminuyendo mucho la carga de codigo en este tema. En cuanto a Devise, es una gema encargada del tema de autenticacion y sesiones y la verdad es impecable. Facilita y automatiza el hecho de tener que implementar un sistema de sesiones un monton. En cuanto a Faker es una gema que permite autogenerar texto con sentido, muy util a la hora de armar un seeds.rb el cual tenga informacion real y no simplemente "aaa".

### Decisiones de logica
El resto de decisiones de logica dentro de la aplicacion, se basaron en la lectura de la consigna y en la determinacion de que era lo mejor para implementar. Alguna de ellas fueron:

   - El personal solo puede ver los turnos de su sucursal en Su dia, asi permitiendo ver mas facil que turnos deben marcar como atendidos hoy
   - Los Horarios pertenecen a Una sucursal, aprovechandome de las rutas anidadeas de Ruby on Rails y asi facilitando el trabajo
   - Los administradores NO pueden cambiar la contraseña de cualquier usuario, solo la suya, me parecio logico por cuestiones de privacidad
   - Los administradores solo pueden ver los turnos de todas las sucursales, pero no manipularlos, para eso existe el empleado.


