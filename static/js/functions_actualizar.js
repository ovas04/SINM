$(document).ready(function(){
	$(".actualizar").addClass("active");
	list_actualizaciones_priv();
	list_actualizaciones_pub();
	actualizar_priv();
	actualizar_pub();
});

function list_actualizaciones_priv(){
	$("#tab_actualizaciones_priv").DataTable({
		"aprocessing": true,
		"aServerSide": true,
		"bPaginate":false,
		"bFilter":false,
		"bInfo":false,
		"language": {
			"url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
		},
		"ajax": {
			"url": "/list_act_priv",
			"dataSrc": ""
		},
		"columns":[
			{"data":"0"},
			{"data":"1"},
		],
		"responsive": true,
		"bDestroy": true,
		"autoWidth": false
	});
}

function list_actualizaciones_pub(){
	$("#tab_actualizaciones_pub").DataTable({
		"aprocessing": true,
		"aServerSide": true,
		"bPaginate":false,
		"bFilter":false,
		"bInfo":false,
		"language": {
			"url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
		},
		"ajax": {
			"url": "/list_act_pub",
			"dataSrc": ""
		},
		"columns":[
			{"data":"0"},
			{"data":"1"},
		],
		"responsive": true,
		"bDestroy": true,
		"autoWidth": false
	});
}

function actualizar_priv(){
	$(".btn-actualizar-priv").click(function(){
		Swal.fire({
			title: "Actualizando las construcciones privadas",
			allowEscapeKey: false,
			allowOutsideClick: false,
			didOpen: () => {
				Swal.showLoading()
				setTimeout(function(){
					var request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
					var ajaxUrl = "/upt_priv";
					request.open("POST",ajaxUrl,true);
					request.send();
					request.onload = function(){
						if(request.status == 200){
							var objData = JSON.parse(request.responseText);
							Swal.fire("Construcciones",objData.msg,objData.btn);
							$("#tab_actualizaciones_priv").DataTable().ajax.reload();
						}
					}
				}, 2000);
			}
		});
	});
}

function actualizar_pub(){
	$(".btn-actualizar-pub").click(function(){
		var form = document.querySelector("#form-actualizar");
		var file = $('#archivo');
		if(file[0].files.length != 0){
			Swal.fire({
				title: "Actualizando las construcciones públicas",
				allowEscapeKey: false,
				allowOutsideClick: false,
				didOpen: () => {
					Swal.showLoading()
					var request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
					var ajaxUrl = "/upt_pub";
					var formData = new FormData(form);
					request.open("POST",ajaxUrl,true);
					request.send(formData);
					request.onload = function(){
						if(request.status == 200){
							var objData = JSON.parse(request.responseText);
							Swal.fire("Construcciones",objData.msg,objData.btn);
							$("#tab_actualizaciones_pub").DataTable().ajax.reload();
						}
					}
				}
			});
		}else{
			const Toast = Swal.mixin({
				toast: true,
				position: 'top-end',
				showConfirmButton: false,
				timer: 2000,
				timerProgressBar: true,
				didOpen: (toast) => {
				  toast.addEventListener('mouseenter', Swal.stopTimer)
				  toast.addEventListener('mouseleave', Swal.resumeTimer)
				}
			  })
			  
			  Toast.fire({
				icon: 'warning',
				title: 'Introduzca un archivo'
			  })
		}
	});
}