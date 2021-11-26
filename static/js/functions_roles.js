$(document).ready(function(){
    $(".s-roles").css("display","block");
    $(".roles").addClass("active");
	list_permisos();
});

function list_permisos(){
    $("#tab_permisos").DataTable({
		"aprocessing": true,
		"aServerSide": true,
		"language": {
			"url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
		},
		"ajax": {
			"url": "/list_permisos/",
			"dataSrc": ""
		},
		"columns":[
			{"data":"0"},
			{"data":"1"}
		],
		"responsive": true,
		"bDestroy": true,
		"iDisplayLength": 10,
		"autoWidth": false
	});

}