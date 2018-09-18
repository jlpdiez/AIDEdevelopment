#include <AutoItConstants.au3>
#include <ImageSearch.au3>

;Assign hotkeys
HotKeySet('{F2}', 'quitScript')
HotKeySet('{F3}', 'searchBuildSuccess')

;Variables
Const $winName = "C:\WINDOWS\SYSTEM32\cmd.exe"
Const $workingDir = "C:\Users\Jlperez\Documents\GitHub\AIDEdevelopment"
Const $dirSize = 7
;Assign directory names
Local $dirs[$dirSize]
For $i = 0 To $dirSize - 1
	$dirs[$i] = "e" & $i + 1 & "interview"
Next

;Open console at working directory
Local $winPID = Run("cmd", $workingDir)

Local $passwd = "1qaz2wsx"
;Local $winPID = RunAs("jlperez", @ComputerName, $passwd, $RUN_LOGON_PROFILE, "cmd", $workingDir, @SW_SHOWDEFAULT)
WinWaitActive($winName)

;Set environment option not to have java compilation fail
;sendCommand("set JAVA_TOOL_OPTIONS = -Dfile.encoding=UTF8")
;sendCommand("echo %JAVA_TOOL_OPTIONS%")

;Cycle through folders
For $i = 0 To $dirSize - 1
	;Enter directory
	sendCommand("cd " & $dirs[$i])
	;Compile
	sendCommand("mvn clean compile -Dfile.encoding=UTF8")

	;Wait for build to end
	While Not searchImage('buildSuccess.png')
		Sleep(500)
	WEnd

	;Go up one level in directory structure
	sendCommand("cd..")
Next

;Types into console input command + "Enter" key
Func sendCommand($cmd)
	SendKeepActive($winPID)
	Send($cmd)
	Send("{ENTER}")
EndFunc

Func searchImage($img)
	$x = @DesktopWidth
	$y = @DesktopHeight
	Local $pos
	return _ImageSearch($img, $pos, $x, $y, 0)
	;Func _ImageSearch($findImage, $resultPosition, ByRef $x, ByRef $y, $tolerance)
EndFunc

;TEMP
Func searchBuildSuccess()
	$success = searchImage('buildSuccess.png')
	If $success Then
		ToolTip("Found!", 820, 0, "FOUND")
	Else
		ToolTip("Not Found!", 820, 0, "ERROR")
	EndIf
EndFunc

;Exit the program
Func quitScript()
	WinClose($winName)
	Exit
EndFunc