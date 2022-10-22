@echo off

:: make sure to change the settings from line 8-13

:: Database Connection

:: Put Database Username.
set dbUser=UserName
:: Put Database User Password.
set dbPassword="Password"
:: Put the desired directory, can work with onedrive and dropbox.
set backupDir="C:\Users\SomeName\SomeDirectory"
:: Put the desired dumper, can be MySQL 5.7 or newer can also be MariaDB, no knowledge if PostGreSQL works. 
set mysqldump="C:\Program Files\MariaDB 10.6\bin\mariadb-dump.exe"
:: Put the data folder, can be in xampp or wampp as well.
set mysqlDataDir="C:\Program Files\MariaDB 10.6\data"
:: Put the Zipper path.
set zip="C:\Program Files\7-Zip\7z.exe"

cls

:: European Date format Day_Month_Year

echo Date format = %date%
echo dd = %date:~0,2%
echo mm = %date:~3,2%
echo yyyy = %date:~6,8%
echo.
echo Timestamp = %date:~0,2%_%date:~3,2%_%date:~6,8%

set Dt=%date:~0,2%_%date:~3,2%_%date:~6,8%
:: Sets the name of the folder to the day of executing the script.
set dirName=%date:~0,2%_%date:~3,2%_%date:~6,8%
:: Sets the date in front of the file ex; filename is mywork, it will be changed to 22_10_2022_mywork.
set fileSuffix=%date:~0,2%_%date:~3,2%_%date:~6,8%

echo "dirName"="%dirName%"
:: switch to the "data" folder
pushd "%mysqlDataDir%"
:: create backup folder if it doesn't exist
if not exist %backupDir%\%dirName%\   mkdir %backupDir%\%dirName%

:: Iterate over the folder structure in the "data" folder to get the databases
for /d %%f in (*) do (
	:: You can change NameOfDatabaseToBackup to %%f to backup all databases.
	echo processing folder "NameOfDatabaseToBackup"

	%mysqldump% --host="localhost" --user=%dbUser% --password=%dbPassword% --single-transaction --add-drop-table --databases NameOfDatabaseToBackup > %backupDir%\%dirName%\NameOfDatabaseToBackup.sql
	%zip% a -tgzip %backupDir%\%dirName%\%fileSuffix%_NameOfDatabaseToBackup.sql.gz %backupDir%\%dirName%\NameOfDatabaseToBackup.sql
	:: You can comment this if you want to keep both .zip and .sql files, either if not commented it will just delete .sql once zipped.
	del %backupDir%\%dirName%\%%f.sql
)
popd