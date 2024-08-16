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

### Script 08 → Full Operational System (OS) Checkup

```bash
#!/bin/bash
# ==============================
# Data Science Academy
# Script: script8.sh
# ==============================
# Script to show current system status
# Colors in Bash: https://tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html
clear
echo ""
echo -e "\e[31;43m***** Hostname *****\e[0m"
hostname
echo ""
echo -e "\e[31;43m***** Platform (32 or 64 Bits) *****\e[0m"
uname -i
echo ""
echo -e "\e[31;43m***** Linux Version *****\e[0m"
cat /etc/os-release | grep -e PRETTY_NAME -e VERSION=
echo ""
echo -e "\e[31;43m***** Disk Space Used *****\e[0m"
df -H | grep -vE '^tmpfs|cdrom'
echo ""
echo -e "\e[31;43m ***** RAM Usage *****\e[0m"
free
echo ""
echo -e "\e[31;43m***** System Uptime and Load *****\e[0m"
uptime
echo ""
echo -e "\e[31;43m***** Top 5 Processes by Memory Usage *****\e[0m"
ps -eo %mem,%cpu,comm --sort=-%mem | head -n 6
echo ""
```

This Bash script, named `script8.sh`, is designed to display the current status of a Linux system. Below is a detailed explanation of each part of the script:

##### 1. Shebang Line

```bash
#!/bin/bash
```

- **Purpose:** This line indicates that the script should be executed using the Bash shell. It ensures that the script runs in the Bash environment.

##### 2. Script Metadata

```bash
# ==============================
# Data Science Academy
# Script: script8.sh
# ==============================
```

- **Purpose:** These lines are comments that provide information about the script, such as the name (`script8.sh`) and its origin (Data Science Academy). Comments in Bash begin with `#` and are ignored during execution.

##### 3. Clear the Terminal Screen

```bash
clear
```

- **Purpose:** This command clears the terminal screen, removing any previous output, so the results of the script are displayed clearly.

##### 4. Displaying Section Headers with Colors

```bash
echo -e "\\e[31;43m***** Hostname *****\\e[0m"
```

- **Purpose:** This line prints the header "***** Hostname *****" with specific colors.
    - `e`: Enables the interpretation of backslash escapes in the `echo` command.
    - `\\e[31;43m`: Sets the text color to red (31) and the background color to yellow (43).
    - `\\e[0m`: Resets the text and background colors to their default values after printing the header.

##### 5. Displaying the Hostname

```bash
hostname
```

- **Purpose:** This command displays the hostname of the system, which is the name assigned to the computer on a network.

##### 6. Displaying the Platform (32 or 64 Bits)

```bash
echo -e "\\e[31;43m***** Platform (32 or 64 Bits) *****\\e[0m"
uname -i
```

- **Purpose:** The `uname -i` command prints the hardware platform (e.g., whether the system is running on a 32-bit or 64-bit architecture).

##### 7. Displaying the Linux Version

```bash
echo -e "\\e[31;43m***** Linux Version *****\\e[0m"
cat /etc/os-release | grep -e PRETTY_NAME -e VERSION=
```

- **Purpose:** This command displays the Linux distribution's version information.
    - `cat /etc/os-release`: Prints the content of the `/etc/os-release` file, which contains operating system identification data.
    - `grep -e PRETTY_NAME -e VERSION=`: Filters the output to only show the lines containing `PRETTY_NAME` (the full name of the distribution) and `VERSION=` (the version of the distribution).

##### 8. Displaying Disk Space Usage

```bash
echo -e "\\e[31;43m***** Disk Space Used *****\\e[0m"
df -H | grep -vE '^tmpfs|cdrom'
```

- **Purpose:** This command displays information about the disk space usage on the system.
    - `df -H`: The `df` command shows disk space usage, with the `H` option displaying the sizes in human-readable format (e.g., GB, MB).
    - `grep -vE '^tmpfs|cdrom'`: Filters out lines containing `tmpfs` or `cdrom`, which are typically not relevant for general disk usage.

##### 9. Displaying RAM Usage

```bash
echo -e "\\e[31;43m ***** RAM Usage *****\\e[0m"
free
```

- **Purpose:** The `free` command displays the system's memory usage, including total, used, and available RAM.

##### 10. Displaying System Uptime and Load

```bash
echo -e "\\e[31;43m***** System Uptime and Load *****\\e[0m"
uptime
```

- **Purpose:** The `uptime` command shows how long the system has been running, along with the system load averages for the last 1, 5, and 15 minutes.

##### 11. Displaying the Top 5 Processes by Memory Usage

```bash
echo -e "\\e[31;43m***** Top 5 Processes by Memory Usage *****\\e[0m"
ps -eo %mem,%cpu,comm --sort=-%mem | head -n 6
```

