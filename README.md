This project shows an example where it is possible to develop using a remote Visual Studio window to container.

The following image shows the architecture of the system:

![Image](https://code.visualstudio.com/assets/docs/devcontainers/containers/architecture-containers.png)

Basically the container is running vs code server and source code is mirrored with a local operating system.
The local VS Code connects to the VS Code server and acts as a browser to see and change the code.
The general steps to achieve this setup are as follows (please follow the more detailed tutorial below):
1. Install Docker
2. Install VS Code with the [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension
3. Create a .devcontainer with the contents of [.devcontainer](.devcontainer)
4. Modify the [Dockerfile](.devcontainer/Dockerfile) with the dependencies you want to have installed in the container. Note that the base image of the Docker file already contains the vs code server.
5. Modify the [devcontainer.json](.devcontainer/devcontainer.json) file with the extensions you wish to have installed in the vs code server:
    ```json
    "vscode": {
        // Add the IDs of extensions you want installed when the container is created.
        "extensions": ["ms-python.python", "ms-toolsai.jupyter"]
      }
    ```
6. Open the current folder with VS Code, and a prompt should appear stating that `Folder contains a Dev Container configuration file. Reopen folder to develop in a container ([learn more](https://aka.ms/vscode-remote/docker)).`. Select `Reopen` and everything should work.


Tutorial followed: https://code.visualstudio.com/docs/devcontainers/containers
