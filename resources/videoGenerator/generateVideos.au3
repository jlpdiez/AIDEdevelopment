#include <AutoItConstants.au3>
#include <ImageSearch.au3>

;*************************************
; HOTKEYS
;*************************************
HotKeySet('{F2}', 'quitScript')
;HotKeySet('{F3}', 'startRecording')
;HotKeySet('{F4}', 'stopRecordingExample')

;*************************************
; GLOBAL VARIABLES
;*************************************
;Const $consoleWinName = "C:\WINDOWS\SYSTEM32\cmd.exe"
Const $consolePath = "C:\Program Files\Git\git-bash.exe"
Const $consoleWinName = "MINGW64:/c/Users/eNDeR/Desktop/AIDEdevelopment"
Const $workingDir = "C:\Users\eNDeR\Desktop\AIDEdevelopment"
Const $recordPath = "C:\Program Files\CamStudio 2.7\Recorder.exe"
Const $recordWinName = "CamStudio"
Const $phatsimWinName = "PHATSIM"

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
showTooltip("Starting software")
;Open console at working directory
Global $winPID = Run($consolePath, $workingDir)
;Wait for it to open
WinWaitActive($consoleWinName)
;Launch CamStudio
launchRecordingSW()

;Set environment option not to have java compilation fail
;sendCommand("set JAVA_TOOL_OPTIONS = -Dfile.encoding=UTF8")
;sendCommand("echo %JAVA_TOOL_OPTIONS%")

;Cycle through folders
For $folderNum = 0 To $dirSize - 1
	showTooltip("Opening E" & $folderNum + 1)
	;Enter directory
	sendCommand("cd " & $dirs[$folderNum])
	;Compile
	showTooltip("Compiling E" & $folderNum + 1)
	;Flag not needed since dce614d - Check
	sendCommand("mvn clean compile -Dfile.encoding=UTF8")

	;Wait for build to end
	showTooltip("Waiting for E" & $folderNum + 1 & " to build successfuly")
	While Not searchImage('buildSuccess.png')
		Sleep(100)
	WEnd

	;Search folders & get commands
	$retunedCommands = getAntCommands($folderNum)
	;Cycle through simulations
	For $i = 0 To UBound($retunedCommands) - 1
		recordVideo($retunedCommands, $i, $folderNum)
	Next

	;Go up one level in directory structure
	Sleep(500)
	sendCommand("cd ..")
	Sleep(500)
Next

;Main sim+recording loop
Func recordVideo($commandList, $cmdIndex, $folderN)
	showTooltip("Starting E" & $folderN + 1 & " " & $commandList[$cmdIndex])
	;Run simulation
	sendCommand($commandList[$cmdIndex])
	;Wait to sim to start
	PixelSearch(500, 250, 1500, 750, 0x00FF00, 25)
	While @error
		Sleep(100)
		PixelSearch(500, 250, 1500, 750, 0x00FF00, 25)
	WEnd
	;Pause
	showTooltip("Pausing E" & $folderN + 1 & " " & $commandList[$cmdIndex])
	$yCoordButtons = calcYcoordButtons()
	MouseClick($MOUSE_CLICK_LEFT, 100, $yCoordButtons)
	;Reset size of video recording frame
	changeRecordingFrameSize()
	;Accelerate simulation -> 8 clicks equals 256x
	showTooltip("Accelerating E" & $folderN + 1 & " " & $commandList[$cmdIndex])
	MouseClick($MOUSE_CLICK_LEFT, 220, $yCoordButtons, 7)
	;Record
	showTooltip("Recording E" & $folderN + 1 & " " & $commandList[$cmdIndex])
	startRecording()
	;Restart
	;showTooltip("Restarting E" & $folderNum + 1 & " " & $retunedCommands[$i])
	MouseClick($MOUSE_CLICK_LEFT, 100, $yCoordButtons)
	MouseMove(@DesktopWidth, @DesktopHeight)
	;Wait for sim to finish
	;At 256 speed 00:00 is at 3m 31s => 211 seconds
	For $timeRemaining = 420 To 0 Step -1
		showTooltip("Recording E" & $folderN + 1 & " " & $commandList[$cmdIndex] & @CRLF & "Seconds left: " & $timeRemaining)
		;Exception catch
		If (WinExists("Error")) Then
			showTooltip("Recording failed!")
			;Kill java windows
			While ProcessExists("java.exe")
				ProcessClose("java.exe")
			WEnd
			stopRecording()
			;Re record
			recordVideo($commandList, $cmdIndex, $folderN)
			Return
		EndIf
		Sleep(1000)
	Next
	;Stop recording
	finishRecording($folderN + 1, $commandList[$cmdIndex])
	;Stop simulation
	showTooltip("Stopping E" & $folderN + 1 & " " & $commandList[$cmdIndex])
	WinActivate($consoleWinName)
	WinWaitActive($consoleWinName)
	Sleep(100)
	Send("^c")
