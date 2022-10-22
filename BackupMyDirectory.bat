@echo off

cls
:: Sets the European Date Format Day_Month_Year
echo Date format = %date%
echo dd = %date:~0,2%
echo mm = %date:~3,2%
echo yyyy = %date:~6,8%
echo.
echo Timestamp = %date:~0,2%_%date:~3,2%_%date:~6,8%

:: Adds the date of when the script is executed after the name "Backup".
SET Dt=%date:~0,2%_%date:~3,2%_%date:~6,8%

:: Set the path to the directory with files that needs to be zipped for a backup.
SET SrcFolder=D:\MyFolder1\Myfolder2\BackupThisFolderWithFiles

:: Set the path to the directory where the zipped folder with files will be moved to, works with onedrive and dropbox. 
SET DestPath=C:\Users\SomeName\Dropbox\BackupsFolder

:: Set the path to the zipper and rename Backup to whatever you want or leave it.
"C:\Program Files\7-Zip\7z" a "%DestPath%\Backup.%Dt%.7z" "%SrcFolder%"