# Aplicacion de turnos de banco para Ruby TTPS
# Autor: Lautaro Torchia | Legajo: 17824/4

## Manual de Instalacion:
### Prerequsitos
    * Ruby version 3.0.4
    * Ruby on rails gem (gem install rails)
    * Postgresql DBMS y crear una database llamada turnosbanco_development

Para crear Postgresql seguir cualquier guia que indique como descargarlo para su sistema operativo. Una vez descargado, se debe crear una base de datos
con el nombre turnosbanco_development para el funcionamiento de la app y el usuario de postgress que debe usarla sera:
   -lautarotorchia (username)
   -passowrd1 (contraseña)
 
   
### una vez con todos los pre-requisitos descargados, para ejecutar el servidor Web local se deben hacer los siguientes 3 comandos

  * bundle install (Que instalara todas las dependencias de la aplicacion, detalladas luego)
  * Ruby version 3.0.4
  * rails db:reset (Que si ya esta creada la database turnosbanco_development la destruira, creara de nuevo y rellenara con los datos de prueba)
  * rails server (Que iniciara el servidor de prueba)
 


## Decisiones de diseño destacadas:
* ...
