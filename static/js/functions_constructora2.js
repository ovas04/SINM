$(document).ready(function(){
	$(".s-construcciones").css("display","block");
	$(".construcciones").addClass("active");
	$(".pub").addClass("active");
	list_construc();
	regis_construc();
	ver_construc();
	coment_construc();
	//eli_construc();
	marcar_construccion();
	link_comen();
});

function list_construc(){
	$("#tab_constructoras").DataTable({
		"aprocessing": true,
		"aServerSide": true,
		"language": {
			"url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
		},
		"ajax": {
			"url": "/list_construc_pub",
			"dataSrc": ""
		},
		"columns":[
			//{"data":"0"},
			{"data":"1"},
			{"data":"2"},
			{"data":"3"},
			{"data":"4"},
			{"data":"5"},
			{"data":"6"},
			{"data":"7"},
			{"data":"8"}
		],
		"responsive": true,
		"bDestroy": true,
		"iDisplayLength": 10,
		"autoWidth": false
	});
}

function regis_construc(){
	var form = document.querySelector("#form-construc");
	$(".btn-form").click(function(e){
		e.preventDefault();
		var request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
		var ajaxUrl = "/regis_construc_pub";
		var formData = new FormData(form);
		request.open("POST",ajaxUrl,true);
		request.send(formData);
		request.onload = function(){
			if(request.status == 200){
				var objData = JSON.parse(request.responseText);
				if(objData.status){
					$("#modal-construc").modal("hide");
					form.reset();
					Swal.fire("¡Registrado!",objData.msg,"success");
					$("#tab_constructoras").DataTable().ajax.reload();
				}else{
					Swal.fire("¡Error!",objData.msg,"error");
				}
			}else{
				console.log("No se enviaron los datos");
			}
		}
	});
}

function ver_construc(){
	$("#tab_constructoras").on("click",".btn-ver-construc",function(){
		$("#modal-det-construc").modal("show");
		var id_construc = this.getAttribute("rl");
		var request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
		var ajaxUrl = "/buscar_construc_pub/"+id_construc;
		request.open("GET",ajaxUrl,true);
		request.send();
		request.onload = function(){
			if(request.status == 200){
				var objData = JSON.parse(request.responseText);
				$("#id_construc_d").val(id_construc);
				$("#id_construc_d").attr("rl",id_construc);
				$("#nom_construc_d").val(objData[1]);
				$("#cod_infobras_d").val(objData[2])
				$("#ubi_construc_d").val(objData[3]);
				$("#descri_d").val(objData[4]);
				$("#financ_d").val(objData[5]);
				$("#modalidad_d").val(objData[6]);
				$("#estado_o_d").val(objData[7]);
				$("#estado_d").val(objData[8]);
				if(objData[9] == 2){
					$(".btn-marc-const-pub").text("Construccion Ocupada");
					$(".btn-marc-const-pub").removeClass("btn-success");
					$(".btn-marc-const-pub").removeClass("btn-warning");
					$(".btn-marc-const-pub").addClass("btn-danger");
					$(".btn-marc-const-pub").attr("disabled",true)
				}
				else if (objData[9] == 3) {
					$(".btn-marc-const-pub").text("Construccion Visitada");
					$(".btn-marc-const-pub").removeClass("btn-success");
					$(".btn-marc-const-pub").removeClass("btn-danger");
					$(".btn-marc-const-pub").addClass("btn-warning");
					$(".btn-marc-const-pub").attr("disabled",false)
				}
				else{
					$(".btn-marc-const-pub").text("Marcar Construccion");
					$(".btn-marc-const-pub").removeClass("btn-danger");
					$(".btn-marc-const-pub").removeClass("btn-warning");
					$(".btn-marc-const-pub").addClass("btn-success");
					$(".btn-marc-const-pub").attr("disabled",false)
				}
				var comentarios = document.getElementById("comentarios");
				comentarios.innerHTML = "";
				for(i=0; i<objData[10].length ; i++){
					comentarios.innerHTML += objData[10][i];
				}
			}
		}
	});
}

