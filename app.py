from flask import Flask, json, jsonify, render_template, request, redirect, url_for, session
from WebScrapping.NexoScrap import nexoUpdate
from WebScrapping.ObrasPublicas import infobrasUpdate
from WebScrapping.ProperatiScrap import properatiUpdate
from flask_mysqldb import MySQL
from datetime import datetime
from Service import *

from pymysql import NULL
from Service import *
app = Flask(__name__)

#Conexion a base de datos NYSQL
app.config["MYSQL_HOST"] = "sinmsoftware.mysql.database.azure.com"
app.config["MYSQL_USER"] = "SINM"
app.config["MYSQL_PASSWORD"] = "maderera$2021"
app.config["MYSQL_DB"] = "construcciones_db"
mysql = MySQL(app)
print("Conexión establecida exitosamente!")

#Configuracion
app.secret_key = "mysecretkey"

@app.route("/")
def home():
	if "id_user" in session:
		return redirect(url_for("dashboard"))
	else:
		return render_template("login.html")

@app.route("/login", methods=["POST"])
def login():
	if request.method == "POST":
		usuario = request.form["usuario"]
		password = request.form["password"]
		cur = mysql.connection.cursor()
		cur.execute("call sp_login(%s,%s)", (usuario,password))
		data = cur.fetchone()
		if data != None:
			session["id_party"] = data[0]
			session["id_user"] = data[1]
			cur2 = mysql.connection.cursor()
			cur2.execute("call sp_datos_usuario(%s)", [session["id_party"]])
			userData = cur2.fetchone()
			session["userData"] = userData
			response = {"status":True, "msg": "OK!"}
		else:
			response = {"status":False, "msg": "Usuario incorrecto"}
		return jsonify(response)
		cur.connection.close();

@app.route("/logout")
def logout():
	session.clear()
	return redirect(url_for("home"))

@app.route("/dashboard")
def dashboard():
	if "id_user" in session:
		data = ("Dashboard | Nueva Era","Dashboard")
		return render_template("dashboard.html", datos = data)
	else:
		 return redirect(url_for("home"))

@app.route("/perfil")
def perfil():
	if "id_user" in session:
		data = ("Mi Perfil | Nueva Era","Mi Perfil")
		return render_template("perfil.html", datos = data)
	else:
		return redirect(url_for("home"))

@app.route("/usuarios")
def usuarios():
	if "id_user" in session:
		data = ("Usuarios | Nueva Era","Usuarios")
		return render_template("usuarios.html", datos = data)
	else:
		return redirect(url_for("home"))

@app.route("/roles")
def roles():
	if "id_user" in session:
		data = ("Roles | Nueva Era","Roles")
		return render_template("roles.html", datos = data)
	else:
		return redirect(url_for("home"))

@app.route("/roles/permisos")
def permisos():
	if "id_user" in session:
		data = ("Permisos | Nueva Era","Permisos")
		return render_template("permisos.html", datos = data)
	else:
		return redirect(url_for("home"))

@app.route("/actualizar")
def actualizar():
	if "id_user" in session:
		data = ("Actualizar Info | Nueva Era","Actualizar información")
		return render_template("actualizar.html", datos = data)
	else:
		return redirect(url_for("home"))

#!------------------------------------------CONSTRUCCIONES------------------------------------------------------------ 

#Construcciones privadas
@app.route("/construcciones_privadas")
def construc_priv():
	if "id_user" in session:
		data = ("Construcciones Privadas | Nueva Era","Construcciones Privadas","functions_constructora.js")
		return render_template("construc_priv.html", datos = data)
	else:
		return redirect(url_for("home"))

