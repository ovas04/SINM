from Dao import *
from flask_mysqldb import MySQL
from logging import error
#from os import environ
import smtplib
class Service:

	def get_usuarios(self):
		query = "call sp_listar_const_priv()"
		request = Dao.select_all(query)
		return request
	def get_empleado(self,p_id_emple):
		query = str("call sp_buscar_empleado(%s)" %(p_id_emple))
		print("La query es: "+ str(query))
		request = Dao.select_all(query)
		return request
		
	def Tipo_Message(self,tipo):
		if(tipo==1):
			return "Estas retrasado en tu objetivo mensual, esfuerzate!"
		else:
			return "Estas encaminado en tu objetivo mensual, sigue así!"
	def enviar_mensaje(self,tipo,destino):
		try:
			message = self.Tipo_Message(tipo)
			server = smtplib.SMTP("smtp.gmail.com",587)
			server.starttls()
			server.login('sinm.bi.si@gmail.com', 'sinm2021' )
			server.sendmail('sinm.bi.si@gmail.com',destino, message)
			server.quit()
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


