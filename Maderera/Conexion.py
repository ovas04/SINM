import pymysql

class Conexion:
	def obtener_conexion():
		try:
			cn = pymysql.connect(
				host = "localhost",
				user = "root",
				password = "",
				db = "base_datos_constructoras2"
			)
			print("Conexion establecida exitosamente!")
			return cn
		except(pymysql.err.OperationalError, pymysql.InternalError) as e:
			print("Error en la conexion: ", e)