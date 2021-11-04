;#############################################################
;#                                                           #
;# Desenvolvido por: Ricardo de Oliveira Soares              #
;#                   Técnico Judiciário                      #
;#                   Vara do Trabalho de Lorena/SP           #
;#                                                           #
;# E-mail:           ricardosoares@trt15.jus.br              #
;# Telefone:         (12) 3153-2732                          #
;#                                                           #
;#############################################################

;*************************************************************
;**********        CONFIGURAÇÕES INICIAIS        *************
;*************************************************************

#NoEnv                                     ;-> Previne que variáveis vazias sejam vistas como potenciais variáveis de sistema (esta instrução também está presente no arquivo "Webapp.ahk", importado logo abaixo)
#Persistent                                ;-> Mantém o script rodando permanentemente
#SingleInstance, force                     ;-> Impede que mais de uma instância do mesmo script seja rodada simultaneamente. Opções disponíveis: [force|ignore|off]
;#NoTrayIcon

SendMode, Input                            ;-> Promove envio imediato dos comandos
SetBatchLines, -1                          ;-> Mantém o script rodando em velocidade máxima
SetWorkingDir, %A_ScriptDir%               ;-> Especifica o diretório do script como pasta de trabalho (esta instrução também está presente no arquivo "Webapp.ahk", importado logo abaixo)
SetTitleMatchMode, 2                       ;-> Define correspondência parcial de título para identificação de janela

NomeDoPrograma     := RegExReplace(A_ScriptName, "(?:\.ahk|\.exe)", "")
NomeDeUsuario      := A_UserName
SistemaOperacional := A_OSVersion

;*************************************************************
;**********       OBSERVAÇÕES IMPORTANTES        *************
;*************************************************************

/*
Arquivo de configurações do projeto: "webapp.json"

name: texto exibido na barra de título. Pode ser alterado em tempo de execução através da função "setAppName()"
width e height: largura e altura de início da janela da aplicação
protocol: opção utilizada para filtrar prefixos de URL's para, por exemplo, executar uma função quando um link como "app://msgbox/hello" é clicado
protocol_call: nome da função que será chamada no AutoHotkey. Se não for fornecido, o valor padrão é "app_call()"
html_url: é o arquivo inicial HTML da aplicação. Se não for fornecido, o valor padrão é "index.html"
NavComplete_call: nome da função que será chamada no AutoHotkey quando a página terminar de carregar. O primeiro argumento é a URL da nova página. Se não for fornecido, o valor padrão é "app_page()"
Nav_sounds: parâmetro booleano opcional. Se não for fornecido, o valor padrão é "false". Correspondem aos sons feitos pelo IE durante a navegação, como o som de "clique"
fullscreen: parâmetro booleano opcional. Se não for fornecido, o valor padrão é "false". Define se o aplicativo deve iniciar em tela cheia ou numa janela do tamanho especificado (largura e altura)
DPI_Aware: parâmetro booleano opcional. Se não for fornecido, o valor padrão é "true". Define se o aplicativo deve fazer a correção automática do nível de zoom com base no DPI do sistema
ZoomLevel: é a escala percentual com a qual o aplicativo será iniciado (por exemplo, especifique 200 para escala de 200%). Se não for fornecido, o valor padrão é "100"
AllowZoomLevelChange: parâmetro booleano opcional. Se não for fornecido, o valor padrão é "true". Define se o aplicativo deve permitir que os usuários alterem o nível de zoom com Ctrl +/- ou Ctrl e roda do mouse para cima / baixo

EXEMPLO
- Se o protocolo for configurado como "myapp", a função "protocol_call" será chamada quando um link "myapp://test/1234" for clicado
e receberá "test/1234" como seu primeiro argumento.
- Se o protocolo for configurado como "*", a função "protocol_call" será chamada quando QUALQUER link for clicado
e receberá "myapp://test/1234" (a URL completa) como seu primeiro argumento.
Isso não é recomendado na maioria dos casos, uma vez que links com o parâmetro href="#" também serão disparados (geralmente um comportamento indesejado).
*/

;*************************************************************
;**********          INÍCIO DA EXECUÇÃO          *************
;*************************************************************

