<?php
	session_start();
	
	include "php/Conexao.php";
	
	if((!isset ($_SESSION['MLO']['nick']) == true) and (!isset ($_SESSION['MLO']['senha']) == true)) 
	{ 
		unset($_SESSION['MLO']);
		
		setcookie("MLO[nick]", "", time()-3600, "/");
		setcookie("MLO[senha]", "", time()-3600, "/");
		
		header('location: index.php'); 
	}
	
	$logado = $_SESSION['MLO']['nick'];
	$codigo = $_SESSION['MLO']['codigo'];
	
	$query_Busca = "select * from tb_usuario where cd_usuario = '$codigo'";
			
	$result_Busca = mysql_query($query_Busca) or die(mysql_error());
	$linha_Busca = mysql_fetch_assoc($result_Busca);
	$totalLinha_Busca = mysql_num_rows($result_Busca);
	
	$query_Amigos = "select tb_usuario.cd_usuario as 'Codigo', tb_usuario.nm_nickname as 'Amigo', tb_usuario.dt_ultima_atividade as 'Ultima Atividade', tb_usuario.ic_logado as 'Logado', (select count(tb_usuario.ic_logado) from usuario_amigo inner join tb_usuario on usuario_amigo.cd_amigo = tb_usuario.cd_usuario where tb_usuario.ic_logado = 1 and usuario_amigo.cd_usuario = '$codigo') as 'Logados'
					  from usuario_amigo inner join tb_usuario
						on usuario_amigo.cd_amigo = tb_usuario.cd_usuario
						  where usuario_amigo.cd_usuario = '$codigo'
							order by tb_usuario.ic_logado desc, tb_usuario.nm_nickname asc";
			
	$result_Amigos = mysql_query($query_Amigos) or die(mysql_error());
	$linha_Amigos = mysql_fetch_assoc($result_Amigos);
	$totalLinha_Amigos = mysql_num_rows($result_Amigos);
	
?>

