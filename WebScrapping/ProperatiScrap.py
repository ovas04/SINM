from urllib.request import urlopen, Request
from bs4 import BeautifulSoup
from datetime import date
import urllib3

Meses = {'ENERO' : 1, 'FEBRERO' : 2,'MARZO' : 3,'ABRIL' : 4,'MAYO' : 5,'JUNIO' : 6,
          'JULIO' : 7,'AGOSTO' : 8,'SETIEMBRE' : 9,'OCTUBRE' : 10,'NOVIEMBRE' : 11,'DICIEMBRE' : 12  }

class construccion:
    def __init__(self):
        self.pagina=""
        self.url = ""
        self.nombre = ""
        self.direccion = ""
        self.etapa = ""
        self.ubicacion = ""
        self.tipo_edificacion = "3"
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
                if(Day < today.day):
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

#!https://stackoverflow.com/questions/36516183/what-should-i-use-to-open-a-url-instead-of-urlopen-in-urllib3
def DataProperati(_link):
    http = urllib3.PoolManager()
    _url = 'https://www.properati.com.pe'+str(_link)
    #html = urlopen(_url)
    response = http.request('GET', _url)
    ObBs = BeautifulSoup(response.data,'lxml') #html,"lxml"
    ConstruccionProperati = construccion()
    try:
        #-------------------------------------------------
        Oracion = ObBs.find('h1',{'class':"sc-fujyAs bTSNFO"}).get_text()
        Oracion = Oracion.split('·')
        v_nombre = Oracion[0].upper()
        try:
            v_direccion = Oracion[1].upper()
        except IndexError as e:
            v_direccion = "NO ENCONTRADO"
        #-------------------------------------------------------
        Encabezado = ObBs.find_all('span',{'class':'sc-bqGGPW eeFzyh'})
        v_ubicacion = Encabezado[2].get_text().upper()
        v_etapa =  Encabezado[1].get_text().upper()
        #--------------------------------------------------------
        try:
            Encabezado = ObBs.find('div',{'class':'StyledContentSeller-sc-1yzimq1-2 fDqWgA'})
            v_constructora= Encabezado.select('div > h2')[0].get_text(strip=True).upper()
        except AttributeError as e:
            v_constructora = "NO ENCONTRADA"
        #-------------------------------------------------------------------------------
        Encabezado = ObBs.find('div',{'class':'child-wrapper'})
        v_descripcion = Encabezado.get_text().upper()
    
        ConstruccionProperati.set_BaseInfo("PROPERATI",_url,v_nombre,v_direccion,
                                    v_ubicacion,v_constructora,
                                     v_descripcion)
        ConstruccionProperati.set_etapa(v_etapa)
        #--------------------------------------------------------------
        Encabezado = ObBs.find('div',{'class':'child-wrapper'})
        Encabezado = Encabezado.select('div > p')[0].get_text().split(" ")
        year=""
        month = ""
        for i in Encabezado:
            if(i in Meses):
                month = i
            if(i.isdigit() and int(i)>2000):
                year = i
        ConstruccionProperati.fecha_culminacionProperati(year,month)
        print("Exito")
    except:
        print("ERROR INTERNO")
    return ConstruccionProperati

def properatiUpdate(id_usuario, conexion):
    constPriv = construccion()

    for i in range(1):
        _url = 'https://www.properati.com.pe/proyectos-inmobiliarios/q?page='+str(i)
        html = urlopen(_url)
        ObBs = BeautifulSoup(html,"lxml")
        Obj = ObBs.findAll("div",{"class":"StyledCard-sc-n9541a-1 fQVFON"})
        for j in Obj:
            j = (j.select ('div > a ')[0])
            constPriv = DataProperati(str(j.attrs['href']))

            print(constPriv.url)

            cur = conexion.cursor()
            cur.execute("call sp_autogenerar_id_const")
            id_const = cur.fetchone()
            print(id_const[0])
            
            cur.execute("call sp_registrar_const_priv(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",
                    (id_const,constPriv.estado,'1',constPriv.nombre,constPriv.descripcion,
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
	properatiUpdate()