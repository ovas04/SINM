$(document).ready(function(){
	$(".s-construcciones").css("display","block");
	$(".construcciones").addClass("active");
	$(".priv").addClass("active");
	regis_comen();

});


function regis_comen(){
	var form = document.querySelector("#form-reg_comen");
	$(".btn-regis-comen").click(function(e){
		e.preventDefault();
		var request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
		id_const = $("#id_construc").attr("rl");
		var ajaxUrl = "/reg_comen/";
		var formData = new FormData(form);
		console.log($("#tipo_contac_emp").attr("checked"))

		$("#form-reg_comen").find(':radio:checked').each(function () {
			if(this.id == 'tipo_contac_emp' ){
				formData.append('tipo','0');
			}
			else if (this.id == 'tipo_contac_per' ){
				formData.append('tipo','1');
			}
		});

		/*if($("#tipo_contac_emp").attr("checked") == true){
			formData.append('tipo','0');
		}
		else if($("#tipo_contac_per").attr("checked") == true) {
			formData.append('tipo','1');
		}*/
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