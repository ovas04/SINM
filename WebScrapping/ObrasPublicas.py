# -*- coding: utf-8 -*-
"""
Created on Sat May 15 07:12:07 2021

@author: OVAS
"""
from datetime import date
import pandas as pd

Departamentos = [
    'LIMA','TUMBES',
    'CALLAO','TACNA',
    'CUSCO','SAN MARTÍN','SAN MARTIN',
    'CUZCO','PIURA',
    'ARQUIPA','PASCO',
    'PUNO','MOQUEGUA',
    'HUÁNUCO','MADRE DE DIOS',
    'ICA','LORETO',
    'AYACUCHO','LAMBAYEQUE'
    'UCAYALI', 'JUNÍN','JUNIN',
    'HUANCAVELICA','CAJAMARCA',
    'APURÍMAC','ÁNCASH',
    'AMAZONAS'
    ]

class ObraPublica:
    def __init__(self):
        self.codigo_InfoObras = ""
        self.entidad = ""
        self.etapa = ""
        self.ubicacion = ""
        self.descripcion = ""
        self.tipo_construccion = "PUBLICA"
        self.Modalidad = ""
        self.Estado_Obra = ""
        self.Presupuesto = ""
        self.Fecha_Recuperacion =""
        self.estado = ""
    
    def Base_Info(self,codigo_InfoObras,entidad,descripcion,Modalidad,Estado_Obra,Presupuesto):
        fecha = date.today()
        self.codigo_InfoObras = codigo_InfoObras
        self.entidad = entidad
        self.ubicacion = self.EncontrarUbicacion(descripcion)
        self.descripcion =descripcion
        self.Modalidad =Modalidad
        self.Estado_Obra = Estado_Obra
        self.Presupuesto = Presupuesto
        self.Fecha_Recuperacion = fecha 
        self.estado = self.IdentificarEstado(Estado_Obra)
        
    def IdentificarEstado(self,Estado_Obra):
        Estado_Obra = str(Estado_Obra).upper()    
        if(Estado_Obra == "FINALIZADA"):
            return 2
        elif(Estado_Obra == "PARALIZADA"):
            return 2
        elif(Estado_Obra == "EN EJECUCI¢N"):
            return 1
        elif(Estado_Obra == "SIN EJECUCI¢N"):
            return 1

    def EncontrarUbicacion(self,descripcion):
        ubicacion = ""
        specialChars = ".,!" 
        for specialChar in specialChars:
            descripcion = str(descripcion).replace(specialChar, '')
        descripcion = descripcion.upper()   
        for i in Departamentos:
            if(i in descripcion):
                ubicacion=i
                break
        if(ubicacion == ""):
            ubicacion = "No Encontrada"
        return ubicacion

def FormarObrar(codigo_InfoObras,entidad,descripcion,Modalidad,Estado_Obra,Presupuesto):  
    ConstruccionPublica = ObraPublica()
    ConstruccionPublica.Base_Info(codigo_InfoObras,entidad,descripcion,Modalidad,Estado_Obra,Presupuesto)
    return ConstruccionPublica

def infobrasUpdate(id_usuario, UPLOAD_FOLDER, conexion):
    dataset = pd.read_excel(UPLOAD_FOLDER + '\\ObrasPublicas.xlsx')
    dataset = dataset.drop(0,axis=0)
    constPub = ObraPublica()

    for row in dataset.iterrows():
        constPub = FormarObrar(row[1]['C¢digo'],row[1]['Entidad'],row[1]['Descripci¢n de la obra'], 
                                row[1]['Modalidad de ejecuci¢n'],row[1]['Estado de la obra'],row[1]['Monto de inversi¢n'])
        
        print(constPub.codigo_InfoObras)
        cur = conexion.cursor()
        cur.execute("call sp_autogenerar_id_const")
        id_const = cur.fetchone()

        print(id_const[0])
        
        cur.execute("call sp_registrar_const_pub(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",
            (id_const[0],constPub.estado,constPub.ubicacion,
            "1",constPub.descripcion,id_usuario,constPub.codigo_InfoObras,
            constPub.entidad,constPub.Modalidad,
            constPub.Presupuesto,constPub.Estado_Obra,))

        data = cur.fetchall()
        cur.close()
        conexion.commit()
        print(data[0][0])

        if data[0][0] != 1 and data[0][0] != 2:
            return False 
      
    return True

if __name__ == '__main__': 
	infobrasUpdate()