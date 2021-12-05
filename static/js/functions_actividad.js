$(document).ready(function(){
	$(".empleados").addClass("active");
	enviar_mensaje();
	datos_empleado();
	list_actividad();

});

function datos_empleado(){
	var id_emple = $("#id_emple").val();
	var request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
	var ajaxUrl = "/buscar_empleado/"+id_emple;
	request.open("GET",ajaxUrl,true);
	request.send();
	request.onload = function(){
		if(request.status == 200){
			var objData = JSON.parse(request.responseText);
			$("#nombre_emple").text(objData[1]+' '+objData[2]);
			$("#rol_emple").text("Vendedor");
			$("#dni_emple").text(objData[3]);
			$("#mail_emple").text(objData[7]);
			$("#mail_emple_m").text(objData[7]);
			$("#telef_emple").text(objData[8]);
		}
	}
}

function list_actividad(){
	var id_emple = $("#id_emple").val();
	$("#tab_actividades").DataTable({
		"aprocessing": true,
		"aServerSide": true,
		"language": {
			"url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
		},
		"ajax": {
			"url": "/list_actividad/"+id_emple,
			"dataSrc": ""
		},
		"columns":[
			{"data":"0"},
			{"data":"2"},
			{"data":"1"},
			{"data":"3"},
			{"data":"4"},
			{"data":"5"}
		],
		"responsive": true,
		"bDestroy": true,
		"iDisplayLength": 10,
		"autoWidth": false
	});
}


function enviar_mensaje(){
	var form = document.querySelector("#form-llamada_atencion");
	$(".btn-enviar").click(function(e){
		e.preventDefault();
		var request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
		var id_emple = $("#id_emple_m").val(); 
		var tipo =  $("#tipo").val();
		var ajaxUrl = "/enviar_mensaje/"+id_emple+"/"+tipo;
		var formData = new FormData(form);
		console.log($("#tipo_contac_emp").attr("checked"))
		/*	
		$("#form-reg_comen").find(':radio:checked').each(function () {
			if(this.id == 'tipo_contac_emp' ){
				formData.append('tipo','0');
			}
			else if (this.id == 'tipo_contac_per' ){
				formData.append('tipo','1');
			}
		});*/

		request.open("POST",ajaxUrl,true);
		request.send(formData);
		request.onload = function(){
			if(request.status == 200){
				var objData = JSON.parse(request.responseText);
				if(objData.flag == 0){
					Swal.fire("ERROR CON EL ENVIO","warning");
				}
				else{
					Swal.fire("ENVIADO!",objData.msj,"success");
				}
			}else{
				console.log("No se enviaron los datos");
			}
		}
	});
}