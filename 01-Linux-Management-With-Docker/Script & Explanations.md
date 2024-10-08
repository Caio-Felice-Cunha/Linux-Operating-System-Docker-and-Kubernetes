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

# Managing Groups in Linux

Change the user group. Typically used to grant privileges and authorizations.

To do this, we will go back to the root user. To do this, just press `exit` and confirm that you are in root with `id`

`addgroup GROUPNAME` to create a group

`usermod -g GROUPNAME USERNAME` to associate the user with the group

Let’s verify: `su USERNAME` | `cd ~` | `ls -la` now, you should something like this: username usergroup. You can also see with `id` - here you see that the main group is now the one that you changed it to.

However, you can also create a secondary group for this user. First, `exit` .

`usermod -a -G SECONDARYGROUPNAME USERNAME` Here you can see that the `-g` is for creating the primary group, and the `-G` is for the secondary group.

Let’s verify: `su USERNAME` | `id`

# Manipulating Files and Folders in Linux

In the user directory. For example: `cd /home/username`
`touch mydata.txt` to create a txt archive (archivename.archivetype)

In order to edit this archive, let’s use “vi”

To install, we need to go back to the root (admin power)

`exit`  to go to root

install in Linux Ubuntu

`apt-get update`  to get the most recently mirror updates

`apt-get install vim` to install the ‘vi’ for us to edit the .txt archive

`su username`  to go to users folder

`vi mydata.txt`  to open the text edit

When you open using vi, you can’t do anything. First you need to press the ‘i’ key in your keyboard for you to insert information. 

##### ALWAYS PAY ATTENTION IN THE BOTTON

If you notice, the bottom text changes from “archivename.archivetype” OL, OB to  “INSERT”. Now you can type.

After typing, just press the “ESC” key.

`:w` to save -> If you had problems in saving and quitting, like I did, you must insert the exclamation point in the end `:w!`

`:q` or `:q!` to quit

`:wq` or `:wq!` to save and quit

`cat archivename.archivetype`  to see the archive content in the prompt

`cat archivename.archivetype > archivename2.archivetype` to send the archive exists into another, even if the archive does not exists.

Now, let's create a folder. After we will copy and move archives into it. Lastly, let's delete everything

`mkdir datasets`  to create a folder

`cp mydata.txt datasets/` to copy a file

`mv mydata2.txt datasets/`  to move a file

`rm groceries.txt` to remove/delete files

`rmdir datasets/` to remove/delete the folder (the folder must be empty for you to delete it)

`ls -la mydata.txt` is going to show the file metadata

### Privileges and Authorizations

Now we are going to see how privileges and authorizations work.

When you type `ls -la file.extension` In the beginning of each file you will find something like this “-rw-r--r--”. The “rw” are the owner privileges. After, is the owner group privileges. Lastly, is the privilege for anyone else.

`chmod 777 file.extension` to change the visualization for you to understand it better. Now it changed to “-rwxrwxrwx”. R stands for read, W stands for write, and X for execution.

So, what the “-rwxrwxrwx” tells us is that:

- The owner can read, write and execute the file (first 3 letters)
- The owner group can read, write and execute the file (the 3 letters in the middle)
- Anyone can read, write and execute the file (last 3 letters)
- The letter “R” has the value of 4. The letter “W” has the value of 2. The letter “X” has the value of 1

Now, let’s change these privileges. I want just for the owner and group owner to be able to edit the file.

`chmod 770 mydata.txt` To change mode. The first number (7) refers to the owner's privileges. The second number (7) refers to the group privileges. The third number (0) refers to any other user.

In this case, the number 7 refers to rwx, and 0, to no privileges.

Now the text is “-rwxrwx---”.

Now, let’s change owner and owner group of the file.

`chown root:root mydata.txt` To change the owner and the group to the user “root”. The first “root” correspond to the user, and the second “root”, to the group.

`chmod 600 mydata.txt` To change the privileges of the file. Now, only the user owner can read and write. No one can execute, and the group and other users have no privileges.





