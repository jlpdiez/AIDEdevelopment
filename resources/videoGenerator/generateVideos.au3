#include <AutoItConstants.au3>
#include <MsgBoxConstants.au3>
#include <ImageSearch.au3>

;Assign hotkeys
HotKeySet('{F2}', 'quitScript')
HotKeySet('{F3}', 'getSimNames')

;Variables
Const $winName = "C:\WINDOWS\SYSTEM32\cmd.exe"
Const $workingDir = "C:\Users\Jlperez\Documents\GitHub\AIDEdevelopment"
Const $dirSize = 7
;Assign directory names
Global $dirs[$dirSize]
For $i = 0 To $dirSize - 1
	$dirs[$i] = "e" & $i + 1 & "interview"
Next

;Open console at working directory
Global $winPID = Run("cmd", $workingDir)
;Wait for it to open
WinWaitActive($winName)

;Set environment option not to have java compilation fail
;sendCommand("set JAVA_TOOL_OPTIONS = -Dfile.encoding=UTF8")
;sendCommand("echo %JAVA_TOOL_OPTIONS%")

;Cycle through folders
For $i = 0 To $dirSize - 1
	;Enter directory
	;sendCommand("cd " & $dirs[$i])
	;Compile
	;sendCommand("mvn clean compile -Dfile.encoding=UTF8")

	;Wait for build to end
	;While Not searchImage('buildSuccess.png')
		Sleep(500)
	;WEnd

	;Go up one level in directory structure
	;sendCommand("cd..")
Next

;Types into console input command + "Enter" key
Func sendCommand($cmd)
	SendKeepActive($winPID)
	Send($cmd)
	Send("{ENTER}")
EndFunc

Func searchImage($img)
	Local $x
	Local $y
	;Get coords & size of window
	Local $winPos = WinGetPos($winName)
	;_ImageSearchArea(imageToSearch, xIni, yIni, xSize, ySize, returnedXcoord, returnedYcoord, tolerance)
	;Return _ImageSearchArea($img, 1, $winPos[0], $winPos[1], $winPos[2], $winPos[3], $x, $y, 25)
	Return _ImageSearch($img, 1, $x, $y, 0)
EndFunc

Func getSimNames()
	Local $routeToSims = "\target\classes\phat\sim\*Record.java"
	Local $fullRoute = $workingDir & "\" & $dirs[0] & $routeToSims

	;Assign a Local variable the search handle of all files in the current directory.
	Local $hSearch = FileFindFirstFile($fullRoute)

    ; Check if the search was successful, if not display a message and return False.
    If $hSearch = -1 Then
        MsgBox($MB_SYSTEMMODAL, "", "Error: No files/directories matched the search pattern.")
        Return False
    EndIf

    ; Assign a Local variable the empty string which will contain the files names found.
    Local $sFileName = "", $iResult = 0
	Local $fileNames[15]
	Local $i = 0
    While 1
        $sFileName = FileFindNextFile($hSearch)
		$fileNames[$i] = $sFileName
        ; If there is no more file matching the search.
        If @error Then ExitLoop

        ; Display the file name.
        $iResult = MsgBox(BitOR($MB_SYSTEMMODAL, $MB_OKCANCEL), "", "File: " & $sFileName)
        If $iResult <> $IDOK Then ExitLoop ; If the user clicks on the cancel/close button.

		$i += 1
    WEnd

    ; Close the search handle.
    FileClose($hSearch)

	;Gets a list of files and transforms them to ant commands to run the simulations
	;Transforms "MainSimNamePHATSimulationNoDevicesRecord.java" to "ant runSimName"
	For $i = 0 To UBound($dirs) - 1
		$fileNames[$i] = StringReplace($fileNames[$i], "PHATSimulationNoDevicesRecord.java", "")
		$fileNames[$i] = StringReplace($fileNames[$i], "Main", "ant run")
	Next

	$iResult = MsgBox(BitOR($MB_SYSTEMMODAL, $MB_OKCANCEL), "", "File: " & $fileNames[0] & " | " & $fileNames[1] & " | " & $fileNames[2] )
	;mvn exec:java -Dexec.mainClass=phat.sim.MainSimDisorientPHATSimulationNoDevicesRecord
EndFunc

;Exit the program
Func quitScript()
	WinClose($winName)
	Exit
EndFunc