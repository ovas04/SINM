$(document).ready(function(){
    $(".s-roles").css("display","block");
    $(".roles").addClass("active");
	list_permisos();
	list_roles();
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
			{"data":"1"},
			{"data":"2"}
		],
		"responsive": true,
		"bDestroy": true,
		"iDisplayLength": 10,
		"autoWidth": false
	});
}

function list_roles(){
    $("#tab_roles").DataTable({
		"aprocessing": true,
		"aServerSide": true,
		"language": {
			"url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
		},
		"ajax": {
			"url": "/list_roles/",
			"dataSrc": ""
		},
		"columns":[
			{"data_final":"0"},
			{"data_final":"1"},
			{"data_final":"2"},
			{"data_final":"3"}
		],
		"responsive": true,
		"bDestroy": true,
		"iDisplayLength": 10,
		"autoWidth": false
	});

}