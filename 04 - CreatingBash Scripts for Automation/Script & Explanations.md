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

### Running the First Two Scripts

Let’s begin by executing the first two scripts.

**Script 1:**

```bash
#!/bin/bash
# ==============================
# Data Science Academy
# Script: script1.sh
# ==============================
TEXT="Hello World"
echo $TEXT
```

- `#!/bin/bash` specifies the type of shell being used.
- Lines beginning with `#` are comments.
- The script assigns the value "Hello World" to the variable `TEXT` and then prints it using the `echo` command.

### Executing Script 1

To run the first script, navigate to the scripts folder and execute it using:

```bash
bash script_dsa_01.sh
```

Alternatively, you can make the script executable. To do this, change its permissions using:

```bash
chmod 655 script_dsa_01.sh
```

Before executing, check if the permission change was successful:

- Run `ls` to see if the script's color has changed (indicating it’s executable). Note that this might not always happen.
- Run `ls -la` to verify that the file's permissions have indeed changed.

Now, execute the script:

```bash
./script_dsa_01.sh
```
![image](https://github.com/user-attachments/assets/334091f7-9ea4-448b-9b28-d6205f534cae)

### **Script 2:**

```bash
#!/bin/bash
# ==============================
# Data Science Academy
# Script: script2.sh
# ==============================
clear
echo "Linux Environment Details:"
echo "=================================================="
echo ""
echo "Your home folder is: $HOME"
echo ""
echo "The name of this machine is: $HOSTNAME"
echo ""
echo "Your terminal session type is: $TERM"
echo ""
echo "The PATH is: $PATH"
echo ""
```

To execute the second script, use:

```bash
bash script_dsa_02.sh
```

![image](https://github.com/user-attachments/assets/23588b91-4f6f-4465-8feb-14393bcdd5f3)

### **Script 3:**

```bash
bash script_dsa_03.sh
```

This script is designed to interact with the user by asking for their first name, last name, and age, then providing some output based on their input.

Here’s a breakdown of the code:

```bash
#!/bin/bash
# ==============================
# Data Science Academy
# Script: script3.sh
# ==============================
```

- `#!/bin/bash` specifies that the script should be run using the Bash shell.
- The lines starting with `#` are comments, which are ignored by the shell. These are used to describe the script and provide context.

##### User Input Section

```bash
echo "Enter your first name: "
read FIRSTNAME
```

- `echo "Enter your first name: "` displays a prompt asking the user to enter their first name.
- `read FIRSTNAME` waits for the user to input their first name and stores it in the variable `FIRSTNAME`.

```bash
echo "Enter your last name: "
read LASTNAME
```

- Similar to the first name, this prompts the user for their last name and stores it in the `LASTNAME` variable.

##### Displaying the Full Name

```bash
echo ""
echo "Your full name: $FIRSTNAME $LASTNAME"
```

- `echo ""` prints a blank line for better readability.
- `echo "Your full name: $FIRSTNAME $LASTNAME"` displays the user's full name by combining the `FIRSTNAME` and `LASTNAME` variables.

##### Asking for Age and Performing a Calculation

```bash
echo ""
echo "Enter your age now: "
read USERAGE
```

- After displaying another blank line, the script prompts the user to enter their current age and stores it in the `USERAGE` variable.

```bash
echo "In 10 years you will be \\`expr $USERAGE + 10\\` years old."
```

- This line calculates the user's age in 10 years by adding 10 to the `USERAGE` variable.
- The `expr` command evaluates the expression `$USERAGE + 10`.
- The result is then displayed to the user.

##### Summary

This script is a simple example of how to take user input in a Bash script, store it in variables, and use those variables to display information and perform basic calculations. It demonstrates the use of `read` for input, `echo` for output, and `expr` for arithmetic operations.

![image](https://github.com/user-attachments/assets/9577bc50-4bd8-432a-a7c1-45c0b9fc8296)


### **Script 4:**

```bash
bash script_dsa_04.sh
```

This script demonstrates how to work with arrays and loops in a Bash script. It iterates over a list of server names and prints each one.

Here’s a breakdown of the code:

```bash
#!/bin/bash
# ============================
# Data Science Academy
# Script: script4.sh
# =============================

```

- `#!/bin/bash` specifies that the script should be executed using the Bash shell.
- The lines beginning with `#` are comments that describe the script and its purpose. They don’t affect the execution of the code.

##### Array Declaration

```bash
SERVERLIST=("server01" "server02" "server03" "server04")
COUNT=0

```

- `SERVERLIST=("server01" "server02" "server03" "server04")` declares an array named `SERVERLIST` containing four server names: "server01", "server02", "server03", and "server04".
- `COUNT=0` initializes a counter variable `COUNT` to zero. This variable will be used to keep track of the index as the script iterates through the array.

##### Loop Through the Array

```bash
for INDEX in ${SERVERLIST[@]}; do
 echo "Server: ${SERVERLIST[COUNT]}"
 COUNT="`expr $COUNT + 1`"
done

```

- `for INDEX in ${SERVERLIST[@]}; do` begins a loop that will iterate over each element in the `SERVERLIST` array. `${SERVERLIST[@]}` expands to all the elements in the array.
- `echo "Server: ${SERVERLIST[COUNT]}"` prints the current server name. The script accesses the server name using `SERVERLIST[COUNT]`, where `COUNT` represents the current index in the array.
- `COUNT="`expr $COUNT + 1`"` increments the `COUNT` variable by 1 after each iteration. The `expr` command evaluates the expression `$COUNT + 1`, and the result is stored back in `COUNT`. This ensures that the next iteration of the loop accesses the next server in the array.
- `done` marks the end of the loop. The script repeats the loop until it has gone through all elements in the `SERVERLIST` array.

##### Summary

This script demonstrates the use of arrays and loops in Bash. It iterates over a list of servers stored in the `SERVERLIST` array and prints each one. The `COUNT` variable is used to track the current index in the array, and it’s incremented after each iteration to move to the next server. This is a common pattern in Bash scripting when dealing with arrays and looping through their elements.

![image](https://github.com/user-attachments/assets/1536e56e-f520-460b-9287-d7dfb2da2283)

### Script 05 → The Concept is very useful for automation

```bash
#!/bin/bash
# ==============================
# Data Science Academy
# Script: script5.sh
# ==============================
# Case
clear
echo "MENU"
echo "========="
echo "1 FCD"
echo "2 FADA"
echo "3 FED"
echo "4 FAD"
echo "5 FEM"
echo "6 FEI"
echo "7 FEB"
echo "8 FRPA"
echo "9 FLP"
echo "10 FML"
echo "11 FAE"
echo "12 FIAV"
echo "13 FSIB"
echo "S Exit"
echo "Enter the number of the course you are taking in DSA (or S to exit and end the script): "
read MENUCHOICE
case $MENUCHOICE in
1)
 echo "You chose the Data Scientist course. Congratulations!";;
2)
 echo "You chose the Data Analyst course. Congratulations!";;
3)
 echo "You chose the Data Engineer course. Congratulations!";;
4)
 echo "You chose the Data Architect course. Congratulations!";;
5)
 echo "You chose the Machine Learning Engineer course. Congratulations!";;
6)
 echo "You chose the AI Engineer course. Congratulations!";;
7)
 echo "You chose the Blockchain Engineer course. Congratulations!";;
8)
 echo "You chose the RPA Developer course. Congratulations!";;
9)
 echo "You chose the Python Language for Data Science course. Congratulations!";;
10)
 echo "You chose the Machine Learning Training. Congratulations!";;
11)
 echo "You chose the Statistical Analysis Training. Congratulations!";;
12)
 echo "You chose the Artificial Intelligence for Sales Training. Congratulations!";;
13)
 echo "Congratulations!";;
S)
 echo "You asked to end the script!";;
esac
```

This is a Bash script that provides a simple menu interface for users to select from a list of courses. Here's a breakdown of how it works:

1. **Shebang Line**:
    
    ```bash
    #!/bin/bash
    ```
    
    This line specifies that the script should be executed using the Bash shell.
    
2. **Comments**:
    
    ```bash
    # ==============================
    # Data Science Academy
    # Script: script5.sh
    # ==============================
    ```
    
    These lines are comments providing information about the script, such as its purpose and name.
    
3. **Clear Screen**:
    
    ```bash
    clear
    ```
    
    This command clears the terminal screen before displaying the menu.
    
4. **Display Menu**:
    
    ```bash
    echo "MENU"
    echo "========="
    echo "1 FCD"
    echo "2 FADA"
    echo "3 FED"
    echo "4 FAD"
    echo "5 FEM"
    echo "6 FEI"
    echo "7 FEB"
    echo "8 FRPA"
    echo "9 FLP"
    echo "10 FML"
    echo "11 FAE"
    echo "12 FIAV"
    echo "13 FSIB"
    echo "S Exit"
    ```
    
    These `echo` commands print out the menu options for the user to choose from.
    
5. **Prompt for Input**:
    
    ```bash
    echo "Enter the number of the course you are taking in DSA (or S to exit and end the script): "
    read MENUCHOICE
    ```
    
    This part asks the user to enter a number corresponding to a course or 'S' to exit. The user's input is stored in the variable `MENUCHOICE`.
    
6. **Case Statement**:
    
    ```bash
    case $MENUCHOICE in
    1)
     echo "You chose the Data Scientist course. Congratulations!";;
    2)
     echo "You chose the Data Analyst course. Congratulations!";;
    3)
     echo "You chose the Data Engineer course. Congratulations!";;
    4)
     echo "You chose the Data Architect course. Congratulations!";;
    5)
     echo "You chose the Machine Learning Engineer course. Congratulations!";;
    6)
     echo "You chose the AI Engineer course. Congratulations!";;
    7)
     echo "You chose the Blockchain Engineer course. Congratulations!";;
    8)
     echo "You chose the RPA Developer course. Congratulations!";;
    9)
     echo "You chose the Python Language for Data Science course. Congratulations!";;
    10)
     echo "You chose the Machine Learning Training. Congratulations!";;
    11)
     echo "You chose the Statistical Analysis Training. Congratulations!";;
    12)
     echo "You chose the Artificial Intelligence for Sales Training. Congratulations!";;
    13)
     echo "Congratulations!";;
    S)
     echo "You asked to end the script!";;
    esac
    ```
    
    The `case` statement checks the value of `MENUCHOICE` and matches it with the specified options. Based on the user's input, it prints a message corresponding to the chosen course or indicates that the script will exit if 'S' is selected.
    

In summary, the script provides a menu for course selection, takes user input, and displays a corresponding message based on the input.

### Script 06 -> Backups

```bash
#!/bin/bash
# ==============================
# Data Science Academy
# Script: script6.sh
# ==============================

# Extract the current date from the system
# Use date --help to check the options
current_time=$(date +"%H%M%S")

# Create a backup of the folder using the current date in the file name
tar -czf data_$current_time.tar.gz /root/data/ml-latest-small

# Move the file to another folder
mv data_$current_time.tar.gz /tmp
```

For this one to work, we first need to do some steps.

- Step 01: create a folder
    - `cd ~` → going to the home directory (`pwd`  tif you do not know where you are)
    - `mkdir data` → create a folder
    - `cd data/` → access the folder (`ls` if you want to make sure there is nothing there)
- Step 02: Download a zip file from internet (any file)
    - `wget FULL INTERNET LINK` (for exemple `wget https://files.grouplens.org/datasets/movielens/ml-latest-small.zip` )
        - If you do not have this library installed
            - `apt-get update`
            - `apt-get install wget`
- Step 03: unzip the file
    - `ls -la` → just to verify if the file is in this directory
    - `unzip ml-latest-small.zip` → to unzip
        - If you do not have this library installed
            - `apt-get install unzip`
    - Delete any zip file
        - `rm -rf *.zip`
        - `ls` to confirm
- Step 04: Automate the backup
    - `cd ml-latest-small/`
    - `ls`
    - `cd /mnt/dsacademy` → to go back to our folder
    - `bash script_dsa_06.sh`
    - `cd /tmp/` and `ls -la`

This Bash script performs a series of tasks to create and manage a backup of a specific directory. Here's a detailed explanation:

1. **Shebang Line**:
    
    ```bash
    #!/bin/bash
    
    ```
    
    This specifies that the script should be executed using the Bash shell.
    
2. **Comments**:
    
    ```bash
    # ==============================
    # Data Science Academy
    # Script: script6.sh
    # ==============================
    
    ```
    
    These lines are comments that provide information about the script, such as its purpose and name.
    
3. **Extract Current Time**:
    
    ```bash
    current_time=$(date +"%H%M%S")
    
    ```
    
    This command uses the `date` command to get the current time in hours, minutes, and seconds (e.g., `153045` for 3:30:45 PM). The result is stored in the variable `current_time`. The `+"%H%M%S"` format specifies how the date and time should be formatted.
    
4. **Create a Backup**:
    
    ```bash
    tar -czf data_$current_time.tar.gz /root/data/ml-latest-small
    
    ```
    
    This command creates a compressed tarball (a `.tar.gz` file) of the directory `/root/data/ml-latest-small`. The tarball file is named `data_$current_time.tar.gz`, where `$current_time` is the current time extracted in the previous step. The `-czf` options are used as follows:
    
    - `c`: Create a new archive.
    - `z`: Compress the archive using gzip.
    - `f`: Specify the filename of the archive.
5. **Move the Backup File**:
    
    ```bash
    mv data_$current_time.tar.gz /tmp
    
    ```
    
    This command moves the created backup file (`data_$current_time.tar.gz`) to the `/tmp` directory. The `/tmp` directory is typically used for temporary file storage.
    

##### Summary

- The script creates a timestamped backup of a directory (`/root/data/ml-latest-small`) and stores it as a compressed tarball.
- It then moves the backup file to the `/tmp` directory for temporary storage.

This process is useful for creating regular backups of data with unique filenames based on the time of creation, which helps in managing and organizing backup files.


![image](https://github.com/user-attachments/assets/435f0afa-606b-4a59-9758-1bb90675e2d6)

### Script 07 → Docker disk space usage report on computer

```bash
#!/bin/bash
# ==============================
# Data Science Academy
# Script: script7.sh
# ==============================
clear
echo "Disk Space Usage Report on machine: $HOSTNAME"
echo ""
echo "All mount points:"
echo ""
df -TH
echo ""
echo "Checking these mount points:"
echo ""
df -H | grep -vE '^Filesystem|tmpfs|cdrom'
echo ""
echo "Simplifying the data:"
echo ""
df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }'
echo ""
echo "Loop through the found items to check the available space:"
echo ""

# Loop
df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' | while read output;
do
echo $output
space_used=$(echo $output | awk '{ print $1}' | cut -d'%' -f1 )
partition=$(echo $output | awk '{ print $2 }' )
if [ $space_used -ge 80 ]; then
echo "Running out of space on disk \"$partition ($space_used%)\" on $(hostname) as on $(date)"
fi
done
```

This script, `script7.sh`, is designed to generate a disk space usage report on a Linux system. It provides a detailed view of the available disk space on the system's mounted file systems and alerts if any partition's usage exceeds a certain threshold (80% in this case). Here's a breakdown of what each part of the script does:

##### 1. **Script Header:**

```bash
#!/bin/bash
# ==============================
# Data Science Academy
# Script: script7.sh
# ==============================

```

- The `#!/bin/bash` shebang specifies that the script should be run using the Bash shell.
- The comments provide metadata about the script, such as its purpose or origin.

##### 2. **Clear Screen and Initial Echo Statements:**

```bash
clear
echo "Disk Space Usage Report on machine: $HOSTNAME"
echo ""
echo "All mount points:"
echo ""
df -TH

```

- `clear` clears the terminal screen before running the script.
- `echo "Disk Space Usage Report on machine: $HOSTNAME"` prints a message showing the disk space usage report for the machine, where `$HOSTNAME` is a system variable representing the name of the machine.
- `df -TH` displays the disk space usage in a human-readable format with all mount points listed. The `T` option shows the file system type, and `H` uses powers of 1000 for the size units (e.g., MB, GB).

##### 3. **Filter Relevant Mount Points:**

```bash
echo ""
echo "Checking these mount points:"
echo ""
df -H | grep -vE '^Filesystem|tmpfs|cdrom'

```

- This section filters the output of `df -H` to exclude lines related to file systems that are not of interest, such as those labeled `Filesystem`, `tmpfs` (temporary filesystems), and `cdrom`.
- `grep -vE '^Filesystem|tmpfs|cdrom'` uses regular expressions to exclude lines that match these patterns.

##### 4. **Simplify the Data:**

```bash
echo ""
echo "Simplifying the data:"
echo ""
df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }'

```

- This step further processes the filtered output to only display the percentage of used space (`$5`) and the corresponding file system name (`$1`).
- `awk '{ print $5 " " $1 }'` extracts and prints the fifth and first columns of the output from the previous command.

##### 5. **Loop Through Items and Check Space:**

```bash
echo ""
echo "Loop through the found items to check the available space:"
echo ""
df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' | while read output;
do
echo $output
space_used=$(echo $output | awk '{ print $1}' | cut -d'%' -f1 )
partition=$(echo $output | awk '{ print $2 }' )
if [ $space_used -ge 80 ]; then
echo "Running out of space on disk \\"$partition ($space_used%)\\" on $(hostname) as on $(date)"
fi
done

```

- This section loops through each line of the simplified output.
- `while read output; do` starts a loop that processes each line.
- Inside the loop:
    - `space_used=$(echo $output | awk '{ print $1}' | cut -d'%' -f1 )` extracts the numerical value of the used space percentage by using `awk` to grab the first field and `cut -d'%' -f1` to remove the '%' symbol.
    - `partition=$(echo $output | awk '{ print $2 }' )` extracts the partition name (the second field).
- The `if` statement checks if the `space_used` value is greater than or equal to 80%.
- If the condition is met, it prints a warning message indicating that the partition is running out of space, including the partition name, usage percentage, the hostname, and the current date.

##### **Summary:**

- The script generates a disk usage report, filters out irrelevant mount points, simplifies the data to show only the used space percentage and partition name, and checks if any partition is above the 80% usage threshold. If so, it provides a warning message. This script can be useful for system administrators to monitor disk space usage and prevent partitions from becoming full.

![image](https://github.com/user-attachments/assets/458880c8-8991-4426-b28a-751d4a7ad9cc)

