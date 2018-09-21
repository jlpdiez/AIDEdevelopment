#include <AutoItConstants.au3>
;#include <MsgBoxConstants.au3>
#include <ImageSearch.au3>

;*************************************
; HOTKEYS
;*************************************
HotKeySet('{F2}', 'quitScript')
HotKeySet('{F3}', 'record')
HotKeySet('{F4}', 'getNumberOfInterviews')

;*************************************
; GLOBAL VARIABLES
;*************************************
Const $winName = "C:\WINDOWS\SYSTEM32\cmd.exe"
Const $workingDir = "C:\Users\Jlperez\Documents\GitHub\AIDEdevelopment"

Global $dirSize = getNumberOfInterviews()
;Assign directory names
Global $dirs[$dirSize]
;Assigns proper names to directory list
For $i = 0 To $dirSize - 1
	$dirs[$i] = "e" & $i + 1 & "interview"
Next

;*************************************
; MAIN PROGRAM LOGIC
;*************************************
;Open console at working directory
Global $winPID = Run("cmd", $workingDir)
;Wait for it to open
WinWaitActive($winName)

;Set environment option not to have java compilation fail
;sendCommand("set JAVA_TOOL_OPTIONS = -Dfile.encoding=UTF8")
;sendCommand("echo %JAVA_TOOL_OPTIONS%")

;Cycle through folders
For $folderNum = 0 To $dirSize - 1
	;Enter directory
	;sendCommand("cd " & $dirs[$folderNum])
	;Compile
	;sendCommand("mvn clean compile -Dfile.encoding=UTF8")

	;Wait for build to end
	;While Not searchImage('buildSuccess.png')
		Sleep(500)
	;WEnd

	;Search folders & get commands
	;$retunedCommands = getAntCommands($folderNum)
	;Cycle through simulations
	;For $i = 0 To UBound($retunedCommands) - 1
		;Run simulation
		;sendCommand($retunedCommands[$i])
		;Wait
		;Sleep(60000)
		;Accelerate simulation
		;Record
		;Stop simulation
	;Next

	;Go up one level in directory structure
	sendCommand("cd..")
Next

;*************************************
; AUXILIARY FUNCTIONS
;*************************************
;Exits the program
Func quitScript()
	WinClose($winName)
	Exit
EndFunc

;Types into console input command + "Enter" key
Func sendCommand($cmd)
	SendKeepActive($winPID)
	Send($cmd)
	Send("{ENTER}")
EndFunc

;Searchs for a given image and returns true or false
Func searchImage($img)
	Local $x, $y
	Return _ImageSearch($img, 1, $x, $y, 0)
EndFunc

;Searchs working directory for interviews and returns the number of them found
Func getNumberOfInterviews()
	Local $counter = 0
	;Assign a Local variable the search handle of all files in the current directory.
	Local $hSearch = FileFindFirstFile($workingDir & "\e*interview")
    ; Check if the search was successful
    If $hSearch = -1 Then
        Return 0
    EndIf

    While 1
		FileFindNextFile($hSearch)
        ; If there is no more file matching the search.
        If @error Then
			ExitLoop
		Else
			$counter += 1
		EndIf
    WEnd
	FileClose($hSearch)
	Return $counter
EndFunc

;Returns an array with the commands needed to execute the simulations
Func getAntCommands(ByRef $simNum)
	Local $fileNames[15]
	Local $fullRoute = $workingDir & "\" & $dirs[$simNum] & "\target\classes\phat\sim\*Record.java"
	;Assign a Local variable the search handle of all files in the current directory.
	Local $hSearch = FileFindFirstFile($fullRoute)
    ; Check if the search was successful
    If $hSearch = -1 Then
        Return -1
    EndIf
	Local $i = 0
    While 1
		$fileNames[$i] = FileFindNextFile($hSearch)
        ; If there is no more file matching the search.
        If @error Then
			ExitLoop
		Else
			$i += 1
		EndIf
    WEnd
    ; Close the search handle.
    FileClose($hSearch)

	;Prepare arrays for returning them with the appropriate size
	Local $length = 0
	Local $stop = False
	While Not $stop
		If $fileNames[$length] <> "" Then
			$length += 1
		Else
			$stop = True
		EndIf
	WEnd
	;ToolTip("Sim: " & $simNum & " | Length: " & $length, 50, 50, "NumSims", 4)
	;Sleep(2500)
	Local $commandNames[$length]
	For $i = 0 To $length - 1
		$commandNames[$i] = $fileNames[$i]
		;Transforms "MainSimNamePHATSimulationNoDevicesRecord.java" to "ant runSimName"
		$commandNames[$i] = StringReplace($commandNames[$i], "PHATSimulationNoDevicesRecord.java", "")
		$commandNames[$i] = StringReplace($commandNames[$i], "Main", "ant run")
	Next

	Return $commandNames
	;mvn exec:java -Dexec.mainClass=phat.sim.MainSimDisorientPHATSimulationNoDevicesRecord
EndFunc

Func record()
	Local $swPath = "C:\Program Files\CamStudio 2.7\Recorder.exe"
	Local $swName = "CamStudio"
	;Run SW if needed, bring to focus otherwise
	If Not ProcessExists("Recorder.exe") Then
		Run($swPath)
	Else
		WinActivate($swName)
	EndIf

	WinWaitActive($swName)
	startRecording()
EndFunc

;PHATSIM Window size:
;width = 1233
;height = 810
Func startRecording()
	Send("^!r")
EndFunc

Func stopRecording()
	Send("^!r")
EndFunc
