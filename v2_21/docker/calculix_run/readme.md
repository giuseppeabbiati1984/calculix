# run python file

For Windows users (still not working):
* go to Windows prompt and type:
  * `cd C:\SALOME-9.12.0` to enter SALOME application folder
  * `env_launch` to load the environmental variables (they are lost when you close the prompt)
* go to the folder where the python script is:
  * `cd C:\repositories\calculix\v2_21\to_compile\calculix_run` to enter the script folder
  * `C:\SALOME-9.12.0\W64\Python\python.exe canale42.py` to run the study

For Linux users (still not working):
* open the bash and type:
  * `cd calculix_src\SALOME-9.12.0-native-UB22.04-SRC` to enture the folder where SALOME is installed
  * `source env_launch.sh` to load the environmental variables
  * `./salome canale42.py` to run the python file