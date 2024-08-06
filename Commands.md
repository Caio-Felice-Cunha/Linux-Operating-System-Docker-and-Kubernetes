# Creating Docker Image and Container with Linux

### First we go to the prompt (command in line):

* `docker pull ubuntu` download ubuntu docker image

* `docker run -d -p --name Linux-Manag-Docker ubuntu` create container. `-d`stands for detached mode to run in the background.

* `docker ps` view the running containers

## Now we can go to the Docker Desktop Terminal or keep in the prompt

### Prompt

* `docker exec -i -t Linux-Manag-Docker /bin/bash` - `exec` is to perform an action with an already created container `i` allows interaction with the container `-t` is to use this terminal `/bin/bash` is to enter the shell

### Github Desktop

#### Once created, go to Docker Desktop than Containers than 3 dots than Terminal

* `bash` open shell

* `ls -la` view container

# Managing users in Linux (with adduser not found and permission denied)

In the Docker Desktop container shell/command prompt (we will use bash)

* `adduser USERNAME` to add the user

  If `adduser` doesn't work.
    
    To use the `adduser` command, you need to ensure that it is installed in your Docker container. Here's how you can install it:
    
    1. Update the package list:
        
        ```bash
        apt-get update
        ```
        
    2. Install the `adduser` package:
        
        ```bash
        apt-get install adduse
        ```
        
    3. After installing, you can add the user `caio` using the `adduser` command:
        
        ```bash
        adduser caio
        ```
        
    
    This will prompt you to enter details for the new user, including a password.
    
    Here's the complete sequence of commands:
    
    ```bash
    apt-get update
    apt-get install adduser
    adduser caio
    ```

* `su USERNAME`  to log in to the user (as root - if permission denied, just keep reading and find the session "Perrmission denied" below)

* `id` just like `pwd`, it will show you where you are

* `ls` to list contents (does not take hidden files into account)

* `ls -la` to list contents (including hidden ones)

- Permission denied
    
    The user `caio` does not have permission to access the root directory `/root`. This is expected because `/root` is typically only accessible by the root user for security reasons. To continue working with the `caio` user, you should switch to a directory where the `caio` user has appropriate permissions, such as `/home/caio`.
    
    Here are the steps to switch to the `caio` user's home directory and ensure it exists:
    
    1. Switch back to the root user:
        
        ```bash
        exit
        ```
        
    2. Create the home directory for the `caio` user (if it doesn't already exist) and set the appropriate permissions:
        
        ```bash
        mkdir -p /home/caio
        chown caio:caio /home/caio
        ```
        
    3. Switch to the `caio` user and navigate to their home directory:
        
        ```bash
        su caio
        cd /home/caio
        ```
        
    4. Verify the current directory and list its contents:
        
        ```bash
        pwd
        ls -la
        ```
        
    This sequence will place you in the `caio` user's home directory, where they have the necessary permissions to work with files and directories.
