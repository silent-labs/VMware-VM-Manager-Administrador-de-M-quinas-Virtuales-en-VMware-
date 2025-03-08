@echo off
setlocal enabledelayedexpansion

:: ============================================================
:: Configuracion: Seleccionar ruta de VMware (vmrun.exe)
:: ============================================================
set "defaultVMRun=C:\Program Files (x86)\VMware\VMware Workstation\vmrun.exe"
:CONFIG_VMWARE
cls
echo ============================================================
echo Configuracion: Ruta de VMware Workstation (vmrun.exe)
echo ============================================================
echo Ingrese la ruta completa donde se encuentra instalado VMware Workstation.
echo Presione Enter para usar la ruta por defecto: %defaultVMRun%
set /p vmrunPath="Ruta: "
if "%vmrunPath%"=="" set "vmrunPath=%defaultVMRun%"
if not exist "%vmrunPath%" (
    echo.
    echo La ruta ingresada no es valida o no se encontro vmrun.exe.
    echo Por favor, verifique la ruta e intente nuevamente.
    pause
    goto CONFIG_VMWARE
)

:: ============================================================
:: Definir carpeta de VMs (ajustable segun necesidades)
:: ============================================================
set "vmFolder=%USERPROFILE%\Documents\Virtual Machines"

:MENU
cls
echo ============================================================
echo         Administrador de VMs - Menu Principal
echo ============================================================
echo 1. Detener una VM en ejecucion
echo 2. Encender una VM (seleccion de dialog)
echo 3. Mostrar estado de VMs
echo.
set /p opcion="Seleccione una opcion (1, 2 o 3): "

if "%opcion%"=="1" goto DETENER
if "%opcion%"=="2" goto ENCENDER
if "%opcion%"=="3" goto MOSTRAR_ESTADO

echo Opcion invalida. Intente de nuevo.
pause
goto MENU

:DETENER
cls
echo Listando maquinas virtuales en ejecucion...
set count=0
for /f "skip=1 delims=" %%a in ('"%vmrunPath%" list') do (
    set /a count+=1
    set "vm[!count!]=%%a"
    echo !count!. %%a
)

if %count%==0 (
    echo No se encontraron maquinas virtuales en ejecucion.
    pause
    goto MENU
)

echo.
set /p seleccion="Seleccione el numero de la maquina a detener: "

:: Validacion basica para que se ingrese un numero
for /f "delims=0123456789" %%A in ("%seleccion%") do (
    echo La seleccion no es valida. Debe ingresar un numero.
    pause
    goto MENU
)

if %seleccion% GTR %count% (
    echo Numero seleccionado fuera de rango.
    pause
    goto MENU
)

call set "vmPath=%%vm[%seleccion%]%%"
echo.
echo Deteniendo la maquina: !vmPath!
:: Se utiliza "soft" para un apagado correcto; cambiar a "hard" si es necesario.
"%vmrunPath%" stop "!vmPath!" soft

echo.
echo Proceso completado.
pause
goto MENU

:ENCENDER
cls
echo Buscando maquinas virtuales en: %vmFolder%
:: Se utiliza PowerShell Out-GridView para mostrar un dialog interactivo
for /f "delims=" %%i in ('powershell -command "Get-ChildItem -Path '%vmFolder%' -Filter *.vmx -Recurse | Out-GridView -Title 'Seleccione una VM para encender' -PassThru | Select-Object -ExpandProperty FullName"') do set "vmPath=%%i"

if not defined vmPath (
    echo No se selecciono ninguna VM o no se encontraron archivos .vmx en el directorio.
    pause
    goto MENU
)

echo.
echo Encendiendo la maquina: %vmPath%
:: Arranque sin interfaz grafica (modificalo si requieres GUI)
"%vmrunPath%" start "%vmPath%" nogui

echo.
echo Proceso completado.
pause
goto MENU

:MOSTRAR_ESTADO
cls
echo ============================================================
echo         Estado de las Maquinas Virtuales
echo ============================================================
:: Generar archivo temporal con la lista de VMs en ejecucion
"%vmrunPath%" list > "%temp%\running.txt"

:: Recorrer todos los archivos .vmx en la carpeta definida (buscando recursivamente)
for /r "%vmFolder%" %%i in (*.vmx) do (
    set "state=Detenida"
    :: Si existe el archivo .vmss, consideramos que la VM esta suspendida
    if exist "%%~dpi%%~ni.vmss" (
        set "state=Suspendida"
    ) else (
        :: Verificar si la VM aparece en la lista de ejecucion usando el archivo temporal
        findstr /L /C:"%%i" "%temp%\running.txt" >nul
        if !errorlevel! == 0 (
            set "state=En ejecucion"
        )
    )
    echo VM: %%i
    echo Estado: !state!
    echo ------------------------------------------------
)
del "%temp%\running.txt"
pause
goto MENU
