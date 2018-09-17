#include <AutoItConstants.au3>

;Variables
Const $winName = "C:\Windows\SYSTEM32\cmd.exe"
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
sendCommand("set JAVA_TOOL_OPTIONS = -Dfile.encoding=UTF8")
sendCommand("set ANT_OPTS = -Dfile.encoding=UTF8")

;Cycle through folders
For $i = 0 To $dirSize - 1
	sendCommand("cd " & $dirs[$i])
	sendCommand("mvn clean compile -Dfile.encoding=UTF8")
	;Wait for maven to finish compiling
	While WinGetTitle($winPID) <> $winName
		Sleep(100)
	WEnd
	;Sleep(1000)
	sendCommand("cd..")
Next

;Close window
Sleep(2500)
WinClose($winPID)

;Types in input command + "Enter" key
Func sendCommand($cmd)
	SendKeepActive($winPID)
	Send($cmd)
	Send("{ENTER}")
EndFunc