function coment_construc(){
	$("#tab_constructoras").on("click",".btn-edit-construc",function(){
		$("#modal-construc .btn-form").removeClass("btn-success").addClass("btn-primary");
		$("#modal-construc .modal-title").text("Actualizar Construcción")
		$("#modal-construc .btn-text").text("Actualizar");
		$("#modal-construc").modal("show");
		$("#cod_infobras").prop("readonly",true);
		var id_construc = this.getAttribute("rl");
		var request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
		var ajaxUrl = "/buscar_construc_pub/"+id_construc;
		request.open("GET",ajaxUrl,true);
		request.send();
		request.onload = function(){
			if(request.status == 200){
				var objData = JSON.parse(request.responseText);
				$("#id_construc").val(id_construc);
				$("#nom_construc").val(objData[1]);
				$("#cod_infobras").val(objData[2]);
				$("#ubi_construc").val(objData[3]);
				$("#tipo").val(objData[7]);
				//$("#constructora").val(objData[11]);
				$("#modalidad").val(objData[6]);
				$("#descri").val(objData[4]);
				$("#financ").val(objData[5]);
				$("#estado").val(objData[8]);
			}
		}
	});
}
/*
function eli_construc(){
	$("#tab_constructoras").on("click",".btn-eli-construc",function(){
		var id_construc = this.getAttribute("rl");
		Swal.fire({
			title: "Eliminar Construccion",
			text: "¿Desea eliminar esta construccion?",
			icon: "question",
			showCancelButton: true,
			confirmButtonText: "Si, eliminar!",
			cancelButtonText: "No, cancelar!"
		}).then((result)=>{
			if(result.isConfirmed){
				var request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
				var ajaxUrl = "/elim_construc_pub/"+id_construc;
				request.open("POST",ajaxUrl,true);
				request.send();
				request.onload = function(){
					if(request.status == 200){
						var objData = JSON.parse(request.responseText);
						Swal.fire("¡Eliminado!",objData.msj,"success");
						$("#tab_constructoras").DataTable().ajax.reload();
					}else{
						Swal.fire("Construcciones","El registro no pudo ser eliminado","error");
					}
				}
			}else{
				Swal.fire("Cancelado","Tu registro está seguro :)","error");
			}
		});
	});
}
*/

function marcar_construccion(){
	$("#modal-det-construc").on("click",".btn-marc-const-pub",function(){
		var id_construc = $("#id_construc_d").attr("rl"); 
		Swal.fire({
			title: "Marcar Construccion",
			text: "¿Desea Marcar esta construccion?",
			icon: "question",
			showCancelButton: true,
			confirmButtonText: "Si, Marcar!",
			cancelButtonText: "No, cancelar!"
		}).then((result)=>{
			if(result.isConfirmed){
				var request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
				var ajaxUrl = "/marc_const/"+id_construc;
				request.open("POST",ajaxUrl,true);
				request.send();
				request.onload = function(){
					if(request.status == 200){
						var objData = JSON.parse(request.responseText);
						if(objData.flag == 0){
							Swal.fire("CONSTRUCCION OCUPADA","warning");
						}
						else{
							Swal.fire("MARCADO!",objData.msj,"success");
							setTimeout(function(){
								window.location.href = "/construcciones_privadas";
							}, 2000);		
						}
				}else{
							Swal.fire("Construcciones","El Registro Construccion Ocupada","error");
					}
				}
			}else{
				Swal.fire("Cancelado","Tu registro está seguro :)","error");
			}
		});
	});
}

function link_comen(){
	$(".btn-reg-comen").on("click",function(){
		var id_construc = $("#id_construc_d").attr("rl"); 
		window.location.href = "actividad_construc_pub/"+id_construc;
	});
}


function open_modal(){
	$("#modal-construc .btn-form").removeClass("btn-primary").addClass("btn-success");
	$("#modal-construc .modal-title").text("Registrar Construcción")
	$("#modal-construc .btn-text").text("Registrar");
	$("#cod_infobras").prop("readonly",false);
	$("#modal-construc").modal("show");
	$("#id_construc").val("0");
	$("#form-construc")[0].reset();
}