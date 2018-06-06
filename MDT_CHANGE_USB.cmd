@echo off

cls
rem creation des fichiers
set MDTLogs=%systemdrive%\Windows\Temp\MDT000
mkdir %MDTLogs% 
echo 1. Begin management of MDTBoot USB Drive > %MDTLogs%\MDTFichierLog.txt
echo. >> %MDTLogs%\MDTFichierLog.txt
echo. > %MDTLogs%\ChangeVolume.tmp


rem preparation de la commande liste
echo list volume > %MDTLogs%\ListerVolume.tmp
 diskpart /s %MDTLogs%\ListerVolume.tmp > %MDTLogs%\ListerVolume2.tmp
 diskpart /s %MDTLogs%\ListerVolume.tmp >> %MDTLogs%\MDTFichierLog.txt

rem detection du volume USB
for /f "tokens=2-4" %%a in (%MDTLogs%\ListerVolume2.tmp) do @IF %%c EQU MDTBoot @SET volume=%%a 


 echo 2. Identification du volume ‘MDTBoot’ >> %MDTLogs%\MDTFichierLog.txt

 echo. >> %MDTLogs%\MDTFichierLog.txt

  IF DEFINED volume echo select volume %volume% >> %MDTLogs%\SlectionerVolume.tmp
  IF DEFINED volume echo select volume %volume% >> %MDTLogs%\MDTFichierLog.txt
  IF DEFINED volume echo assign letter=I: >> %MDTLogs%\SlectionerVolume.tmp
  IF DEFINED volume echo assign letter=I: >> %MDTLogs%\MDTFichierLog.txt
  IF DEFINED volume echo. >> %MDTLogs%\MDTFichierLog.txt
  IF DEFINED volume echo 3. Changed MDTBoot Removable assignment drive to K >> %MDTLogs%\MDTFichierLog.txt

 diskpart /s %MDTLogs%\SlectionerVolume.tmp

 echo. >> %MDTLogs%\MDTFichierLog.txt
 echo 4. volume List post reassignment… >> %MDTLogs%\MDTFichierLog.txt
 diskpart /s %MDTLogs%\ListDrives.tmp >> %MDTLogs%\MDTFichierLog.txt

 echo. >> %MDTLogs%\MDTFichierLog.txt
 echo 5. Fin ... >> %MDTLogs%\MDTFichierLog.txt

exit /b 0
