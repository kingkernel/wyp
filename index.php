<?php
session_start();
/*
  	Funções relacionados ao controller geral do MVC
  	Criador Daniel Jose dos Santos
 	Criação: 24/05/2015
 	Ultima alterações: 07/07/2017
*/
//require("app/motor/conecta.php");
define ("PATHCONTROLER", __DIR__ . "/app/controlador/");
define ("PATHMODELO", __DIR__ . "/app/modelo/");
define ("PATHVISAO", __DIR__ . "/app/visao/");
define("PATHMOTOR", __DIR__ . "/app/motor/");
spl_autoload_register(function ($class_name) {
    include PATHMOTOR . "class/" . $class_name . '.class.php';
});
//define("FONTES", __DIR__. "/public/fonts/net/");
//define("PUBLICDIR", __DIR__. "/public/");
//define("PATHLOCAL", ".");
//se existir conteudo digitado, aceite, se não o conteudo se torna "index/index"
require(PATHMOTOR."kk-motor-01.php");
if (isset($_GET["urldigitada"]) ? $_GET["urldigitada"] . "/" : $_GET["urldigitada"] = "index/index");
//separe o que foi digitado, separado por barras e transforme a variavel em array
$parametros = explode("/", strtolower($_GET["urldigitada"]));
//se parametro existir aceite o parametro, se não se torna "index"
if(isset($parametros[0]) ? $parametros[0] : $parametros[0] = "index");
//cria uma variavel com o caminho do controlador
$pathmotor = PATHCONTROLER;
// transforma o conteudo do controlador em array
$buscapath = scandir($pathmotor);
/**	
	se o parametro digitado estiver dentro do array (existir o controlador),
	então inclua no index seu conteudo. 
 **/
if (in_array($parametros[0], $buscapath) == true){
	// caso exista inclue seu conteudo sera incluí­do
	include_once($pathmotor . $parametros[0] . "/" . $parametros[0] . ".php");
		// Caso o parametro 1 existir aceite, do contrario atribua o valor index
		if (isset($parametros[1]) ? $parametros[1] : $parametros[1] = "index");
		if(isset($parametros[1]) != false) {
			$page = new $parametros[0]();
			// caso alguém digite a barra vazia sem parametros.
			if ($parametros[1] == ""){
				// atribuimos index que é o padrão
				$parametros[1] = "index";
				};
				//caso digitem alguma coisa inexistente
			if (method_exists($page, $parametros[1]) == true){
				//se o argumento for valido execute o metodo
				$page->$parametros[1]();
				} else {
					//caso contrario, exit
					echo "Argumento invalido : <b>" . $parametros[1]."</b>";
					exit;
				};	
		};
		// caso o que foi digitado na url não existir, exiba a mensagem
	};/* else {
		//isolamento aqui 
			
			//pesquisa no banco de dados se a palavra digitada não é um usuario ou página		
			//$sql = 'select chamadaurl from pagesandperfil where chamadaurl="' . $parametros[0] . '"';
			//$busca = retornadbinfo($sql);
			//$linha = $busca->fetch(PDO::FETCH_ASSOC);
			//se existir inclua a pagina que carrega o perfil
			//if ($linha["chamadaurl"] == $parametros[0]){
				//rastro();
			//	include(PATHCONTROLER ."perfil/perfil.php");
			//	$perfil = new perfil();
				//$perfil->mostra_pessoa($linha["chamadaurl"]);
			};/* else {
				rastro();
				echo "<h1>nao existe</h1>";
				//fim isolamento
				
				header("HTTP/1.0 404 Not Found");
				echo "usuarios inexistente ou comando invalido : <b>" . $parametros[0] ."</b>";

				exit;
				//fim if
				
			}
			//fim do if
			
			//fim ultimo if
		};
		*/
?>