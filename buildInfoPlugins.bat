@echo off
set echospacing1= 
set echospacing2=  
set echospacing3=   
set echospacing4=    
set echospacing5=     
set echospacing6=      
set echospacing7=       
set echospacing8=        
set echospacing9=         
set echospacing10=          
set echospacing11=           
set echospacing12=            
set echospacing13=             
set echospacing14=              
set echospacing15=               
set echospacing16=                
set echospacing17=                 
set echospacing18=                  
set echospacing19=                   
set echospacing20=                    
set echospacing21=                     
set echospacing22=                      
set echospacing23=                        
set count=0
setlocal enabledelayedexpansion
set type=plugins
if exist %type%list.txt del %type%list.txt
cd %type%


FOR /F "tokens=* USEBACKQ" %%F IN (`dir /b`) DO (
  SET var!count!=%%F
  SET /a count=!count!+1
)
set count=0


:goBack
if "!var%count%!" == "" exit
::GET INFO ABOUT PACKAGE-DB
cd "!var%count%!"
for /f "tokens=1,2 delims==" %%G in (package-db.txt) do set %%G=%%H

cd file
::GET FILE SIZE
FOR /f "tokens=3" %%a IN ('dir /s /-d /-c') DO (
    SET size=!free!
    SET free=%%a
)
cd ..

::CONVERT SIZE
IF %SIZE% LEQ 1000 set fsize=%size%& set inSize= bytes
IF %SIZE% GTR 1000 set Size=%size:~0,-3%& set fSize=%size:~0,-3%.%size:~2%& set inSize=kb
IF %SIZE% GTR 1000 set Size=%size:~0,-3%& set fSize=%size:~0,-3%.%size:~2%& set inSize=mb
IF %SIZE% GTR 1000 set Size=%size:~0,-3%& set fSize=%size:~0,-3%.%size:~2%& set inSize=gb
IF %SIZE% GTR 1000 set Size=%size:~0,-3%& set fSize=%size:~0,-3%.%size:~2%& set inSize=tb

::Calcuate spacing for name to size
echo.%name% -- %version%> tempfile.txt
FOR %%? IN (tempfile.txt) DO ( SET /A strlength=%%~z? - 2 )
del tempfile.txt
set /a spacing=30-%strlength%

cd ..
cd ..
echo.%name% !echoSpacing%spacing%!                                 (%fsize%%insize%)>> %type%List.txt
cd %type%
set /a count=%count%+1
SET size=& SET free=& set fSize=& set inSize=
goto goBack