@app.route("/list_construc_priv")
def list_construc_priv():
	if "id_user" in session:
		data = Service.get_usuarios()
		data = [list(i) for i in data]
		codigo = list()
		for i in range(len(data)):
			codigo.append(data[i][9])
		for i in range(len(data)):
			data[i].pop(9)
		for i in range(len(data)):
			
			if data[i][5] != None:
				data[i][5] = datetime.strftime(data[i][5],"%d-%m-%Y")
			else:
				data[i][5] = "No existe"
			
			if data[i][7] == "Activa":
				data[i][7] = '<span class="badge bg-info">Activa</span>'
			elif data[i][7] == "Vencida":
				data[i][7] = '<span class="badge bg-danger">Vencida</span>'
			else:
				data[i][7] = '<span class="badge bg-secondary">Duda</span>'
			

			if data[i][8] == "No visitado":
				data[i][8] = '<span class="badge bg-success">No Visitado</span>'
			elif data[i][8] == "Visitado":
				data[i][8] = '<span class="badge bg-warning">Visitado</span>'
			else:
				data[i][8] = '<span class="badge bg-danger">Ocupado</span>'

			data[i].append('<div class="text-center">'+
					'<button class="btn btn-warning btn-sm btn-ver-construc" rl="'+codigo[i]+'" title="Ver"><i class="fas fa-eye"></i></button> '+
					'<button class="btn btn-primary btn-sm btn-edit-construc" rl="'+codigo[i]+'" title="Comentar"><i class="fas fa-pencil-alt"></i></button> '+
					'</div>')
		return jsonify(data)
	else:
		return redirect(url_for("home"))

@app.route("/regis_contruc_priv")
def regis_construc_priv():
	if request.method == "POST":
		cur = mysql.connection.cursor()
		cur.execute("select max(id_const)+1 from construccion")
		codigo = cur.fetchall()
		nombre = request.form["nom_const"]
		apellidos = request.form["ape_emple"]
		dni = request.form["dni_emple"]
		fecha = request.form["fech_emple"]
		mail = request.form["mail_emple"]
		telefono = request.form["telef_emple"]
		distrito = request.form["distr_emple"]
		estado = request.form["estado"]
		cur.execute("insert into construccion values(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",(codigo,nombre,apellidos,dni,fecha,'',mail,telefono,distrito,estado))
		mysql.connection.commit()
		response = {"status":"True", "msj": "Construccion registrada correctamente!"}
		return jsonify(response)

@app.route("/buscar_construc_priv/<id_construc>", methods=["GET"])
def buscar_construc_priv(id_construc):
	cur = mysql.connection.cursor()
	cur.execute("call sp_buscar_const_priv(%s)", [id_construc])
	data = cur.fetchall()
	data = [list(i) for i in data]
	if data[0][6] != None:
		data[0][6] = datetime.strftime(data[0][6],"%Y-%m-%d")
	else:
		data[0][6] = "No existe"
	#data[0][11]='2'
	return jsonify(data[0])

@app.route("/actividad_construc_priv/<id_construc>",)
def actividad_construc_priv(id_construc):
	data = ("Registrar Actividad | Nueva Era","Registrar Actividad",id_construc)
	return render_template("registrar_actividad_privada.html", datos = data)

#Construcciones publicas
@app.route("/construcciones_publicas")
def construc_pub():
	data = ("Construcciones Públicas | Nueva Era","Construcciones Públicas","functions_constructora.js")
	return render_template("construc_pub.html", datos = data)

@app.route("/list_construc_pub")
def list_construc_pub():
	cur = mysql.connection.cursor()
	cur.execute("call sp_listar_const_pub")
	data = cur.fetchall()
	data = [list(i) for i in data]
	for i in range(len(data)):
		if(data[i][6] == "No visitado"):
			data[i][6] = '<span class="badge bg-success">No visitado</span>'
		elif(data[i][6] == "Marcado"):
			data[i][6] = '<span class="badge bg-info">Marcado</span>'
		else:
			data[i][6] = '<span class="badge bg-danger">Visitado</span>'

		data[i].append('<div class="text-center">'+
				'<button class="btn btn-warning btn-sm btn-ver-construc" rl="'+data[i][0]+'" title="Ver"><i class="fas fa-eye"></i></button> '+
				'<button class="btn btn-primary btn-sm btn-edit-construc" rl="'+data[i][0]+'" title="Comentar"><i class="fas fa-pencil-alt"></i></button> '+
				'</div>')
	return jsonify(data)
	cur.connection.close();

