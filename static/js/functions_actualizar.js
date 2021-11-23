$(document).ready(function(){
	$(".actualizar").addClass("active");
	tipo_archivo();
	actualizar_priv();
	actualizar_pub();
});

function tipo_archivo(){
	$("#form-actualizar").on("change","#tipo",function(){
		var tipo = $("#tipo").val();
		if(tipo == 1){
			$(".archivo").css("display","block");
			$(".link").css("display","none");
		}else{
			$(".archivo").css("display","none");
			$(".link").css("display","block");
		}
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
							Swal.fire("¡Construcciones privadas actualizadas!",objData.msg,"success");
						}else{
							Swal.fire("Construcciones","Error al actualizar las construcciones privadas","error");
						}
					}
				}, 2000);
			}
		});
	});
}

function actualizar_pub(){
	$(".btn-actualizar-pub").click(function(){
		var file = $('#archivo');
		var link = $('#link').val();
		if(file[0].files.length != 0 || link.length != 0){
			Swal.fire({
				title: "Actualizando las construcciones publicas",
				allowEscapeKey: false,
				allowOutsideClick: false,
				didOpen: () => {
					Swal.showLoading()
					setTimeout(function(){
						var request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
						var ajaxUrl = "/upt_pub";
						request.open("POST",ajaxUrl,true);
						request.send();
						request.onload = function(){
							if(request.status == 200){
								var objData = JSON.parse(request.responseText);
								Swal.fire("¡Construcciones públicas actualizadas!",objData.msg,"success");
							}else{
								Swal.fire("Construcciones","Error al actualizar las construcciones privadas","error");
							}
						}
					}, 2000);
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
				title: 'Introduzca un archivo o enlace'
			  })
		}
	});
}