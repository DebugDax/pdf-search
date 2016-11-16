#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <String.au3>
#include <Array.au3>
#include <File.au3>

FileInstall(".\pdftotext.exe", @TempDir & "\pdftotext.exe", 1)

$path = FileSelectFolder("Select Folder Containing PDF's", "")
$search = FileFindFirstFile ( $path & "\*.pdf") ;  "g:\test\*.pdf"
$_pdftotextPath = @TempDir & "\pdftotext.exe"
$_OutPutFilepath = @TempDir & "\file.txt"
$_StringToFind = InputBox("PDF Search", "Enter the text you are looking for:")
if not @error and StringLen($_StringToFind) > 0 Then
if not FileExists($_pdftotextPath) Then
	msgbox(16, "Error", "Missing pdftotext utility!")
	Exit
EndIf

SplashTextOn("PDF Search", "Searching...", 250, 70, 0, 0, 16)

While 1
    $file = FileFindNextFile ( $search )
    If @error Then ExitLoop
    ConsoleWrite ( '-->-- $file : ' & $file & @CRLF )
	ControlSetText("PDF Search", "", "Static1", "Searching..." & @CRLF & $file)
    RunWait ($_pdftotextPath & ' "' & $path & '\' & $file & '" ' & $_OutPutFilepath, 'C:\', @SW_HIDE )
    $f = FileOpen($_OutPutFilepath, 0)
	$fdata = FileRead($f)
	FileClose($f)
	if StringInStr($fdata, $_StringToFind) > 0 Then
		msgbox(64, "PDF Search", $_StringToFind & " found in " & $file)
		FileClose ( $search )
		;FileDelete ( $_OutPutFilepath )
		;Exit
	EndIf
    FileDelete ( $_OutPutFilepath )
WEnd
FileClose ( $search )
Else
	Exit
EndIf