@app.route("/regis_contruc_pub")
def regis_construc_pub():
	if request.method == "POST":
		cur = mysql.connection.cursor()
		cur.execute("select max(id_const)+1 from construccion")
		codigo = cur.fetchall()
		nombre = request.form["nom_const"]
		apellidos = request.form["ape_emple"]
		dni = request.form["dni_emple"]
		fecha = request.form["fech_emple"]
		mail = request.form["mail_emple"]
		telefono = request.form["telef_emple"]
		distrito = request.form["distr_emple"]
		estado = request.form["estado"]
		cur.execute("insert into construccion values(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",(codigo,nombre,apellidos,dni,fecha,'',mail,telefono,distrito,estado))
		mysql.connection.commit()
		response = {"status":"True", "msj": "Construccion registrada correctamente!"}
		return jsonify(response)
		cur.connection.close();

@app.route("/buscar_construc_pub/<id_construc>", methods=["GET"])
def buscar_construc_pub(id_construc):
	cur = mysql.connection.cursor()
	cur.execute("call sp_buscar_const_pub(%s)", [id_construc])
	data = cur.fetchall()
	return jsonify(data[0])
	cur.connection.close();

@app.route("/actividad_construc_pub/<id_construc>")
def actividad_construc_pub(id_construc):
	data = ("Registrar Actividad | Nueva Era","Registrar Actividad",id_construc)
	return render_template("registrar_actividad_publica.html", datos = data)



@app.route("/marc_const/<id_construc>",methods=["POST"])
def marc_const(id_construc):

	cur = mysql.connection.cursor()
	id_usuario =  session["id_user"]
	cur.execute("SELECT ID_E_DISP from construccion Where ID_CONSTRUCCION = %s",[id_construc])
	data = cur.fetchone()
	disponibilidad = data[0][0]
	#cur.execute("call sp_marcar_construccion(%s,%s,%s)",(id_usuario,id_construc,disponibilidad))
	#mysql.connection.commit()
	print(id_usuario)
	data = cur.fetchall()
	
	if disponibilidad == "2":
		response = {"status":True,"flag":0, "msj":"Construccion Ocupada!"}
	else:
		cur.execute("UPDATE construccion SET ID_E_DISP = '2' WHERE ID_CONSTRUCCION  = %s",[id_construc])
		mysql.connection.commit()
		cur.execute("INSERT INTO usuario_construccion VALUES(%s,%s,current_date(),null,null,null)",(id_usuario,id_construc))		
		mysql.connection.commit()
		response = {"status":True,"flag":1, "msj":"Construccion Marcada!"}
	return jsonify(response)	


