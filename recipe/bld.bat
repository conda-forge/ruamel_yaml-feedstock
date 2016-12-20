set INCLUDE=%LIBRARY_INC%;%INCLUDE%
set LIBPATH=%LIBRARY_LIB%;%LIBPATH%
set LIB=%LIBRARY_LIB%;%LIB%

FOR /F "delims=" %%i IN ('cygpath.exe -u %SRC_DIR%') DO set "SRC_DIRU=%%i"
FOR /F "delims=" %%i IN ('cygpath.exe -u %RECIPE_DIR%') DO set "RECIPE_DIRU=%%i"

bash %RECIPE_DIR%\prepare.bash %RECIPE_DIR% %SRC_DIR%
if errorlevel 1 exit 1

%PYTHON% setup.py install
if errorlevel 1 exit 1

copy %LIBRARY_BIN%\yaml.dll %SP_DIR%\ruamel_yaml\ext\
if errorlevel 1 exit 1

rd /s /q %SP_DIR%\__pycache__
if errorlevel 1 echo nvd
