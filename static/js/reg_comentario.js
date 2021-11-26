$(document).ready(function(){
	$(".s-construcciones").css("display","block");
	$(".construcciones").addClass("active");
	$(".priv").addClass("active");
	regis_comen();

});


function regis_comen(){
	var form = document.querySelector("#form-reg_comen");
	$(".btn-form").click(function(e){
		e.preventDefault();
		var request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
		id_const = $("#id_construc").attr("rl");
		var ajaxUrl = "/reg_comen/"+id_const;
		var formData = new FormData(form);
		request.open("POST",ajaxUrl,true);
		request.send(formData);
		request.onload = function(){
			if(request.status == 200){
				var objData = JSON.parse(request.responseText);
				if(objData.status){
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

function open_modal(){

	$("#form-reg_actividad")[0].reset();
}