# ! REGISTRAR COMENTARIO ------------------------------------!!!
@app.route("/reg_comen/<id_const>", methods=["POST"])
def reg_comen(id_const):
	if request.method == "POST":
		cur = mysql.connection.cursor()
		id_usuario =  session["id_user"]
		comentario = request.form["comentario"]
		nombre = request.form["name_contac"]
		telefono = request.form["num_contac"]
		tipo = request.form.get("tipo")	
		#print(id_usuario,id_const,nombre,telefono,tipo)
		#cur.execute("call sp_registrar_comentario(%s,%s,%s,%s,%s,%s)",(id_usuario,id_const,nombre,telefono,tipo,comentario))
		#mysql.connection.commit()
		cur.execute("select ID_USUARIO from usuario_construccion uc where ID_CONSTRUCCION = %s and fecha_actividad is null LIMIT 1",[id_const])
		data = cur.fetchall()
		usuario_asociado = data[0][0]
		cur.execute("select f_autogenerar_id_party()")
		data = cur.fetchall()
		v_id_party = data[0][0]
		cur.execute("select construcciones_db.f_generar_id_m_contc()")
		data = cur.fetchall()
		v_id_mec_contacto = data[0][0]
		print(usuario_asociado, " -- ",id_usuario)
		if(usuario_asociado == id_usuario):
			if(tipo == '0'):
				cur.execute("insert into party values(%s,%s,current_date(),%s)",(v_id_party,"ORGANIZACION",id_usuario))
				mysql.connection.commit()
				cur.execute("insert into construcciones_db.organizacion(ID_PARTY,NOMBRE) values(%s,%s)",(v_id_party,nombre))				
				mysql.connection.commit()
				cur.execute("insert into party_rol values(%s,%s,%s,current_date(),null)",(v_id_party,"ROL-000007","ERO-000001"))
				mysql.connection.commit()
			else:
				cur.execute("insert into party values(%s,%s,current_date(),%s)",(v_id_party,"PERSONA",id_usuario))
				mysql.connection.commit()
				cur.execute("insert into construcciones_db.persona(ID_PARTY,NOMBRE,ESTADO) values(%s,%s,%s)",(v_id_party,nombre,'0'))				
				mysql.connection.commit()
				cur.execute("insert into party_rol values(%s,%s,%s,current_date(),null)",(v_id_party,"ROL-000006","ERO-000001"))
				mysql.connection.commit()		
			
			cur.execute("insert into mecanismo_contacto values (%s,%s,%s,%s, current_date(),null)",(v_id_party,v_id_mec_contacto,"CTC-000001",telefono))
			mysql.connection.commit()			
			cur.execute("UPDATE usuario_construccion \
			set ID_PARTY = %s,\
			FECHA_ACTIVIDAD = current_date(),\
            COMENTARIO = %s  \
			where ID_USUARIO = %s and ID_CONSTRUCCION = %s and FECHA_ACTIVIDAD is null;",(v_id_party,comentario,id_usuario,id_const))
			mysql.connection.commit()
			cur.execute("UPDATE construccion SET ID_E_DISP = %s where ID_CONSTRUCCION = %s",('3',id_const))
			mysql.connection.commit()	
			response = {"status":True, "msj":"Comentario registrado correctamente!"}
		else:
			response = {"status":False, "msj":"Error al Registrar"}
		return jsonify(response)
		cur.connection.close();


#! ------------------------------------------EMPLEADO------------------------------------------------------------ 

#Empleados
@app.route("/empleados")
def empleados():
	if "id_user" in session:
		data = ("Empleados | Nueva Era","Empleados","functions_empleado.js")
		return render_template("empleados.html", datos = data)
	else:
		return redirect(url_for("home"))

@app.route("/list_emple")
def list_emple():
	cur = mysql.connection.cursor()
	cur.execute("call sp_listar_empleados()")
	data = cur.fetchall()
	data = [list(i) for i in data]
	for i in range(len(data)):
		print(data[i][4])
		data[i][4] = datetime.strftime(data[i][4],"%d-%m-%Y")
		if data[i][5] == "ACTIVO":
			data[i][5] = '<span class="badge bg-info">Activo</span>'
		else:
			data[i][5] = '<span class="badge bg-danger">Culminado</span>'
		for j in range(7,9):
			if data[i][j] == None:
				data[i][j] = "No Registrado"
		
		data[i].append('<div class="text-center">'+
				'<button class="btn btn-warning btn-sm btn-ver-emple" rl="'+data[i][0]+'" title="Ver"><i class="fas fa-eye"></i></button> '+
				'<button class="btn btn-primary btn-sm btn-edit-emple" rl="'+data[i][0]+'" title="Editar"><i class="fas fa-pencil-alt"></i></button> '+
				'<button class="btn btn-danger btn-sm btn-eli-emple" rl="'+data[i][0]+'" title="Eliminar"><i class="fas fa-trash-alt"></i></button> '+
				'</div>')
	return jsonify(data)
	cur.connection.close();

