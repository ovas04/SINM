from sys import flags
from urllib.request import urlopen, Request
from bs4 import BeautifulSoup
from datetime import date

Meses = {'ENERO' : 1, 'FEBRERO' : 2,'MARZO' : 3,'ABRIL' : 4,'MAYO' : 5,'JUNIO' : 6,
          'JULIO' : 7,'AGOSTO' : 8,'SEPTIEMBRE' : 9,'OCTUBRE' : 10,'NOVIEMBRE' : 11,'DICIEMBRE' : 12  }

class construccion:
    def __init__(self):
        self.pagina=""
        self.url = ""
        self.nombre = ""
        self.direccion = ""
        self.etapa = ""
        self.ubicacion = ""
        self.tipo_edificacion = ""
        self.Area_Techada = ""
        self.Area_total = ""
        self.culminacion =""
        self.fecha_culminacion = ""
        self.estado = ""
        self.constructora = ""
        self.financiamiento = ""
        self.descripcion = ""

    def set_BaseInfo(self,p_pagina,p_url,p_nombre,p_direccion,p_ubicacion,p_constructora, p_descripcion):
        self.pagina = p_pagina
        self.url = p_url
        self.direccion = p_direccion
        self.nombre = p_nombre
        self.ubicacion = p_ubicacion
        self.constructora = p_constructora
        self.descripcion = p_descripcion

    def set_p_tipo_edificacion(self,p_tipo_edificacion):
        self.tipo_edificacion = p_tipo_edificacion    

    def set_area_techada(self,p_area_techada):
        self.Area_Techada = p_area_techada

    def set_area_total(self,p_area_total):
        self.Area_total = p_area_total

    def set_etapa(self,p_etapa):
        self.etapa = p_etapa
        
    def set_fecha_culminacion(self,p_culminacion):
        Year = p_culminacion.split(" ")[3]
        Month = p_culminacion.split(" ")[2].replace(",","").upper()
        Day = p_culminacion.split(" ")[0]
        today = date.today()
        flag=True
        if(int(Year)< today.year):
            flag =False
        elif(int(Year) == today.year):
            if(Meses[Month]<today.month):
                flag=False
            elif(Meses[Month]==today.month):
                if(int(Day) < today.day):
                    flag=False
        if(flag):
            self.estado = 1 #Activa
        else:
            self.estado = 3 #Vencida
        self.fecha_culminacion = date(int(Year),Meses[Month],int(Day))
        self.culminacion = p_culminacion

    def fecha_culminacionProperati(self,Year,Month):
        if(Year != '' and Month != ''):
            today = date.today()
            flag=True
            if(int(Year)< today.year):
                flag =False
            elif(int(Year) == today.year):
                if(Meses[Month]<today.month):
                    flag=False
            if(flag):
                self.estado = 1 #Activa
            else:
                self.estado = 3 #Vencida
            self.fecha_culminacion = date(int(Year),Meses[Month],28)
            self.culminacion = Month + " , " + Year
        else:
            self.culminacion = "NO ENCONTRADA VERIFICAR EN ETAPA"
            self.fecha_culminacion = None
            self.estado = 4 #Duda
            if(self.etapa == "ENTREGA INMEDIATA"):
                self.estado = 3 #Vencida
        
    def set_financiamiento(self,p_financiamiento):
        self.financiamiento = p_financiamiento

def Data_Nexo(p_url,ObBs):
    construcion = construccion()
    Obj = ObBs.findAll("li",{"class":"list-data-general"})
    nombre =  ObBs.find("h1",{"class":"Project-header-title"})
    nombre = nombre.get_text().upper()
    direccion = ObBs.find("p",{"class":"Project-header-address street"})
    direccion =direccion.get_text().upper()
    ubicacion = ObBs.find("p",{"class":"Project-header-address urb"})
    ubicacion =ubicacion.get_text().upper()
    ubicacion = ubicacion.split("- ")[1]
    constructora = ObBs.find("div",{"class":"Project-inmobiliaria__name"})
    constructora = constructora.select('div > h2')[0].get_text(strip=True)#.split("/n")[0].upper()
    #descripcion = ObBs.find("div",{"Project-content-description"})
    #descripcion =descripcion.get_text().upper()
    #descripcion=descripcion.lstrip().replace("/n"," ")

    construcion.set_BaseInfo("NEXOINMOBILIARIO",p_url,nombre,direccion,ubicacion,constructora,"")
    contador = 0
    
    for i in Obj:
        if (contador == 0):
            tipo_edificacion = i.select('li > div')[1].get_text(strip=True).upper()
            if tipo_edificacion == "CASA":
                construcion.set_p_tipo_edificacion(1)
            elif tipo_edificacion == "DEPARTAMENTO":
                construcion.set_p_tipo_edificacion(2)
            elif tipo_edificacion == "OFICINA":
                construcion.set_p_tipo_edificacion(4)
            else:
                construcion.set_p_tipo_edificacion(3)
            
        elif (contador == 1):
            area_techada = i.select('li > div')[1].get_text(strip=True).upper()
            construcion.set_area_techada(area_techada)
        elif (contador == 2):
            area_total = i.select('li > div')[1].get_text(strip=True).upper()
            construcion.set_area_total(area_total)
        elif (contador == 5):
            Etapa = i.select('li > div')[1].get_text(strip=True).upper()
            construcion.set_etapa(Etapa)
        elif (contador == 6):
            fecha_culminacion = i.select('li > div')[1].get_text(strip=True)
            construcion.set_fecha_culminacion(fecha_culminacion)
        elif (contador == 7):
            financiamiento = i.select('li > div')[1].get_text(strip=True).upper()
            construcion.set_financiamiento(financiamiento)
        contador+=1

    return construcion

def nexoUpdate(id_usuario, conexion):
    constPriv = construccion()

    for i in range(1840,1850):
        _url=("https://nexoinmobiliario.pe/proyecto/venta-de-dasdepartamento-"+str(i))
        req = Request(_url, headers={'User-Agent': '  Mozilla/5.0'})
        html = urlopen(req).read()
        ObBs =  BeautifulSoup(html,"lxml")
        title = ObBs.find("title")
        if(not (title.get_text() == "Nexo Inmobiliario - Departamentos, lotes, casas y oficinas en venta")):
            constPriv = Data_Nexo(_url,ObBs)
            print(i)
        print(constPriv.url)

        cur = conexion.cursor()
        cur.execute("call sp_autogenerar_id_const")
        id_const = cur.fetchone()
        print(id_const[0])

        cur.execute("call sp_registrar_const_priv(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",
                (id_const,constPriv.estado,"1",constPriv.nombre,constPriv.descripcion,
                constPriv.fecha_culminacion,id_usuario,constPriv.pagina,constPriv.url,
                constPriv.tipo_edificacion,constPriv.Area_total,constPriv.Area_Techada,
                constPriv.constructora,constPriv.financiamiento,constPriv.ubicacion,
                constPriv.direccion,constPriv.etapa))

        data = cur.fetchall()
        cur.close()
        conexion.commit()
        print(data[0][0])

        if data[0][0] != 1 and data[0][0] != 2:
            return False

    return True

if __name__ == '__main__': 
	nexoUpdate()