<!DOCTYPE>
<html>
	<head>
		<meta charset="UTF-8">
		<title>MLO Infinity - Área do Usuário</title>
		<style>
			*
			{
				padding: 0px;
				margin: 0px;
				outline: none;
				font-family: Century Gothic;
				overflow: hidden;
			}
			
			::-webkit-scrollbar {
				height: 7px;
				width: 7px;
				background: RGBA(255,255,255,0.1);
			}
			
			::-webkit-scrollbar-thumb
			{
				background:  gray;
				-webkit-box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.75);
			}

			::-webkit-scrollbar-corner
			{
				background:  white;
			}
			
			#barra_superior
			{
				display: inline-block;
				width: 100%;
				height: 50px;
				background-color: RGBA(0,0,0,1);
				box-shadow: 0px 0px 2px 0px black;
				z-index: 9999;
				position: absolute;
			}
			
			#logo
			{
				display: inline-block;
				width: 75px;
				margin-top:2px;
				margin-left:10px;
			}
			
			#btn_menu_topo
			{
				display: inline-block;
				width: 25px;
				height: 25x;
				padding:15px;
				z-index: 9999;
			}
			
			#menu_topo img
			{
				display: inline-block;
				width: 20px;
				margin-left: 5px;
			}
			
			#btn_menu_topo:hover
			{
				display: inline-block;
				background-color: black;
			}
			
			#menu_topo
			{
				display: none;
				background-color: black;
				margin-top:50px;
				width: 130px;
				height: 140px;
				right: 0px;
				position: absolute;
				box-shadow: 0px 0px 2px 0px black;
				z-index: 9999;
			}
			
			#menu_topo label
			{
				display: inline-block;
				width: 200px;
				height: 50px;
				position: absolute;
				padding: 5px;
				color: white;
				font-size: 12px;
				margin-top:-3px
			}
			
			#table_menu_topo
			{
				display: inline-block;
				width: 200px;
				border: 0px solid transparent;
				margin-left: -	5px;
			}
			
			#menu_topo td
			{
				width: 100%;
				height: 30px;
			}
			
			#menu_topo td:hover
			{
				background-color: #c00000;
			}
			
			#username
			{
				display: inline-block;
				color: white;
				right: 70px;
				margin-top: 3px;
				margin-right: 10px;
			}
			
			
			
			#rig
			{
				display: inline-block;
				position: absolute;
				right: 0px;
				z-index: 9999;
				margin-top: -2px;
			}
			
			#imgPerfil
			{
				display: inline-block;
				width: 40px;
				height: 40px;
				padding:2px;
				margin-right: 5px;
				background-image: url('imagens/gus.jpg');
				filter: blur(3px);
			}
			
			#imgPerfilFoto
			{
				display: inline-block;
				width: 99%;
				padding:0%;
			}
			
			#footer
			{
				display: inline-block;
				width: 100%;
				height: 30px;
				bottom: 0px;
				position: absolute;
				background-color: RGBA(0,0,0,1);
				z-index: 9998;
				box-shadow: 0px 0px 1px 0px gray;
			}
			
			#footer:hover
			{
				background-color: black;
			}
			
			#btn_chat_all
			{
				display: inline-block;
				position: absolute;
				right: 0px;
				height: 20px;
				background-color: #c00000;
				padding: 5px;
			}
			
		
			#amigos_usuario
			{
				display: none;
				right: 0px;				
				bottom: 0px;
				width: 200px;
				height: 100%;
				position: fixed;
				background-color: RGBA(0,0,0,0.8);
				overflow: hidden;
				z-index: 9997;
			}
			
			#foto_amigo
			{
				display: inline-block;
				width: 20px;
				height: 20px;
				padding:5px;
				border-radius: 23px;
			}
			
			.status
			{
				display: inline-block;
				width: 20px;
				
			}
			
			.nome_amigo
			{
				color: white;
				font-size: 10px;
				text-shadow: 1px 0px black;
			}
			
			#lista_amigos
			{
				display: inline-block;
				width: 100%;
				height: 90%;
				overflow: auto;
				overflow-x: hidden;
				position: absolute;
				margin-top:30px;
				z-index: 9997;
			}
			
			#midi
			{
				display: inline-block;
				width: 100%;
				height: 90%;
				z-index: 9997;
				position: fixed;
			}	
			
			#amigos_online
			{
				display: inline-block;
				right: 40px;
				color: white;
				position: absolute;
				font-size: 12px;
				margin-top:6px;
				z-index: 9997;
			}
			
			#amiguinho
			{
				display: inline-block;
				width: 100%;
				padding-top:5px;
				padding-bottom:5px;
				padding-left: 10px;
			}
			
			#amiguinho:hover
			{
				display: inline-block;
				width: 100%;
				padding-top:5px;
				padding-bottom:5px;
				background-color: black;
			}
			
			#chat_on
			{
				display: inline-block;
				width: 90%;
				height: 100%;
				padding: 3px;
				background-color: transparent;
			}
			
			
			.btn_chat_window
			{
				display: inline-block;
				width: 200px;
				background-color: #333;
			}
			
			#chat_on table
			{
				display:inline-block;
				width: 200px;
			}
			
			.fecha_chat
			{
				display: inline-block;
				background-color: transparent;
				width: 20px;
				top:5px;
				color: white;
				position: absolute;
				right: 0px;
				border: 0px solid transparent;
			}
			
			.fecha_chat:hover
			{
				font-weight: bold;
			}
			
			.chatconversa
			{
				display: inline-block;
				background-color: #333;
				width: 200px;
				height: 30px;
				z-index: 9999;
				position: relative;
				bottom: 0px;
				margin-left: 3px;
				z-index: 9999;
			}
			
			.conversa
			{
				display: none;
				width: 100%;
				position: relative;
				height: 175px;
			}
			
			.input_conversa
			{
				display: none;
				width: 100%;
				height: 27px;
				margin-top:3px;
				
			}
			
			.txt_output_chat
			{
				display: inline-block;
				background-color: RGBA(105,105,105,1);
				color: white;
				border: 0px;
				width: 100%;
				height: 100%;
				resize: none;
				overflow: auto;
				padding: 5px;
			}
			
			.txt_input_chat
			{
				display: inline-block;
				background-color: RGBA(79,79,79,0.9);
				color: white;
				border: 0px;
				width: 100%;
				resize: none;
				overflow: auto;
				padding: 7px;
				font-size: 10px;
				text-shadow: 0px 1px gra;
			}
			
			#central
			{
				display: inline-block;
				color: white;
				width: 100%;
				position: fixed;
				height: 100%;
				bottom: 30px;
				background-image: url('imagens/02.jpg');
				z-index: 9995;				
				background-size: 100%;
				background-repeat: no-repeat;
				background-attachment: fixed;
				-webkit-background-size: cover;
				-moz-background-size: cover;
				filter: blur(5px);
				
			}
			
			#inicio
			{
				display: none;
				width: 100%;
				height: 100%;
				background-color: transparent;
				border: 0px;
				z-index: 9995;
			}
			
			#conversa_all
			{
				display: inline-block;
				position: absolute;
				bottom: -5px;
			}
		</style>
	</head>
	<script src="script/Criptografia.js"></script>
	<body onselectstart='return false'>
		<iframe id="Logados" src="" style="display: none;">Navegador não suporta IFrames</iframe>
		<iframe id="Chat" src="" style="display: none;">Navegador não suporta IFrames</iframe>
		<div id="all">
			<div id="barra_superior">
				<img id="logo" src="imagens/logo.png">		
				<table id="rig">
					<tr>
						<!--<td>
							<div id="imgPerfil">
								<img id="imgPerfilFoto" src="imagens/gus.jpg">
							</div>
						</td>-->
						<td>
							<label id="username"><?php echo $logado; ?></label>
						</td>
						<td>
							<input type="image" src="imagens/menu_topo_squares.png" id="btn_menu_topo">
						</td>
					</tr>
				</table>
			</div>
			<div id="menu_topo">
				<table id="table_menu_topo">
					<tr>
						<td>
							<img src="imagens/configuracoes.png">						
							<label>Configurações</label>
						</td>
					</tr>
					
					<tr>
						<td>
							<img src="imagens/contas.png">	
							<label>Contas</label>
						</td>
					</tr>
					
					<tr>
						<td>
							<img src="imagens/ajuda.png">	
							<label>Ajuda</label>
						</td>
					</tr>
					
					<tr>
						<td id="btn_logout">
							<img src="imagens/sair.png">	
							<label>Sair</label>
						</td>
					</tr>
				</table>
			</div>	
		</div>
		<div id="amigos_usuario" align="left">
		<br>
			<div id="lista_amigos">
				<?php
					do
					{
						$totalLogados = $linha_Amigos['Logados'];
						
						if($linha_Amigos['Logado'] == 1) 
						{
							$imgonoff = "useronline.png";
						}
						else 
						{
							$imgonoff = "useroffline.png";
						}
												
						$nomeAmigo = $linha_Amigos['Amigo'];
						$codigoAmigo = $linha_Amigos['Codigo'];
						
						$funcaoAbrirChat = base64_encode('if(fechouchat == 0){if (conversa'.$codigoAmigo.'.style.display == "none"){conversa'.$codigoAmigo.'.style.display = "inline-block";input_conversa'.$codigoAmigo.'.style.display = "inline-block";chatconversa'.$codigoAmigo.'.style.height = "230px";chatconversa'.$codigoAmigo.'.style.backgroundColor ="#000";}else{conversa'.$codigoAmigo.'.style.display = "none";input_conversa'.$codigoAmigo.'.style.display = "none";chatconversa'.$codigoAmigo.'.style.height = "30px";chatconversa'.$codigoAmigo.'.style.backgroundColor ="#333";btn_chat_window'.$codigoAmigo.'.style.backgroundColor ="#333";}}');
						
						$divChat = base64_encode('<div id="btn_chat_window'.$codigoAmigo.'" class="btn_chat_window"><table><tr><td><img src="imagens/'.$imgonoff.'" id="status.'.$codigoAmigo.'" class="status"></td><td><label id="nome_amigo'.$codigoAmigo.'" class="nome_amigo">'.$nomeAmigo.'</label></td><td><input type="button" id="fecha_chat'.$codigoAmigo.'" class="fecha_chat" value="X"></td></tr></table></div><div id="conversa'.$codigoAmigo.'" class="conversa"><textarea id="txt_output_chat'.$codigoAmigo.'" class="txt_output_chat" onselectstart="return true" readonly></textarea></div><div id="input_conversa'.$codigoAmigo.'" class="input_conversa"><textarea id="txt_input_chat'.$codigoAmigo.'" class="txt_input_chat" onselectstart="return true"></textarea></div>');
						
						$funcaoFecharChat = base64_encode('fechouchat = 1; chatconversa'.$codigoAmigo.'.remove();');
			
						$funcaoEnviarChat = base64_encode('if (event.keyCode == 13 && txt_input_chat'.$codigoAmigo.'.value.trim() != "") {var mensagem = base64_encode(txt_input_chat'.$codigoAmigo.'.value.trim()); txt_input_chat'.$codigoAmigo.'.value = ""; Chat.src = "php/EnviarMensagemChat.php?mensagem=" + mensagem + "&codigoAmigo='.$codigoAmigo.'";}');
				?>
						<div id="amiguinho" onclick="if (!(aux = document.getElementById('chatconversa<?php echo $codigoAmigo; ?>'))) {aux = document.createElement('div'); aux.setAttribute('id', 'chatconversa<?php echo $codigoAmigo; ?>'); aux.setAttribute('class', 'chatconversa'); aux.innerHTML = base64_decode('<?php echo $divChat; ?>'); conversa_all.insertAdjacentElement('beforeend', aux); btn_chat_window<?php echo $codigoAmigo; ?>.setAttribute('onclick', 'eval(base64_decode(\'<?php echo $funcaoAbrirChat; ?>\'));'); fecha_chat<?php echo $codigoAmigo; ?>.setAttribute('onclick', 'eval(base64_decode(\'<?php echo $funcaoFecharChat; ?>\'));'); txt_input_chat<?php echo $codigoAmigo; ?>.setAttribute('onkeypress', 'eval(base64_decode(\'<?php echo $funcaoEnviarChat; ?>\'));'); fechouchat = 0; btn_chat_window<?php echo $codigoAmigo; ?>.click();
						btn_chat_window<?php echo $codigoAmigo; ?>.click();} else {btn_chat_window<?php echo $codigoAmigo; ?>.click();} Chat.src = 'php/BuscarChat.php?codigoAmigo=<?php echo $codigoAmigo; ?>';">
							<table>
								<tr>
									<td>
										<img src="imagens/<?php if($linha_Amigos['Logado'] == 1) {echo "useronline.png";} else {echo "useroffline.png";} ?>" class="status">
									</td>
									<td>
										<input type="image" src="imagens/gus.jpg" id="foto_amigo">
									</td>
									<td>
										<label class="nome_amigo" style="font-weight:bold"><?php echo $linha_Amigos['Amigo']; ?></label>
									</td>
									
								</tr>
							</table>
						</div>
				<?php
					}
					while ($linha_Amigos = mysql_fetch_assoc($result_Amigos));
				?>
			</div>
			
		</div>
		<div id="central">
			<iframe id="inicio" src="inicial.php"></iframe>
		</div>
		<div id="conversa_all">
			<!--GERAR
			<div id="chatconversa" class="chatconversa">
				<div id="btn_chat_window" class="btn_chat_window">
					<table>
						<tr>
							<td>
								<img src="imagens/useronline.png" id="status" class="status">
							</td>
							<td>
								<label id="nome_amigo" class="nome_amigo">Goldbach07</label>
							</td>
							<td>
								<input type="button" id="fecha_chat" class="fecha_chat" value="X">
							</td>
						</tr>
					</table>
				</div>
				<div id="conversa" class="conversa">
					<textarea id="txt_output_chat" class="txt_output_chat"></textarea>
				</div>
				<div id="input_conversa" class="input_conversa">
					<textarea id="txt_input_chat" class="txt_input_chat"></textarea>
				</div>
			</div>
			-->
			<!--GERAR
			<div id="chatconversa">
				<div id="btn_chat_window">
					<table>
						<tr>
							<td>
								<img src="imagens/useronline.png" id="status">
							</td>
							<td>
								<label id="nome_amigo">Goldbach07</label>
							</td>
							<td>
								<input type="button" id="fecha_chat" value="X">
							</td>
						</tr>
					</table>
				</div>
				<div id="conversa">
					<textarea id="txt_output_chat"></textarea>
				</div>
				<div id="input_conversa">
					<textarea id="txt_input_chat"></textarea>
				</div>
			</div>
			-->
		</div>
		
		<div id="footer">	
			<div id="chat_on">
				<!--<div id="btn_chat_window">
					<table>
						<tr>
							<td>
								<img src="imagens/useroffline.png" id="status">
							</td>
							<td>
								<label id="nome_amigo">Goldbach07</label>
							</td>
							<td>
								<input type="button" id="fecha_chat" value="X">
							</td>
						</tr>
					</table>
				</div>-->
			</div>
			<label id="amigos_online"><?php echo $totalLogados.'/'.$totalLinha_Amigos; ?></label><img src="imagens/chat.png" id="btn_chat_all">
		</div>
	</body>
	<script src="script/jquery.min.js"></script>
	<script>
		window.onload = function()
		{
			$("#inicio").toggle('slide');

			fechouchat = 0;
			
			ManterLogado();
			AtualizarChats();
		}
		
		function AtualizarChats()
		{
			var aux = document.getElementsByClassName("chatconversa");
			
			if (aux.length != 0)
			{
				var junto = "";
				
				for (cont = 0; cont <= aux.length - 1; cont = cont + 1)
				{
					if (cont != aux.length - 1)
					{
						junto = junto + aux[cont].id.replace("chatconversa", "") + ";";
					}
					else
					{
						junto = junto + aux[cont].id.replace("chatconversa", "");
					}
				}
				
				Chat.src = "php/AtualizarChats.php?codigoAmigos=" + base64_encode(junto);
			}
			
			setTimeout("AtualizarChats()", 15000);
		}
		
		function ManterLogado()
		{
			ManterLogado.src = "php/ManterLogado.php";
			setTimeout("ManterLogado();", 5*60*1000);
		}
		
		btn_chat_all.onclick = function()
		{
			ativaChat();
		}
		
		
		btn_menu_topo.onclick = function()
		{
			ativaMenuTopo();
		}
		
		function ativaMenuTopo()
		{
			if(menu_topo.style.display == "none")
			{
				menu_topo.style.display = "inline-block";
			}
			else
			{
				menu_topo.style.display = "none"
			}
		}
		
		function ativaChat()
		{
			if(amigos_usuario.style.display == "none")
			{
				amigos_usuario.style.display = "inline-block";
				btn_chat_all.style.backgroundColor = "#000000";
			}
			else
			{
				amigos_usuario.style.display = "none";
				btn_chat_all.style.backgroundColor = "#c00000";
			}
		}
		
		/*btn_chat_window.onclick = function()
		{
			if(conversa.style.display == "none")
			{
				conversa.style.display = "inline-block";
				input_conversa.style.display = "inline-block";
				chatconversa.style.height = "230px";
				chatconversa.style.backgroundColor ="#000";
			}
			else
			{
				conversa.style.display = "none";
				input_conversa.style.display = "none";
				chatconversa.style.height = "30px";
				chatconversa.style.backgroundColor ="#333";
				btn_chat_window.style.backgroundColor ="#333";
			}
			
		}*/
		
		btn_logout.onclick = function()
		{
			window.location.href = "php/Logout.php";
		}
	</script>
</html>
<?php
	mysql_close($conexao);
?>