# What is Bash?

Bash stands for "Bourne Again SHell." It's a command-line interface (CLI) used in Linux and other Unix-based systems. A command-line interface is a way to interact with your computer by typing text commands instead of using a mouse and graphical interface.

## What is a Shell?

Before diving into Bash specifically, it's important to understand what a "shell" is. A shell is a program that takes commands from the user and tells the operating system what to do with them. Think of it as a middleman between you and your computer's operating system.

There are different types of shells, and Bash is one of the most popular ones. Other examples of shells are Zsh, Fish, and the original Bourne shell (which Bash is based on).

## Why is Bash Important?

Bash is the default shell on many Linux distributions and macOS. It’s powerful because it allows users to execute complex commands, automate tasks, and run scripts that can perform a series of commands all at once.

## How Do You Use Bash?

When you open a terminal in Linux, you're usually interacting with the Bash shell. You can type in commands to do things like:

- **Navigating the file system**: `cd` (change directory), `ls` (list files and directories), etc.
- **Managing files**: `cp` (copy), `mv` (move), `rm` (remove), etc.
- **Running programs**: You can launch any program installed on your system by typing its name.

# What is a Bash Script?

A Bash script is a file containing a series of Bash commands. Instead of typing each command individually, you can put them all in a file and run that file as a script. This is particularly useful for automating repetitive tasks.

For example, if you always have to create a new directory, move into it, and create a new file, you could write a Bash script that does all that with a single command.

## Basic Example

Let’s say you want to create a directory and then move into that directory:

1. **Manually**:
    - `mkdir my_new_directory` (This creates a directory named "my_new_directory")
    - `cd my_new_directory` (This changes your current directory to "my_new_directory")
2. **In a Bash Script**:
You can create a file (let's call it `create_and_enter.sh`) with the following content:
    
    ```bash
    #!/bin/bash
    mkdir my_new_directory
    cd my_new_directory
    ```
    
    Then, you can run this script by typing:
    
    ```bash
    bash create_and_enter.sh
    ```
    

## Key Takeaways:

- **Bash** is a popular shell used to interact with your Linux system via the command line.
- **Shells** like Bash act as intermediaries between you and the operating system.
- **Bash scripts** allow you to automate tasks by grouping commands in a file that can be executed all at once.

Bash is incredibly powerful, and as you become more familiar with it, you'll be able to use it to perform a wide variety of tasks more efficiently!

# Books
* GNU Bash manual https://www.gnu.org/software/bash/manual/ ;
* Advanced Bash-Scripting Guide https://tldp.org/LDP/abs/html/ ;
* The Linux Command Line http://linuxcommand.org/tlcl.php ;
* The GNU Awk User’s Guide https://www.gnu.org/software/gawk/manual/gawk.html .

# Let's Go
Download the archives in the [Scripts Folder](https://github.com/Caio-Felice-Cunha/Linux-Operating-System-Docker-and-Kubernetes/tree/main/04%20-%20CreatingBash%20Scripts%20for%20Automation/Scripts)

## Bash Scripting

Create a Docker container mapping a local folder with the Bash scripts

Do not forget to change the folder to the appropriate location on your computer and the destination in the Docker container:

`docker run -dt --name Lab4 -v YOUR/FILES/PATH/WITH/THE/DOWNLOADS:/DESTINATION/FOLDER/DOCKER ubuntu`

Run the docker container with bash terminal on the command line

`docker exec -t -i Lab4 /bin/bash`

Now, let's see if is everything ok:

`hostname`

`id`

`df -h` -> Here you should see the folder you create in the "/DESTINATION/FOLDER/DOCKER". Mine is "/mnt/dsacademy"

`cd /mnt/dsacademy`

`ls` to see all the archives

![image](https://github.com/user-attachments/assets/27402fa0-7182-4828-b41a-a021f58356a4)