@app.route("/regis_emple", methods=["POST"])
def regis_emple():
	if request.method == "POST":
		cur = mysql.connection.cursor()
		party_id = request.form["id_emple"]
		id_party_generado = ""
		id_mec_cont_generado = ""
		if party_id == "0":
			 party_id = "flag"
			 cur.execute("select f_autogenerar_id_party()")
			 data = cur.fetchall()
			 id_party_generado  = data[0][0]
			 cur.execute("select f_generar_id_m_contc()")
			 data = cur.fetchall()
			 id_mec_cont_generado = data[0][0]

		nombre = request.form["nom_emple"]
		apellidos = request.form["ape_emple"]
		dni = request.form["dni_emple"]
		fecha = request.form["fech_emple"] 

		mail = request.form["mail_emple"] 
		sexo = request.form["sexo"]
		telefono = request.form["telef_emple"]
		distrito = request.form["distr_emple"]
		estado = request.form["estado"]
		
		if estado == "ACTIVO":
			estado = "1"
		else: estado = "0"	
		id_usuario = session["id_user"]

		cur.execute("call sp_crear_actualizar_empleado(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",
		 	(party_id,nombre,apellidos,dni,sexo,fecha,mail,telefono,distrito,estado,id_usuario,id_party_generado,id_mec_cont_generado))
		mysql.connection.commit()
		response = {"status":True, "msj":"Empleado registrado correctamente!"}
		return jsonify(response)
		cur.connection.close();
 

@app.route("/buscar_empleado/<id_emple>", methods=["GET"])
def buscar_emple(id_emple):
	cur = mysql.connection.cursor()
	cur.execute("call sp_buscar_empleado(%s)",[id_emple])
	data = cur.fetchall()
	data = [list(i) for i in data]
	data[0][4] = datetime.strftime(data[0][4],"%Y-%m-%d")
	data[0][6] = datetime.strftime(data[0][6],"%Y-%m-%d")
	for i in range(7,10):
		if data[0][i] == None:
			data[0][i] = "No Registrado"
	return jsonify(data[0])
	
	

@app.route("/edi_emple/<id_emple>", methods=["GET"])
def edi_emple(id_emple):
	cur = mysql.connection.cursor()
	cur.execute("call sp_buscar_empleado(%s)",[id_emple])
	data = cur.fetchall()
	data = [list(i) for i in data]
	data[0][4] = datetime.strftime(data[0][4],"%Y-%m-%d")
	data[0][6] = datetime.strftime(data[0][6],"%Y-%m-%d")
	for i in range(7,10):
		if data[0][i] == None:
			data[0][i] = "No Registrado"
	return jsonify(data[0])


@app.route("/elim_emple/<id_emple>", methods=["POST"])
def elim_emple(id_emple):
	cur = mysql.connection.cursor()
	cur.execute("call sp_eliminar_empleado(%s)", [id_emple])
	mysql.connection.commit()
	response = {"status":"True", "msj":"Registro de empleado elminado!"}
	return jsonify(response)
	cur.connection.close();

#! ------------------------------------------USUARIO------------------------------------------------------------ 