#Include lib\Webapp.ahk
#Include lib\JSON_ToObj.ahk
__Webapp_AppStart:

;*************************************************************
;**********       OBTÉM O OBJETO DOM HTML        *************
;*************************************************************

iWebCtrl := getDOM()

;*************************************************************
;**********      ALTERA O NOME DA APLICAÇÃO      *************
;**********         EM TEMPO DE EXECUÇÃO         *************
;*************************************************************

setAppName("Funções úteis")
return

;*************************************************************
;**********         HOTKEYS ATIVADOS NO          *************
;**********        CONTEXTO DA APLICAÇÃO         *************
;*************************************************************

#IfWinActive, ahk_group __Webapp_windows
!Enter::                                         ;-> Alt + Enter
	;!toggle
	setFullscreen(!__Webapp_FullScreen)
return
#IfWinActive

;*************************************************************
;**********       MANIPULADORES DE EVENTO        *************
;**********         DE PROTOCOLO DE URL          *************
;*************************************************************
;**********     PARAMÊTRO "protocol_call" DO     *************
;**********     ARQUIVO DE CONFIGURAÇÕES DO      *************
;**********       PROJETO ("webapp.json")        *************
;*************************************************************

app_call(args) {
	MsgBox % "Argumento da função ""app_call"":" . "`n" . args
	if InStr(args,"msgbox/hello")
		MsgBox, % "Olá, mundo!"
	else if InStr(args, "soundplay/ding")
		SoundPlay, %A_WinDir%\Media\ding.wav
	return
}

;*************************************************************
;**********     FUNÇÃO AHK CHAMADA QUANDO A      *************
;**********     PÁGINA TERMINAR DE CARREGAR      *************
;*************************************************************
;**********   PARAMÊTRO "NavComplete_call" DO    *************
;**********     ARQUIVO DE CONFIGURAÇÕES DO      *************
;**********       PROJETO ("webapp.json")        *************
;*************************************************************

app_page(NewURL) {
	wb := getDOM()
	
	setZoomLevel(100)
	
	if InStr(NewURL, "index.html") {
		disp_info()
	}
	return
}

disp_info() {
	wb := getDOM()
	Sleep, 10
	x := wb.document.getElementById("ahk_info")
	x.innerHTML := "<i>Esta aplicação está sendo executada com " . GetAHK_EnvInfo() . ".</i>"
	return
}

;*************************************************************
;********** FUNÇÕES CHAMADAS VIA HTML/JAVASCRIPT *************
;*************************************************************

AbrirPastaDeTrabalho() {
	Run, % "E:\MEGA\Trabalho"
	return
}

AbrirPastaModelosDeDocumentos() {
	Run, % "E:\MEGA\Trabalho\Modelos de documentos"
	return
}

AbrirDespachos() {
	Run, % "E:\MEGA\Trabalho\Despachos Rick.docx"
	return
}

Hello() {
	MsgBox, % "Olá, mensagem de Javascript-AutoHotKey."
	return
}

RunMyJSFunction() {
	window := getWindow()
	window.myFunction()           ;-> Executa uma função em Javascript chamada "myFunction()"
	return
}

Run(t) {
	Run, %t%
	return
}

GetAHK_EnvInfo(){
	return "AutoHotkey v" . A_AhkVersion . " " . (A_IsUnicode ? "Unicode" : "ANSI") . " " . (A_PtrSize * 8) . "-bit"
}

multiply_ahk(a,b) {
	;MsgBox % a " * " b " = " a*b
	return a * b
}

MyButton1() {
	wb := getDOM()
	MsgBox % wb.Document.getElementById("MyTextBox").Value
	return
}

MyButton2() {
	wb := getDOM()
	FormatTime, TimeString, %A_Now%, dddd MMMM d, yyyy HH:mm:ss
    Random, x, %min%, %max%
	data := "AHK Version " A_AhkVersion " - " (A_IsUnicode ? "Unicode" : "Ansi") " " (A_PtrSize == 4 ? "32" : "64") "bit`nCurrent time: " TimeString "`nRandom number: " x
	wb.Document.getElementById("MyTextBox").value := data
	return
}