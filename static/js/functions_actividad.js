$(document).ready(function(){
	$(".empleados").addClass("active");
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