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
set type=presets
if exist %type%list.txt del %type%list.txt
cd %type%
FOR /F "tokens=* USEBACKQ" %%F IN (`dir /b`) DO (
  SET var!count!=%%F
  SET /a count=!count!+1
)
set count=0




:goBack
IF NOT DEFINED var%count% exit

::name presets
set nameForPreset=!var%count%!
set nameForPreset=%nameForPreset:~0,-4%

::Get amount of lines
for /f "tokens=*" %%i in ('FINDSTR /R /N "^.*$" "!var%count%!" ^| FIND /C ":"') do set /a lines=%%i+1

::Set size for preset
FOR %%I in ( "!var%count%!" ) do set size=%%~zI
IF %SIZE% LEQ 1000 set fsize=%size%& set inSize= bytes
IF %SIZE% GTR 1000 set Size=%size:~0,-3%& set fSize=%size:~0,-3%.%size:~2%& set inSize=kb
IF %SIZE% GTR 1000 set Size=%size:~0,-3%& set fSize=%size:~0,-3%.%size:~2%& set inSize=mb
IF %SIZE% GTR 1000 set Size=%size:~0,-3%& set fSize=%size:~0,-3%.%size:~2%& set inSize=gb
IF %SIZE% GTR 1000 set Size=%size:~0,-3%& set fSize=%size:~0,-3%.%size:~2%& set inSize=tb

::Calculate spacing for nameForPreset to Size
echo.%nameForPreset%> tempfile.txt
FOR %%? IN (tempfile.txt) DO ( SET /A strlength=%%~z? - 2 )
del tempfile.txt
set /a spacing=30-%strlength%

::Calculate spacing for size to lines
echo.(%fsize%%insize%)        (%lines%)> tempfile.txt
FOR %%? IN (tempfile.txt) DO ( SET /A strlength=%%~z? - 2 )
del tempfile.txt
set /a spacing2=10-%strlength%
::write some shit
cd ..
echo.%nameForPreset% !echoSpacing%spacing%!                          (%fsize%%insize%)  !echoSpacing%spacing2%!     (%lines%)>> %type%list.txt
cd presets
set /a count=%count%+1
SET size=
SET free=
set fSize=
set inSize=
set nameForPreset=
goto goBack