- **Purpose:** This command lists the top 5 processes consuming the most memory.
    - `ps -eo %mem,%cpu,comm`: Displays the memory usage (`%mem`), CPU usage (`%cpu`), and command name (`comm`) for each running process.
    - `-sort=-%mem`: Sorts the processes in descending order based on memory usage.
    - `head -n 6`: Limits the output to the top 6 lines. The first line is the header, so this effectively shows the top 5 processes by memory usage.

##### 12. Ending the Script

```bash
echo ""
```

- **Purpose:** This final `echo` command simply adds a blank line for neatness, ensuring the terminal prompt appears on a new line after the script finishes running.

##### Summary

This script provides a quick overview of the system’s status, including hostname, platform, Linux version, disk space usage, RAM usage, system uptime, and the top 5 memory-consuming processes. The use of colored headers improves readability, making it easy to identify each section of the output.

![image](https://github.com/user-attachments/assets/ab50a16e-36a8-4ad4-8214-ed050d4fa95f)


### Script 09 → Linux Security Auditing

TWO MAIN THINGS BEFORE RUNNING THIS SCRIPT

First, you must install net-tools

```bash
apt-get install net-tools
```

Second, the script result is too long. Because of that, if you want to see everything, you must run the script and redirect the result to a file.

```bash
bash script_dsa_09.sh > audit.txt
```

About the file: some colors or commands will seem odd or will not even work, because we are changing from the prompt to a file. However, the main analysis and topics should work just fine.

```bash
#!/bin/bash
# ==============================
# Data Science Academy
# Script: script9.sh
# ==============================
# Auditoria de Segurança

# Warning: Run the command below in bash before running this script:

# apt install net-tools

clear
echo "###############################################"
echo "###############################################"
echo "Linux Security Audit Report."
echo "###############################################"
echo "###############################################"
echo "Let's start the audit in 3 seconds..."
sleep 3
echo
echo "This is the name of the machine: $HOSTNAME"
echo
echo "Starting the audit..."
START=$(date +%s)
echo
echo -e "\e[0;33m1. Linux Kernel Details\e[0m"
uname -a
echo
echo -e "\e[0;33m2. Version of this Linux Distribution\e[0m"
cat /etc/os-release | grep -e VERSION=
echo
echo -e "\e[0;33m3. Searching for files with permission 777\e[0m"
find / -type f -perm 0777;
echo
echo -e "\e[0;33m4. Active Connections and Open Ports\e[0m"
netstat -natp
echo
echo -e "\e[0;33m5. History of Executed Commands\e[0m"
history
echo
echo -e "\e[0;33m6. Network Interfaces\e[0m"
ifconfig -a
echo
echo -e "\e[0;33m7. List of all installed packages\e[0m"
apt-cache pkgnames
echo
echo -e "\e[0;33m8. Network Parameters\e[0m"
cat /etc/sysctl.conf
echo
echo -e "\e[0;33m9. Password Policies\e[0m"
cat /etc/pam.d/common-password
echo
echo -e "\e[0;33m10. Source List\e[0m"
cat /etc/apt/sources.list
echo
echo -e "\e[0;33m11. Checking for Broken Dependencies\e[0m"
apt-get check
echo
echo -e "\e[0;33m12. Listing packages that can be upgraded\e[0m"
apt list --upgradeable
echo
echo -e "\e[0;33m13. Users with access to the OS\e[0m"
cut -d: -f1 /etc/passwd
echo
echo -e "\e[0;33m14. Checking Null Passwords\e[0m"
users="$(cut -d: -f 1 /etc/passwd)"
for x in $users
do
passwd -S $x |grep "NP"
done
echo
echo -e "\e[0;33m15. CPU and System Information\e[0m"
cat /proc/cpuinfo
echo
END=$(date +%s)
DIFF=$(( $END - $START ))
echo Audit completed in $DIFF seconds!
echo
echo Report generation date:
date
echo
echo Congratulations on learning Linux here at Data Science Academy!
echo
```

This script, named `script9.sh`, is a Bash script designed to perform a basic security audit on a Linux system. Below is a detailed breakdown of each section of the script:

##### 1. **Shebang and Script Information**

```bash
#!/bin/bash
# ==============================
# Data Science Academy
# Script: script9.sh
# ==============================
# Auditoria de Segurança

```

- `#!/bin/bash`: This line tells the system to use the Bash shell to execute the script.
- The comments provide information about the script, including its purpose (a security audit) and the organization that created it (Data Science Academy).

##### 2. **Prerequisite Installation**

```bash
# Warning: Run the command below in bash before running this script:
# apt install net-tools

```

- The script requires the `net-tools` package, which provides network-related tools such as `netstat`. The user is advised to install this package before running the script.

##### 3. **Clear Screen and Display Headers**

```bash
clear
echo "###############################################"
echo "###############################################"
echo "Linux Security Audit Report."
echo "###############################################"
echo "###############################################"
echo "Let's start the audit in 3 seconds..."
sleep 3

```

- `clear`: Clears the terminal screen.
- Several `echo` commands are used to display a header and some information about the script. The `sleep 3` command pauses the execution for 3 seconds.

##### 4. **Display Machine Name**

```bash
echo
echo "This is the name of the machine: $HOSTNAME"

```

- This section prints the name of the machine, using the environment variable `$HOSTNAME`.

##### 5. **Start the Audit and Record Start Time**

```bash
echo
echo "Starting the audit..."
START=$(date +%s)

```

- The script records the start time of the audit using the `date` command, storing it in the `START` variable.

##### 6. **Audit Tasks**

Each section of the audit is formatted with a title and then executes a specific command.

- **6.1. Linux Kernel Details**
    
    ```bash
    echo -e "\\e[0;33m1. Linux Kernel Details\\e[0m"
    uname -a
    
    ```
    
    - `uname -a`: Displays detailed information about the Linux kernel.
- **6.2. Linux Distribution Version**
    
    ```bash
    echo -e "\\e[0;33m2. Version of this Linux Distribution\\e[0m"
    cat /etc/os-release | grep -e VERSION=
    
    ```
    
    - `cat /etc/os-release | grep -e VERSION=`: Prints the version information of the Linux distribution.
- **6.3. Files with Permission 777**
    
    ```bash
    echo -e "\\e[0;33m3. Searching for files with permission 777\\e[0m"
    find / -type f -perm 0777;
    
    ```
    
    - `find / -type f -perm 0777`: Searches for files with permissions set to `777` (read, write, and execute for everyone).
- **6.4. Active Connections and Open Ports**
    
    ```bash
    echo -e "\\e[0;33m4. Active Connections and Open Ports\\e[0m"
    netstat -natp
    
    ```
    
    - `netstat -natp`: Displays active network connections and open ports.
- **6.5. History of Executed Commands**
    
    ```bash
    echo -e "\\e[0;33m5. History of Executed Commands\\e[0m"
    history
    
    ```
    
    - `history`: Shows the history of commands executed in the shell.
- **6.6. Network Interfaces**
    
    ```bash
    echo -e "\\e[0;33m6. Network Interfaces\\e[0m"
    ifconfig -a
    
    ```
    
    - `ifconfig -a`: Lists all network interfaces and their configurations.
- **6.7. List of Installed Packages**
    
    ```bash
    echo -e "\\e[0;33m7. List of all installed packages\\e[0m"
    apt-cache pkgnames
    
    ```
    
    - `apt-cache pkgnames`: Lists all installed packages.
- **6.8. Network Parameters**
    
    ```bash
    echo -e "\\e[0;33m8. Network Parameters\\e[0m"
    cat /etc/sysctl.conf
    
    ```
    
    - `cat /etc/sysctl.conf`: Displays the network parameters configuration file.
- **6.9. Password Policies**
    
    ```bash
    echo -e "\\e[0;33m9. Password Policies\\e[0m"
    cat /etc/pam.d/common-password
    
    ```
    
    - `cat /etc/pam.d/common-password`: Displays the password policy configuration.
- **6.10. Source List**
    
    ```bash
    echo -e "\\e[0;33m10. Source List\\e[0m"
    cat /etc/apt/sources.list
    
    ```
    
    - `cat /etc/apt/sources.list`: Displays the list of APT repositories.
- **6.11. Check for Broken Dependencies**
    
    ```bash
    echo -e "\\e[0;33m11. Checking for Broken Dependencies\\e[0m"
    apt-get check
    
    ```
    
    - `apt-get check`: Checks the system for broken package dependencies.
- **6.12. List Upgradable Packages**
    
    ```bash
    echo -e "\\e[0;33m12. Listing packages that can be upgraded\\e[0m"
    apt list --upgradeable
    
    ```
    
    - `apt list --upgradeable`: Lists packages that can be upgraded.
- **6.13. Users with Access to the OS**
    
    ```bash
    echo -e "\\e[0;33m13. Users with access to the OS\\e[0m"
    cut -d: -f1 /etc/passwd
    
    ```
    
    - `cut -d: -f1 /etc/passwd`: Lists all users on the system.
- **6.14. Check for Null Passwords**
    
    ```bash
    echo -e "\\e[0;33m14. Checking Null Passwords\\e[0m"
    users="$(cut -d: -f 1 /etc/passwd)"
    for x in $users
    do
    passwd -S $x |grep "NP"
    done
    
    ```
    
    - This checks for users with null passwords. `passwd -S $x` returns the password status for each user, and `grep "NP"` searches for "No Password" (null passwords).
- **6.15. CPU and System Information**
    
    ```bash
    echo -e "\\e[0;33m15. CPU and System Information\\e[0m"
    cat /proc/cpuinfo
    
    ```
    
    - `cat /proc/cpuinfo`: Displays information about the CPU.

##### 7. **End of the Audit and Report Generation**

```bash
END=$(date +%s)
DIFF=$(( $END - $START ))
echo Audit completed in $DIFF seconds!
echo
echo Report generation date:
date
echo
echo Congratulations on learning Linux here at Data Science Academy!

```

- The script records the end time, calculates the duration of the audit, and prints it.
- The `date` command outputs the current date and time.
- Finally, a congratulatory message is displayed.

##### Summary

This script performs a comprehensive security audit on a Linux system by gathering various pieces of information related to system security, user access, network settings, and package management. The audit is intended to provide a quick overview of the system's security posture.


![image](https://github.com/user-attachments/assets/0789df39-889f-47ad-a16d-bf274d4345a9)

### Script 10 → Backup with file versioning

This versioning is based on the file name. If you want to do it only with respect to the file content, I recommend Git.

Before we run the script, first, create a backup folder in the tmp folder.

```bash
cd /tmp
```

```bash
mkdir Backup
```


![image](https://github.com/user-attachments/assets/e398730f-4dfb-4002-b640-aba4901a1712)

Now, let’s go back to the dsacademy folder

```bash
cd /mnt/dsacademy
```

This Bash script is designed to create a backup of scripts located in the `/mnt/dsacademy` directory, saving them to the `/tmp/Backup` directory with versioning. Let's break down the script step by step:

##### 1. **Shebang Line**
   ```bash
   #!/bin/bash
   ```
   - This indicates that the script should be run using the Bash shell.

##### 2. **Comments**
   ```bash
   # ==============================
   # Data Science Academy
   # Script: script10.sh
   # ==============================
   # Backup of scripts (with versioning)
   ```
   - These comments provide information about the script, including the name, purpose, and the organization (Data Science Academy) it belongs to.

##### 3. **Source and Destination Directories**
   ```bash
   # Source
   path_src=/mnt/dsacademy

   # Destination
   # mkdir /tmp/Backup
   path_dst=/tmp/Backup
   ```
   - `path_src` is the directory where the original scripts are located.
   - `path_dst` is the destination directory where the backups will be stored.
   - The `mkdir /tmp/Backup` line is commented out, which suggests that the destination directory is assumed to already exist.

##### 4. **Informative Message**
   ```bash
   echo
   echo -e "\e[0;33mStarting to Backup Lab 4 Scripts.\e[0m"
   ```
   - The script prints a message to inform the user that the backup process is starting.
   - The `echo -e` command with the escape sequence `\e[0;33m` changes the text color to yellow (ANSI escape code) for emphasis, followed by `\e[0m` to reset the color.

##### 5. **Loop Through Source Files**
   ```bash
   for file_src in $path_src/*; do

     cp -a -- "$file_src" "$path_dst/${file_src##*/}-$(date +"%d-%m-%y-%r")"

   done
   ```
   - This `for` loop iterates over each file in the source directory (`$path_src`).
   - `file_src` represents each file path in the source directory.
   - The `cp -a --` command copies each file from the source directory to the destination directory.
   - `${file_src##*/}` extracts the filename from the full path.
   - The `$(date +"%d-%m-%y-%r")` command appends a timestamp to each file name in the format `day-month-year-hour-minute-second`, creating a versioned backup file.

##### 6. **Completion Message and Directory Listing**
   ```bash
   echo
   echo -e "\e[0;33mBackup Complete. Checking folder /tmp/Backup .\e[0m"
   cd /tmp/Backup
   ls -la
   cd /mnt/dsacademy
   echo
   echo -e "\e[0;33mThanks.\e[0m"
   ```
   - After the loop, the script informs the user that the backup process is complete.
   - The `cd /tmp/Backup` command changes the current directory to the backup directory.
   - `ls -la` lists all files in the backup directory with detailed information (permissions, owner, size, etc.).
   - The script then navigates back to the source directory (`cd /mnt/dsacademy`).
   - Finally, the script prints a thank you message in yellow text.

##### **Summary**
This script is a simple yet effective way to back up scripts with versioning. Each file in the `/mnt/dsacademy` directory is copied to the `/tmp/Backup` directory with a timestamp appended to its name, ensuring that previous versions are preserved. The script includes user-friendly messages and changes the text color to make the output more noticeable.


![image](https://github.com/user-attachments/assets/6adab4fd-5622-4ac1-95b0-7a46cb83468a)



