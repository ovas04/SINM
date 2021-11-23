$(document).ready(function(){
	var form_login = document.querySelector("#form-login");
	form_login.onsubmit = function(e){
		e.preventDefault();
		var request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
		var ajaxUrl = "/login";
		var formData = new FormData(form_login);
		request.open("POST",ajaxUrl,true);
		request.send(formData);
		request.onload = function(){
			if(request.status == 200){
				var objData = JSON.parse(request.responseText);
				if(objData.status){
					window.location = "/dashboard";
				}else{
					Swal.fire("¡Atención!",objData.msg,"error");
					$("#password").val("");
				}
			}
		}
	}
});