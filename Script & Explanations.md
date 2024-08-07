# Fisrt Steps

Let’s create the container using ubuntu

`docker run -dt --name Li**nux-docker-filesystem ubuntu**`

`bash` In the Docker Desktop, open the container terminal, and let’s start using bash

`tree -L 1` To see the folder hierarchy 

If `command not found` you must update the mirror and install the tree package

`apt-get update` for the mirrors

`apt-get install tree` for the package

Now, let’s try again `tree -L 1`. If you want to see the folders and files inside this first layer, `tree -L 2`, and so on… [be careful, do not go beyond 5 levels]

# Overview of some concepts (from this topic, until the Bind Mounts and Docker Volumes, there is no need to execute the codes, they are just a way to show examples).

`ls -la`

## Links

In Ubuntu's Linux filesystem, a link is a reference to a file or directory. There are two types:

1. **Hard Link**: Directly points to the data of a file. Multiple hard links can refer to the same data.
2. **Symbolic (Soft) Link**: Points to the path of a file or directory, like a shortcut.

### Hard Link

Suppose you have a file named `original.txt`:

```bash
echo "Hello, World!" > original.txt
```

To create a hard link named `hardlink.txt` to `original.txt`:

```bash
ln original.txt hardlink.txt
```

Both `original.txt` and `hardlink.txt` now point to the same data.

### Symbolic (Soft) Link

To create a symbolic link named `softlink.txt` to `original.txt`:

```bash
ln -s original.txt softlink.txt
```

`softlink.txt` points to `original.txt` but is a separate file.

### Verifying Links

To verify the links, you can use the `ls -l` command:

```bash
ls -l
```

Output:

```
-rw-r--r-- 2 user user 14 Aug  7 10:00 original.txt
-rw-r--r-- 2 user user 14 Aug  7 10:00 hardlink.txt
lrwxrwxrwx 1 user user 12 Aug  7 10:00 softlink.txt -> original.txt
```

Here, you can see that `hardlink.txt` and `original.txt` have the same inode number and file size, indicating they reference the same data, while `softlink.txt` points to `original.txt`.

You also notice that the hard link starts with `-` while the soft link with `l` and the `->`

## Initialization Directory [boot]

In the Linux Ubuntu filesystem, the `/boot` directory contains files necessary for the system boot process. This includes:

- **Kernel Files**: The core of the operating system (e.g., `vmlinuz`).
- **Initial RAM Disk (initrd) or initramfs**: Temporary filesystem used during the boot process.
- **Bootloader Files**: Programs like GRUB (Grand Unified Bootloader) that load the kernel and initialize the system.

The `/boot` directory is critical for starting the system, and tampering with its contents can prevent the system from booting properly.

## Dev [physical devices]

The `/dev` directory in the Linux filesystem contains device files that represent hardware and virtual devices. These special files allow the operating system and user programs to interact with hardware devices through standard file operations like reading and writing.

Some common types of device files in `/dev` include:

- **Block Devices**: Represent devices that can read/write blocks of data, such as hard drives and USB drives (e.g., `/dev/sda`, `/dev/sdb`).
- **Character Devices**: Represent devices that transmit data character by character, such as terminals and serial ports (e.g., `/dev/tty`, `/dev/ttyS0`).
- **Virtual Devices**: Devices that provide various system-related functionalities, like `/dev/null` (discards all data written to it) and `/dev/zero` (provides a stream of null bytes).

These files provide a standardized way to access and manage hardware and system resources.

## Etc

The `/etc` directory in the Linux filesystem contains system-wide configuration files and scripts. These files are used to configure system and application settings. Key points about the `/etc` directory include:

- **System Configuration**: Contains configuration files for system services, such as network settings, user accounts, and system initialization scripts.
- **Application Configuration**: Stores configuration files for installed applications and services.
- **Subdirectories**: Often has subdirectories for more organized configurations, like `/etc/network` for network settings and `/etc/apt` for package management configurations.

