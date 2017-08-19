<?php
//print_r($_POST);
session_start();
include("app/motor/class/notifications.class.php");
include("app/motor/function_all.php");
$email = $_POST["email"];
$sql = 'call sel_notify("'.$email.'")';
//echo $sql;
$query = retornadbinfo($sql);
$dados = $query->fetch(PDO::FETCH_ASSOC);
$quantos = $query->rowCount();
	if  ($quantos != 0){
	$partes = explode("||", $dados["mensagem"]);
	
	$notificacao = new notifications();
		$notificacao->icon = "./".$partes[2];
		$notificacao->text = $partes[1];
		$notificacao->title = $partes[0];
		$sql = 'call up_notify("'.$dados["idnotify"].'")';
		fastquery($sql);
		return $notificacao->render() . $sql;
		
	 } else {
	 	
	 }
?>