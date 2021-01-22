<?php
	include ("Conexao.php");
	
	session_start();
	unset($_SESSION['MLO']);
	
	$nick = $_POST['nick'];
	$senha = base64_encode($_POST['senha']);
	
	if (isset($_POST['continuar']))
	{
		$continuar = $_POST['continuar'];
	}
	else
	{
		$continuar = 0;
	}
	
	$verifica = mysql_query("select nm_email from tb_usuario where nm_nickname = '$nick' and cd_senha = '$senha'") or die(mysql_error());
	
	if (mysql_num_rows($verifica) <= 0)
	{
		unset($_SESSION['MLO']);
		
		setcookie("MLO[nick]", "", time()-3600, "/");
		setcookie("MLO[senha]", "", time()-3600, "/");
		
		echo "<script> alert('Login e/ou senha incorretos!'); parent.LimparLogin(); parent.Funcoes.src = '';</script>";
	}
	else
	{
		if ($continuar == 1)
		{
			setcookie("MLO[nick]", $nick, time() + (86400 * 1), "/"); // 86400 = 1 day
			setcookie("MLO[senha]", $senha, time() + (86400 * 1), "/"); // 86400 = 1 day
		}
		else
		{
			setcookie("MLO[nick]", "", time()-3600, "/");
			setcookie("MLO[senha]", "", time()-3600, "/");
		}
		
		$query = "select cd_usuario, ic_tipo, ic_confirmado from tb_usuario where nm_nickname = '$nick'";
		$result = mysql_query($query) or die(mysql_error());
		$linha = mysql_fetch_assoc($result);
		
		$codigo = $linha['cd_usuario'];
		$tipo = $linha['ic_tipo'];
		$confirmado = $linha['ic_confirmado'];
		
		$_SESSION['MLO']['codigo'] = $codigo;
		$_SESSION['MLO']['nick'] = $nick;
		$_SESSION['MLO']['senha'] = $senha;
		$_SESSION['MLO']['tipo'] = $tipo;
		$_SESSION['MLO']['confirmado'] = $confirmado;
		
		$query = "update tb_usuario set ic_logado = 1, dt_ultima_atividade = now() where cd_usuario = '$codigo'";
		$result = mysql_query($query) or die(mysql_error());
		
		echo "<script> parent.LimparLogin(); parent.window.location = '../HomeUser.php'; </script>";
	}
?>

<?php
	mysql_close($conexao);
?>