Examples of important files in `/etc`:

- **/etc/passwd**: Contains user account information.
- **/etc/fstab**: Lists filesystems to be mounted at boot.
- **/etc/hostname**: Defines the system's hostname.
- **/etc/hosts**: Maps hostnames to IP addresses.
- **/etc/ssh/**: Contains configuration files for the SSH server.

Overall, the `/etc` directory is crucial for maintaining system and application settings and configurations.

## Media

The `/media` directory in the Linux filesystem is used for automatically mounting removable media devices, such as USB drives, CDs, and DVDs. When a removable device is connected to the system, it is typically mounted to a subdirectory within `/media`, making the contents accessible to the user.

- **Automatic Mount Points**: When you plug in a USB drive, it might be automatically mounted at `/media/username/drive_label`.
- **User Access**: Provides a convenient location for users to access files on removable media.

## mnt

The `/mnt` directory is used for temporarily mounting filesystems. Unlike `/media`, which is typically used for removable media, `/mnt` can be used for mounting any filesystem for temporary use.

- **Manual Mount Points**: System administrators often use `/mnt` as a temporary mount point for filesystems, network shares, or other storage devices.
- **Flexibility**: Provides a flexible location for various types of mounts, often used during maintenance or administrative tasks.

### Examples of Usage

**Mounting a USB drive manually to `/mnt`**:

```bash
sudo mount /dev/sdb1 /mnt
```

This command mounts the filesystem on `/dev/sdb1` to the `/mnt` directory, allowing access to its contents.

**Automatically mounted device in `/media`**:
When you insert a USB drive, it might automatically appear in:

```bash
/media/username/USBDrive
```

Where `username` is your user name and `USBDrive` is the label of the USB drive.

Both directories are essential for managing and accessing different types of storage devices and filesystems.

# Overlay - File System and Partitions
(Reminder: until the Bind Mounts and Docker Volumes, there is no need to execute the codes, they are just a way to show examples)


Overlay filesystems in Docker on Linux Ubuntu enable efficient management and layering of filesystems, which is crucial for containerization. Here's a detailed explanation with examples:

### What is Overlay Filesystem?

The Overlay filesystem is a type of union filesystem that allows multiple filesystems to be merged together, presenting a single unified view of files. Docker uses OverlayFS to manage layers in its images, making it efficient to build and run containers.

**Key Concepts:**

- **Layers**: Docker images are built in layers. Each layer represents a set of changes, such as added or modified files. OverlayFS combines these layers to present a single filesystem to the container.
- **Lower Layers**: These are the read-only layers that Docker stacks on top of each other.
- **Upper Layer**: This is a writable layer where any changes (such as file modifications or additions) are made.

### How OverlayFS Works

1. **Layering**: Docker images are built from multiple layers. Each layer is a snapshot of the filesystem at a certain point in time. OverlayFS combines these layers so that the container sees a unified filesystem.
2. **Read-Only and Writable Layers**:
    - **Lower (Read-Only) Layers**: Layers that cannot be modified. These include base images and intermediate layers.
    - **Upper (Writable) Layer**: The layer where changes are written. This is where files created or modified by the container are stored.

### Example of OverlayFS in Docker

**Setup and Use in Docker:**

1. **Check Docker Storage Driver**:
Docker uses OverlayFS by default on Ubuntu. To verify this:
    
    ```bash
    docker info | grep 'Storage Driver'
    ```
    
    The output should show `overlay2`, which is an improved version of OverlayFS used by Docker.
    
2. **Inspect Overlay Filesystem**:
Docker uses OverlayFS to manage container filesystems. To see how this is implemented:
    
    ```bash
    docker run --rm -it alpine sh
    ```
    
    This command runs an Alpine Linux container interactively. Inside the container, any file operations you perform will be done in the upper (writable) layer.
    
3. **View Docker OverlayFS**:
You can inspect the Docker OverlayFS directory structure on the host. Docker stores container files in the `/var/lib/docker/overlay2` directory.
    - **Lower Layer**: Contains read-only layers.
        
        ```bash
        ls /var/lib/docker/overlay2
        ```
        
    - **Upper Layer**: Contains writable layers and container changes.
        
        ```bash
        cd /var/lib/docker/overlay2
        ls
        ```
        
    - **Merged Layer**: This is where the container views the combined filesystem. It is used to present a unified view of files from all layers.
        
        ```bash
        # Assuming container ID is abc123
        ls /var/lib/docker/overlay2/abc123/merged
        ```
        

### OverlayFS Benefits in Docker

- **Efficiency**: OverlayFS combines multiple layers without duplicating files, saving disk space.
- **Performance**: Using a union filesystem allows Docker to handle large numbers of layers and files efficiently.
- **Layer Reusability**: Multiple images can share layers, reducing redundancy and speeding up image builds and deployments.

### Example Workflow

1. **Build a Docker Image**:
Create a Dockerfile:
    
    ```
    FROM ubuntu:20.04
    RUN apt-get update && apt-get install -y nginx
    ```
    
    Build the image:
    
    ```bash
    docker build -t my-nginx-image .
    ```
    
2. **Run a Container**:
    
    ```bash
    docker run -d --name my-nginx-container my-nginx-image
    ```
    
    This creates a container from the image, using OverlayFS to manage the filesystem layers.
    
3. **Inspect Container Filesystem**:
Access the container’s filesystem:
    
    ```bash
    docker exec -it my-nginx-container sh
    ```
    
    Here, you can modify files and see changes reflected in the container's writable layer.
    

### Summary

OverlayFS in Docker is a powerful feature that enables efficient layering and management of container filesystems. It merges multiple layers into a unified view, optimizing both storage and performance. By understanding and using OverlayFS, you can better manage Docker containers and images, ensuring efficient and scalable containerization.

# Bind Mounts & Docker Volumes
(Reminder, there is no need to execute the codes, they are just a way to show examples)

In Docker, both bind mounts and volumes are used to manage data between the host and containers, but they serve different purposes and have distinct characteristics. Here’s a detailed explanation of each:

### Bind Mounts

**Bind Mounts** allow you to mount a specific file or directory from the host filesystem into a container. This is useful for situations where you need direct access to files or directories on the host.

### Key Characteristics:

- **Host-Container Link**: A bind mount links a file or directory on the host to a specific path inside the container.
- **Real-Time Synchronization**: Changes made in the container are reflected on the host, and vice versa, because they share the same underlying file system.
- **Flexibility**: You can mount any path from the host into the container.

### Example Usage:

1. **Creating a Bind Mount**:
Suppose you have a directory on your host system at `/home/user/data`, and you want to mount it to `/data` in the container.
    
    ```bash
    docker run -d -v /home/user/data:/data --name my-container alpine
    
    ```
    
    This command mounts `/home/user/data` from the host to `/data` in the container.
    
2. **Verifying the Bind Mount**:
To check that the bind mount is working:
    
    ```bash
    docker exec -it my-container sh
    
    ```
    
    Inside the container:
    
    ```
    ls /data
    
    ```
    
    You should see the files from `/home/user/data` on the host.
    

### Use Cases:

- **Development**: Bind mounts are useful for development workflows where you want to reflect code changes made on the host immediately inside the container.
- **Configuration**: Useful for configuration files that need to be shared between the host and container.

### Docker Volumes

**Docker Volumes** are managed by Docker and provide a more robust way to handle persistent data. Volumes are stored in a part of the host filesystem managed by Docker (`/var/lib/docker/volumes`), and Docker takes care of managing the lifecycle of these volumes.

### Key Characteristics:

- **Managed Storage**: Volumes are managed by Docker, making them more portable and easier to back up.
- **Decoupled Storage**: Unlike bind mounts, volumes are not tied to a specific path on the host filesystem.
- **Data Sharing**: Volumes can be shared between multiple containers.

### Example Usage:

1. **Creating a Docker Volume**:
You can create a volume using:
    
    ```bash
    docker volume create my-volume
    
    ```
    
2. **Using a Volume in a Container**:
To use the volume in a container:
    
    ```bash
    docker run -d -v my-volume:/data --name my-container alpine
    
    ```
    
    This mounts the `my-volume` volume to `/data` in the container.
    
3. **Inspecting Volumes**:
To list and inspect volumes:
    
    ```bash
    docker volume ls
    docker volume inspect my-volume
    
    ```
    
4. **Removing a Volume**:
To remove a volume:
    
    ```bash
    docker volume rm my-volume
    
    ```
    

### Use Cases:

- **Persistent Data**: Ideal for storing database files, logs, or any data that needs to persist beyond the lifecycle of a container.
- **Data Sharing**: Suitable for sharing data between containers.

### Summary

- **Bind Mounts**: Link a specific file or directory from the host to the container, providing real-time synchronization and flexibility.
- **Docker Volumes**: Managed by Docker, designed for persistent and shared data storage, providing better isolation from the host filesystem and easier management.

Both methods are useful depending on your needs. Bind mounts are excellent for development and configuration tasks, while volumes are preferable for managing persistent data and sharing data between containers.

# Now that you have an understanding. Let's Code.

## Mount Bind

Now, let’s go back to the prompt (command line).

We are going to need a local folder for this part. You can use your Downloads folder or something like that.

`docker run -it --name volumeandpartitions --mount type=bind,source=/C:/Users/Caio/Downloads, target=/vap/volandpart ubuntu`

- `run` to execute the container
- `-it` for initialize the container and opening the shell (if you do not want that you can use `-d`  instead of `-i`)
- `--mount` to define the local computer mapping file/folder. This way, we have more options to create.
    - Now we have to define the sub-parameters
    - `type=bind` to map a local file system to docker
    - `,source=/C:/Users/Caio/Downloads` to map a local file system to docker
    - `, target=/vap/volandpart` to define where in the Docker system

`cd /vap/volandpart` to go to the folder

`ls` to see all files

`touch example1.txt` to create a txt file

`echo "Testing Docker File System in Dokcer" > example1.txt` to insert some text in this file.

`exit` to quit container


We did the mapping with `mount bind`, now, let’s use another one (more simple)
`docker run -it --name volumeandpartitions2 -v /C:/Users/Caio/Downloads:/vap2/volandpart2 ubuntu`
- It is a more simple way to create. However, we have fewer options when in comparison to `--mount`
  
Let's repeat the process to verify if everything is ok:
- `cd /vap2/volandpart2` to go to the folder
- `ls` to see all files
- `touch example2.txt` to create a txt file
- `echo "testing again" > example2.txt` to insert some text in this file.
- `exit` to quit container


Now, you can start both containers with `docker container start volumeandpartitions` and `docker container start volumeandpartitions2`.

After that, start to edit and create files with both of them.

This is for you to understand and see that both containers can have access and edit files and folders. This concept it is awesome for those that want to work with a team and have access at the same time.

## Volumes

Above, we saw the concept of **bind mounts**

However, we also have the **volume** resource. You can create it in the Docker Desktop. But I will do it in the prompt (command line)

`docker volume create volume_partitions` to create the volume

`docker volume list` to see if worked

If you paid attention, there is no need to map folders, files, or anything related to that. The volume is managed by Docker File System, therefore, there is no need to keep this in the computer system.


`docker volume inspect volume_partitions` to see the volume summary.

Let’s continue this example.

Creating a container in this volume

`docker run -it --name=mycontainer --mount source=volume_partitions, destination=vap/myexample ubuntu`

`df -Th` to see that now, the container is inside docker, not your computer.

Now, you can manage files and folders inside Docker.

If you want to go further, create another container in the same volume, and start editing. This is for you to understand that multiple containers can see and edit the same files and folder.