EndFunc

;Calcs y coordinate for PHATSIM buttons depending on window size
;Two cases detected: With two agents window height is 849 and with three of them it's 889
Func calcYcoordButtons()
	;[CLASS:LWJGL; INSTANCE:1]
	$winPosition = WinGetPos($phatsimWinName)
	If ($winPosition[3] == 849) Then
		return 50
	Else
		return 70
	EndIf
EndFunc

;*************************************
; AUXILIARY FUNCTIONS
;*************************************
;Exits the program
Func quitScript()
	showTooltip("Killing processes and exiting program")
	;Close java as it sometimes bugs itself
	While ProcessExists("java.exe")
		ProcessClose("java.exe")
	WEnd
	WinClose($consoleWinName)
	stopRecording()
	Exit
EndFunc

;Types into console input command + "Enter" key
Func sendCommand($cmd)
	WinActivate($consoleWinName)
	WinWaitActive($consoleWinName)
	SendKeepActive($winPID)
	Send($cmd)
	Send("{ENTER}")
EndFunc

;Searchs for a given image and returns true or false
Func searchImage($img)
	Local $x, $y
	Return _ImageSearch($img, 1, $x, $y, 100)
EndFunc

;Tooltip helper function
Func showTooltip($message, $title = ".::[ PHATSIM AutoRecorder ]::.")
	ToolTip($message, @DesktopWidth - 250, @DesktopHeight - 150, $title, $TIP_NOICON, $TIP_BALLOON)
EndFunc

;*************************************
; FILESYSTEM FUNCTIONS
;*************************************
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
EndFunc

;*************************************
; RECORDING FUNCTIONS
;*************************************
;CamStudio must be set to record a fixed region:
;Left 10, Top 0, Width 1227, Height 841
;Keyboard shortcurts must be as follow:
;Record key: Ctrl+Alt+R
;Stop key: Ctrl+Alt+P
Func launchRecordingSW()
	;Run SW if needed, bring to focus otherwise
	If Not ProcessExists("Recorder.exe") Then
		Run($recordPath)
	Else
		WinActivate($recordWinName)
	EndIf
	WinWaitActive($recordWinName)
	Local $winPos = WinGetPos($recordWinName)
	MouseClickDrag($MOUSE_CLICK_LEFT, $winPos[0], $winPos[1], @DesktopWidth - 350, $winPos[1])
EndFunc

;Changes recording frame height depending on PHATSIMs window size
Func changeRecordingFrameSize()
	WinActivate($recordWinName)
	WinWaitActive($recordWinName)
	;Open "region" menu
	Send("!r")
	;Open "Fixed Region" window
	Send("f")
	;Three tabs make us edit height parameter
	Send("{TAB}{TAB}{TAB}")
	;Set new height
	$winPosition = WinGetPos($phatsimWinName)
	$toSend = $winPosition[3] - 8
	Send($toSend)
	;Enter to set parameters
	Send("{ENTER}")
EndFunc

Func startRecording()
	Send("^!r")
EndFunc

;Stop recording and cancel save
Func stopRecording()
	Send("^!p")
	Sleep(1000)
	If (WinExists("Save AVI File")) Then
		WinWaitActive("Save AVI File")
		Send("{ESC}")
	EndIf
EndFunc

Func finishRecording($folderNum, ByRef $simName)
	Local $dialogWinName = "Save AVI File"
	Send("^!p")
	;WinActivate($dialogWinName)
	WinWaitActive($dialogWinName)
	Send("E" & $folderNum & "-" & $simName)
	Sleep(500)
	Send("{ENTER}")
EndFunc