@app.route("/list_usuarios")
def list_usuarios():
	if "id_user" in session:
		cur = mysql.connection.cursor()
		cur.execute("call sp_listar_usuarios")
		data = cur.fetchall()
		data = [list(i) for i in data]
		for i in range(len(data)):

			if data[i][5] == "Activo":
				data[i][5] = '<span class="badge bg-info">Activo</span>'
			elif data[i][5] == "Eliminado temporalmente":
				data[i][5] = '<span class="badge bg-danger">Eliminado temporalmente</span>'
			else:
				data[i][5] = '<span class="badge bg-danger">Inactivo</span>'

			data[i].append('<div class="text-center">'+
					'<button class="btn btn-primary btn-sm btn-edit-usu" rl="'+data[i][0]+'" title="Editar"><i class="fas fa-pencil-alt"></i></button> '+
					'<a class="btn btn-danger btn-sm " href="elim_usuario?a='+data[i][0]+'&b='+data[i][1]+'&c='+data[i][2]+'&d='+data[i][4]+'" title="Eliminar"><i class="fas fa-trash-alt"></i></a>'+
					'</div>')
			if data[i][4] == "Administrador":
				data[i][4] = '<span class="badge bg-success">'+data[i][4]+'</span>'
			elif data[i][4] == "Asistente Ventas":
				data[i][4] = '<span class="badge bg-warning">'+data[i][4]+'</span>'
			else:
				data[i][4] = '<span class="badge bg-dark">'+data[i][4]+'</span>'
				
		return jsonify(data)
		cur.connection.close()
	else:
		return redirect(url_for("home"))


@app.route("/elim_usuario/")
def elim_usuario():
	a = request.args.get('a', None) 
	b = request.args.get('b', None)
	c = request.args.get('c', None)
	d = request.args.get('d', None)
	data = ("Eliminar Usuario | Nueva Era","Eliminar Usuario",a,b,c,d)
	return render_template("usuario_delete.html", datos = data)

@app.route("/get_permiso/<id_usuario>",methods=["GET"])
def get_permiso(id_usuario):
	cur=mysql.connection.cursor()
	cur.execute("call sp_buscar_permiso(%s)",[id_usuario])
	permiso=cur.fetchall()
	return jsonify(permiso)
	cur.connection.close();

@app.route("/elim_usuario_perma/<id_usuario>", methods=["POST"])
def elim_usuario_perma(id_usuario):
	cur = mysql.connection.cursor()
	cur.execute("call sp_eliminar_usuario_perma(%s)",[id_usuario])
	mysql.connection.commit()
	response = {"status":"True", "msj":"Usuario eliminado permanentemente!"}
	return jsonify(response)
	cur.connection.close();

@app.route("/elim_usuario_tempo/<id_usuario>", methods=["POST"])
def elim_usuario_tempo(id_usuario):
	cur=mysql.connection.cursor()
	cur.execute("update usuario set id_estado_usuario='EUS-100002' where id_usuario=%s",[id_usuario])
	mysql.connection.commit()
	response = {"status":"True", "msj":"Usuario eliminado temporalmente!"}
	return jsonify(response)
	cur.connection.close();

@app.route("/regis_usuario/", methods=["POST"])
def regis_usuario():
	if request.method=="POST":
		cur=mysql.connection.cursor()
		id_usu = request.form["id_usuario"]
		dni_usuario=request.form["dni_usu"]
		usuario=request.form["nom_usu"]
		password=request.form["pass_usu"]
		rol_usuario=request.form["rol_usu"]
		usuario_creacion=session["id_user"]
		estado_usuario=request.form["estado_usu"]
		if (dni_usuario == "") :
			cur.execute("call sp_editar_usuario(%s,%s,%s,%s)",[id_usu,password,rol_usuario,estado_usuario])
			mysql.connection.commit()
			if (password != ""):
				response = {"status":True, "msg":"Usuario Actualizado correctamente!"}
			else :
				response = {"status":False, "msg":"Debe ingresar una contraseña válida"}
		else:
			id_party_validacion=""
			cur.execute("select id_party from persona where dni = %s",[dni_usuario])
			id_party_validacion=cur.fetchone()
			if (id_party_validacion != None):
				cur.execute("call sp_registrar_usuario(%s,%s,%s,%s,%s,%s)",[dni_usuario,usuario,password,
				rol_usuario,usuario_creacion,estado_usuario])
				mysql.connection.commit()
				response = {"status":True, "msg":"Usuario registrado correctamente!"}
			else:
				response = {"status":False, "msg":"DNI no encontrado en el sistema"}
		return jsonify(response)
		cur.connection.close(); 


