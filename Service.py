
from Dao import *
from flask_mysqldb import MySQL
from logging import error
#from os import environ
import smtplib
class Service:


	def get_usuarios():
		query = "call sp_listar_const_priv()"
		request = Dao.select_all(query)
		return request

	def get_empleado(p_id_emple):
		query = str("call sp_buscar_empleado(%s)" %(p_id_emple))
		print("La query es: "+ str(query))
		request = Dao.select_all(query)
		return request
		

	def comentario(persona,comentario,fecha,nombre_contacto,telefono_contacto):
		coment = (" <div class=\"post clearfix\"> \
                                  <div class=\"user-block\" style=\"text-align: center;\"> \
                                    <span class=\"username\"> \
                                      <a href=\"#\">%s</a> \
                                      <a href=\"#\" class=\"float-right btn-tool\"><i class=\"fas fa-times\"></i></a> \
                                    </span> \
                                    <span class=\"description\">Comentario registrado - %s</span> \
                                  </div> \
                                  <!-- /.user-block --> \
                                  <p>%s</p> \
                                  <p>Nombre: %s</p> \
                                  <p>Contacto: %s</p> \
                                  <hr> \
                                </div>")%(persona,fecha,comentario,nombre_contacto,telefono_contacto)
		return coment

	def enviar_mensaje(tipo,destino):
		try:
			message = ""
			if(tipo=='1'):
				message = "Estas reheroku logstrasado en tu objetivo mensual, esfuerzate!"
			else:
				message = "Estas encaminado en tu objetivo mensual, sigue asi!"
			server = smtplib.SMTP("smtp.gmail.com",587)
			server.starttls()
			server.login('sinm.bi.si@gmail.com', 'sinm2021' )
			server.sendmail('sinm.bi.si@gmail.com',destino, message)
			server.quit()
			print("SE ENVIO")
		except error as e:
		    print("Envio Fallido Errorr :",e)


	
	


'''
#sinm.bi.si
#sinm2021
#from decouple import config
config('MAIL_PASSORD')
from logging import error
#from os import environ
import smtplib
'''


