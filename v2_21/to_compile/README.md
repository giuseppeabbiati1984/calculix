Procedure to compile CalculiX 2.21:
* open a powershell and type `docker-compose up --build -d` to instantiate the container.
* open another powershell and type `docker exec -it calculix_bash /bin/bash` to access the bash of the container.
* install calculix by executing the installation script `.\install_calculix.sh` and then commit the new image with the compiled code.
* if you edit the make files in MS Windows be reminded to fix the end of line characters for linux by typing `sed -i 's/\r$//' /path/to/your/script.pl` for all edited files.

![](./powershell_view.png) *Screenshot of the Powershells*