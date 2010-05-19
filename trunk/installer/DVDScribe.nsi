;Include modern UI
!include "MUI2.nsh"

;Request application privileges for Windows Vista
RequestExecutionLevel admin

;Variables
Var StartMenuFolder

;Macro for license
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "..\doc\license.txt"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_STARTMENU Application $StartMenuFolder

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

;Name and file 
Name "LabelCreator"
OutFile "LabelCreatorSetup.exe"

;Default install location
InstallDir $ProgramFiles\LabelCreator

;Languages
!insertmacro MUI_LANGUAGE "Spanish"
!insertmacro MUI_LANGUAGE "English"

Function .onInit
  System::Call 'kernel32::CreateMutexA(i 0, i 0, t "LabelCreatorInstaller") ?e'
  Pop $R0
  StrCmp $R0 0 +3
	MessageBox MB_OK "The installer is already running."
	Abort
FunctionEnd	

Function un.onInit
  FindWindow $0 "WindowsForms10.Window.8.app.0.33c0d9d" "Label Creator"
  StrCmp $0 0 Remove
    MessageBox MB_ICONSTOP|MB_OK "It appears that Label Creator is currently open.$\n\
                                  Close it and restart uninstaller."
    Quit
Remove:
FunctionEnd
 
Section
	setOutPath $INSTDIR
	file ..\DVDScribe\bin\Release\LabelCreator.exe
	file ..\DVDScribe\bin\Release\ExpTreeLib.dll
	file ..\DVDScribe\bin\Release\ICSharpCode.SharpZipLib.dll
	file ..\doc\ReadMe.txt
	file ..\doc\license.txt
	file ..\doc\ReleaseNotes.txt

	setOutPath $INSTDIR\Backgrounds

	file ..\DVDScribe\bin\Release\Backgrounds\1.jpg
	file ..\DVDScribe\bin\Release\Backgrounds\2.jpg

	writeUninstaller $INSTDIR\Uninstall.exe

	CreateDirectory "$SMPROGRAMS\LabelCreator"

	createShortCut "$SMPROGRAMS\LabelCreator\LabelCreator.lnk" "$INSTDIR\LabelCreator.exe"
	createShortCut "$SMPROGRAMS\LabelCreator\Readme.lnk" "$INSTDIR\ReadMe.txt"
	createShortCut "$SMPROGRAMS\LabelCreator\Uninstall.lnk" "$INSTDIR\Uninstall.exe"

SectionEnd
	
Section "Uninstall"
	delete $INSTDIR\Uninstall.exe
	delete $INSTDIR\LabelCreator.exe
	delete $INSTDIR\ExpTreeLib.dll
	delete $INSTDIR\ReadMe.txt
	delete $INSTDIR\license.txt
	delete $INSTDIR\ReleaseNotes.txt
	delete $INSTDIR\ICSharpCode.SharpZipLib.dll

	delete $INSTDIR\Backgrounds\1.jpg
	delete $INSTDIR\Backgrounds\2.jpg

	RMDir  $INSTDIR\Backgrounds		
	RMDir  $INSTDIR		

	!insertmacro MUI_STARTMENU_GETFOLDER Application $StartMenuFolder

	delete "$SMPROGRAMS\LabelCreator\LabelCreator.lnk"
	delete "$SMPROGRAMS\LabelCreator\Readme.lnk"
	delete "$SMPROGRAMS\LabelCreator\Uninstall.lnk"
	RMDIR  "$SMPROGRAMS\LabelCreator"
SectionEnd