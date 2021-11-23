$(document).ready(function(){
    $(".s-usuarios").css("display","block");
    $(".usuarios").addClass("active");
	list_usuarios();
	get_permiso();
	regis_usuario();
    edit_usuario();
	elim_usuario_tempo();
	elim_usuario_perma();
});

function list_usuarios(){
	$("#tab_usuarios").DataTable({
		"aprocessing": true,
		"aServerSide": true,
		"language": {
			"url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
		},
		"ajax": {
			"url": "/list_usuarios",
			"dataSrc": ""
		},
		"columns":[
			{"data":"0"},
			{"data":"1"},
			{"data":"2"},
			{"data":"3"},
			{"data":"4"},
			{"data":"5"},
			{"data":"6"}
		],
		"responsive": true,
		"bDestroy": true,
		"iDisplayLength": 10,
		"autoWidth": false
	});
	//console.log("Realizado")
}

function regis_usuario(){
	var form = document.querySelector("#form-usuario");
	$(".btn-form").click(function(e){
		e.preventDefault();
		var request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
		var ajaxUrl = "/regis_usuario/";
		var formData = new FormData(form);
		request.open("POST",ajaxUrl,true);
		request.send(formData);
		request.onload = function(){
			if(request.status == 200){
				var objData = JSON.parse(request.responseText);
				if(objData.status){
					$("#modal-usuario").modal("hide");
					form.reset();
					Swal.fire("¡Registrado correctamente!",objData.msg,"success");
					$("#tab_usuarios").DataTable().ajax.reload();
				}else{
					Swal.fire("¡Error!",objData.msg,"error");
				}
			}else{
				console.log("No se enviaron los datos");
			}
		}
	});
}

function edit_usuario(){
	$("#tab_usuarios").on("click",".btn-edit-usu",function(){
		$("#modal-usuario .btn-form").removeClass("btn-success").addClass("btn-primary");
		$("#modal-usuario .modal-title").text("Actualizar Usuario")
		$("#modal-usuario .btn-text").text("Actualizar");
		$("#modal-usuario").modal("show");
		$("#nom_usu").attr("readonly","readonly");
		$("#id_dni_validacion").hide();
		var id_usuario = this.getAttribute("rl");
		var request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
		var ajaxUrl = "/buscar_usuario/"+id_usuario;
		request.open("GET",ajaxUrl,true);
		request.send();
		request.onload = function(){
			if(request.status == 200){
				var objData = JSON.parse(request.responseText);
				$("#id_usuario").val(id_usuario);
				$("#nom_usu").val(objData[1]);
				$("#rol_usu").val(objData[2]);
				$("#estado_usu").val(objData[3]);
			}
		}
	});
}

function get_permiso(){
	var id_usuario = $("#permiso").attr("rl");
	var request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
	var ajaxUrl = "/get_permiso/"+id_usuario;
	request.open("GET",ajaxUrl,true);
	request.send();
	request.onload = function(){
		if(request.status == 200){
			var objData = JSON.parse(request.responseText);
			$("#permiso").text(objData);
		}else{
			$("#permiso").text("Permisos no recuperado");
		}
	}
}

function elim_usuario_tempo(){
	$("#tab_elim_usuario").on("click",".btn-eli-usu-tempo",function(){
		console.log("Ingresa la funcion");
		var id_usuario = this.getAttribute("rl");
		Swal.fire({
			title: "Eliminar Usuario Temporalmente",
			text: "¿Desea eliminar este usuario de forma temporal?",
			icon: "question",
			showCancelButton: true,
			confirmButtonText: "Si, eliminar!",
			cancelButtonText: "No, cancelar!"
		}).then((result)=>{
			if(result.isConfirmed){
				var request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
				var ajaxUrl = "/elim_usuario_tempo/"+id_usuario;
				request.open("POST",ajaxUrl,true);
				request.send();
				request.onload = function(){
					if(request.status == 200){
						var objData = JSON.parse(request.responseText);
						Swal.fire("¡Eliminado temporalmente!",objData.msj,"success");
						setTimeout(function(){
							window.location.href = "/usuarios";
						}, 2000);
					}else{
						Swal.fire("Usuarios","El registro no pudo ser eliminado","error");
					}
				}
			}else{
				Swal.fire("Cancelado","Tu registro está seguro :)","error");
			}
		});
	});
}

function elim_usuario_perma(){
	$("#tab_elim_usuario").on("click",".btn-eli-usu-perma",function(){
		console.log("Ingresa la funcion");
		var id_usuario = this.getAttribute("rl");
		Swal.fire({
			title: "Eliminar Usuario Permanentemente",
			text: "¿Desea eliminar este usuario de forma permanente?",
			icon: "question",
			showCancelButton: true,
			confirmButtonText: "Si, eliminar!",
			cancelButtonText: "No, cancelar!"
		}).then((result)=>{
			if(result.isConfirmed){
				var request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
				var ajaxUrl = "/elim_usuario_perma/"+id_usuario;
				request.open("POST",ajaxUrl,true);
				request.send();
				request.onload = function(){
					if(request.status == 200){
						var objData = JSON.parse(request.responseText);
						Swal.fire("¡Eliminado permanentemente!",objData.msj,"success");
						setTimeout(function(){
							window.location.href = "/usuarios";
						}, 2000);
					}else{
						Swal.fire("Usuarios","El registro no pudo ser eliminado","error");
					}
				}
			}else{
				Swal.fire("Cancelado","Tu registro está seguro :)","error");
			}
		});
	});
}

function open_modal(){
	$("#modal-usuario .btn-form").removeClass("btn-primary").addClass("btn-success");
	$("#modal-usuario .modal-title").text("Registrar Usuario")
	$("#modal-usuario .btn-text").text("Registrar");
	$("#modal-usuario").modal("show");
	$("#id_usu").val("0");
	$("#form-usuario")[0].reset();
	$("#id_dni_validacion").show();
	$("#nom_usu").attr("readonly",false);
}