@app.route("/buscar_usuario/<id_usuario>", methods=["GET"])
def buscar_usuario(id_usuario):
	cur = mysql.connection.cursor()
	cur.execute("call sp_buscar_usuario(%s)", [id_usuario])
	data = cur.fetchone()
	return jsonify(data)

#!----------------------------PERMISOS Y ROLES--------------------------------------------

@app.route("/list_permisos/")
def list_permisos():
	cur=mysql.connection.cursor()
	cur.execute("call sp_listar_privilegios")
	data = cur.fetchall()
	data = [list(i) for i in data]
	for i in range(len(data)):
		data[i].insert(0,i+1)
	return jsonify(data)
	cur.connection.close();

@app.route("/list_roles/")
def list_roles():
	cur=mysql.connection.cursor()
	cur.execute("call sp_listar_roles")
	data = cur.fetchall()
	data = [list(i) for i in data]
	data_permiso = []
	data_nexada = []
	data_final = []
	for i in range(len(data)):
		if (i+1) == len(data):
			data_permiso.append('<p class="text-center">'+data[i][2])
			data_nexada.append(data[i][0])
			data_nexada.append(data[i][1])
			data_nexada.append(data_permiso)
			data_final.append(data_nexada)
		elif data[i][0] == data[i+1][0]:
			data_permiso.append('<p class="text-center">'+data[i][2])
		else :
			data_permiso.append('<p class="text-center">'+data[i][2])
			data_nexada.append(data[i][0])
			data_nexada.append(data[i][1])
			data_nexada.append(data_permiso)
			data_final.append(data_nexada)
			data_permiso = []
			data_nexada = []
	for i in range(len(data_final)):
		data_final[i].insert(0,i+1)
	return jsonify(data_final)
	cur.connection.close();

#!----------------------------------------------------------------------------------------

@app.route("/actividad/<id_emple>", methods=["GET"])
def actividad(id_emple):
	if "id_user" in session:
		data = ("Actividad | Nueva Era","Actividad de vendedor","functions_empleado.js")
		return render_template("actividad.html", datos = data)
	else:
		return redirect(url_for("home"))

#Vista PB
@app.route("/vista_pbi")
def vista_pbi():
	if "id_user" in session:
		data = ("Vista PBI | Nueva Era","Vista Power BI","function_reporte.js")
		return render_template("vista_pbi.html", datos = data)
	else:
		return redirect(url_for("home"))

#Reportes
@app.route("/reportes")
def reportes():
	if "id_user" in session:
		data = ("Reportes | Nueva Era","Reportes","function_reporte.js")
		return render_template("reportes.html", datos = data)
	else:
		return redirect(url_for("home"))

@app.route("/upt_priv", methods=["POST"])
def upt_priv():
	if request.method=="POST":
		if (nexoUpdate() and properatiUpdate()):
			'''
			cur = mysql.connection.cursor()
			cur.execute("call sp_registrar_actualización_priv")
			mysql.connection.commit()
			'''
			response = {"status":True, "msg":"Construcciones privadas actualizadas correctamente"}
		else:
			response = {"status":False, "msg":"Error al actualizar las construcciones"}
		return jsonify(response)

@app.route("/upt_pub", methods=["POST"])
def upt_pub():
	if request.method=="POST":
		if (infobrasUpdate()):
			'''
			cur = mysql.connection.cursor()
			cur.execute("call sp_registrar_actualización_pub")
			mysql.connection.commit()
			'''
			response = {"status":True, "msg":"Construcciones públicas actualizadas correctamente"}
		else:
			response = {"status":False, "msg":"Error al actualizar las construcciones"}
		return jsonify(response)

if __name__ == "__main__":
	app.run(debug=True)