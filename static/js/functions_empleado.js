$(document).ready(function(){
	$(".empleados").addClass("active");
	list_empleado();
	regis_empleado();
	ver_empleado();
	edit_empleado();
	eli_empleado();
});

function list_empleado(){
	$("#tab_empleados").DataTable({
		"aprocessing": true,
		"aServerSide": true,
		"language": {
			"url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
		},
		"ajax": {
			"url": "/list_emple",
			"dataSrc": ""
		},
		"columns":[
			{"data":"0"},
			{"data":"1"},
			{"data":"2"},
			{"data":"3"},
			{"data":"4"},
			{"data":"7"},
			{"data":"8"},
			{"data":"6"},
			{"data":"5"},
			{"data":"9"}
		],
		"responsive": true,
		"bDestroy": true,
		"iDisplayLength": 10,
		"autoWidth": false
	});
}

function regis_empleado(){
	var form = document.querySelector("#form-empleado");
	$(".btn-form").click(function(e){
		e.preventDefault();
		var request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
		var ajaxUrl = "/regis_emple";
		var formData = new FormData(form);
		request.open("POST",ajaxUrl,true);
		request.send(formData);
		request.onload = function(){
			if(request.status == 200){
				var objData = JSON.parse(request.responseText);
				if(objData.status){
					$("#modal-empleado").modal("hide");
					form.reset();
					Swal.fire("¡Registrado!",objData.msg,"success");
					$("#tab_empleados").DataTable().ajax.reload();
				}else{
					Swal.fire("¡Error!",objData.msg,"error");
				}
			}else{
				console.log("No se enviaron los datos");
			}
		}
	});
}


function ver_empleado(){
	$("#tab_empleados").on("click",".btn-ver-emple",function(){
		$("#modal-empleado-d").modal("show");
		var id_emple = this.getAttribute("rl");
		var request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
		var ajaxUrl = "/buscar_empleado/"+id_emple;
		request.open("GET",ajaxUrl,true);
		request.send();
		request.onload = function(){
			if(request.status == 200){
				var objData = JSON.parse(request.responseText);
				$("#id_emple_d").val(id_emple);
				$("#nom_emple-d").val(objData[1]);
				$("#ape_emple-d").val(objData[2]);
				$("#dni_emple-d").val(objData[3]);
				$("#fech_emple-d").val(objData[4]);
				$("#sexo-d").val(objData[5]);
				$("#f-inicio-d").val(objData[6]);
				$("#mail_emple-d").val(objData[7]);
				$("#telef_emple-d").val(objData[8]);
				$("#distr_emple-d").val(objData[9]);
				$("#estado-d").val(objData[10]);
				$("#actividad").attr("href","/actividad/"+id_emple);
				$("#img_empleado_d").attr("src",'static/images/user1-128x128.jpg');
			}
		}
	});
}


//! NUEVO EDITAR EMPLEADO
function edit_empleado(){
	$("#tab_empleados").on("click",".btn-edit-emple",function(){
		$("#modal-empleado .btn-form").removeClass("btn-success").addClass("btn-primary");
		$("#modal-empleado .modal-title").text("Actualizar Empleado")
		$("#modal-empleado .btn-text").text("Actualizar");
		$("#modal-empleado").modal("show");
		var id_emple = this.getAttribute("rl");
		var request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
		var ajaxUrl = "/edi_emple/"+id_emple;
		request.open("GET",ajaxUrl,true);
		request.send();
		request.onload = function(){
			if(request.status == 200){
				var objData = JSON.parse(request.responseText);
				$("#id_emple").val(id_emple);
				$("#nom_emple").val(objData[1]);
				$("#ape_emple").val(objData[2]);
				$("#dni_emple").val(objData[3]);
				$("#fech_emple").val(objData[4]);
				$("#mail_emple").val(objData[7]);
				$("#telef_emple").val(objData[8]);
				$("#distr_emple").val(objData[9]);
				$("#sexo").val(objData[5]);
				$("#estado").val(objData[10]);
			}
		}
	});
}

function eli_empleado(){
	$("#tab_empleados").on("click",".btn-eli-emple",function(){
		var id_emple = this.getAttribute("rl");
		Swal.fire({
			title: "Eliminar Empleado",
			text: "¿Desea eliminar este empleado?",
			icon: "question",
			showCancelButton: true,
			confirmButtonText: "Si, eliminar!",
			cancelButtonText: "No, cancelar!"
		}).then((result)=>{
			if(result.isConfirmed){
				var request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
				var ajaxUrl = "/elim_emple/"+id_emple;
				request.open("POST",ajaxUrl,true);
				request.send();
				request.onload = function(){
					if(request.status == 200){
						var objData = JSON.parse(request.responseText);
						Swal.fire("¡Eliminado!",objData.msj,"success");
						$("#tab_empleados").DataTable().ajax.reload();
					}else{
						Swal.fire("Empleados","El registro no pudo ser eliminado","error");
					}
				}
			}else{
				Swal.fire("Cancelado","Tu registro está seguro :)","error");
			}
		});
	});
}

function open_modal(){
	$("#modal-empleado .btn-form").removeClass("btn-primary").addClass("btn-success");
	$("#modal-empleado .modal-title").text("Registrar Empleado")
	$("#modal-empleado .btn-text").text("Registrar");
	$("#modal-empleado").modal("show");
	$("#id_emple").val("0");
	$("#form-empleado")[0].reset();
}