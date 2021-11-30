import pymysql

class Conexion:
	def obtener_conexion():
		try:
			cn = pymysql.connect(
				host = "sinmsoftware.mysql.database.azure.com",
				user = "SINM",
				password = "maderera$2021",
				db = "construcciones_db"
			)
			print("Conexion establecida exitosamente!")
			return cn
		except(pymysql.err.OperationalError, pymysql.InternalError) as e:
			print("Error en la conexion: ", e)


