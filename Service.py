from Dao import *
from flask_mysqldb import MySQL





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








