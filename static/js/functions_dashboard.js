$(document).ready(function(){
	$(".dashboard").addClass("active");
	info_dashboard();
});

function info_dashboard(){
	var request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
	var ajaxUrl = "/info_dashboard";
	request.open("GET",ajaxUrl,true);
	request.send();
	request.onload = function(){
		if(request.status == 200){
			var objData = JSON.parse(request.responseText);
			$(".vendedores .info-box-number").html(objData[0]);
			$(".construc_priv .info-box-number").html(objData[1]);
			$(".construc_pub .info-box-number").html(objData[2]);
			$(".usuarios .info-box-number").html(objData[3]);
		}
	}
}