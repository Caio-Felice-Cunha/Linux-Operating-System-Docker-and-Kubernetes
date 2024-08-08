# Networking with Docker and Linux

Computers communicate within a network environment, whether it’s a local network, the internet, or even within a single machine. Docker networking is primarily used to facilitate communication between Docker containers and the external world through the host machine where the Docker daemon is running.

Docker supports different types of networks, each suitable for specific use cases, and each network type has an associated driver.

By default, when you create a container, it is automatically associated with Docker's default network. You can specify the network during container creation or change it later, as we will explore in this lab.

In this lab, the objective is to explore Docker-supported network drivers, how to create networks, how to associate a container with a network during creation, and how to move a container from one network to another. We will also inspect networks and containers and study network configuration in Linux.

Let's dive in!

## What Exactly is a Network Environment?

To begin, we will use the command line (not Docker Desktop).

When we installed Docker, it created a network environment for us.

Run the following command to see the network interfaces in Docker:
```sh
docker network ls
```
In the `NAME` column, you will see networks such as `bridge` and `host`.

The `bridge` network allows containers to communicate with each other.

## Docker Network Driver

Docker does not provide advanced settings for network configurations because this is not its primary objective. 

To configure Docker Network, use:
```sh
docker network
```
Let’s create a container:
```sh
docker run -dit --name ILoveDocker ubuntu
```
Inspect the container to see all its settings:
```sh
docker inspect ILoveDocker
```
You will see network information under the "Networks" section, including the Gateway, IPAddress, and others.

## Inspecting the Default Network

The output of `docker inspect` is in JSON format. To get just the network information:
```sh
docker inspect ILoveDocker -f "{{json .NetworkSettings.Networks }}"
```
Alternatively, you can use (sometimes it may change the " or '):

'
```sh
docker ps --format '{{ .ID }} {{ .Names }} {{json .Networks}}'
```
"
```sh
docker ps --format "{{ .ID }} {{ .Names }} {{json .Networks}}"
```

To inspect the `bridge` network:
```sh
docker network inspect bridge
```

## Creating a Container Network in Docker

Now, let’s create a new network and move a container into it:
```sh
docker network create Network_ILove
```
Check the new network:
```sh
docker network ls
```
You should see `Network_ILove` in the list, using the `bridge` driver.

Create a container within this new network:
```sh
docker run -dit --network Network_ILove --name ILoveDockerEvenMore ubuntu
```
Verify the network association (again, if the ' is not working, try to use "):
```sh
docker ps --format '{{ .ID }} {{ .Names }} {{json .Networks}}'
```
These containers are completely isolated and independent, which is useful for creating isolated network environments within the same Docker installation.

## Network Configuration in Linux

To understand IP addresses and try to connect the containers `ILoveDocker` and `ILoveDockerEvenMore`, you need to verify their IP addresses first.

Using the Docker Desktop terminal, update the package list and install necessary tools (do not forget the `bash` in the beginning):
```sh
apt-get update
apt-get install net-tools
```
Check the IP address for both containers:
```sh
ifconfig
```
To communicate between containers, install the ping utility:
```sh
apt-get install iputils-ping
ping <IP_ADDRESS>
```
What happenned? Nothing? 3min of wait then timeout? This is because this containers are not in the same network, therefore, they can’t communicate between each other.
If they are on different networks, they won’t communicate. You'll see a timeout after a few minutes.

## Moving a Container to Another Network

To enable communication, move a container from one network to another.

Back to the prompt (command line - outside Docker)

Move the container `ILoveDocker` from the `bridge` network to the `Network_ILove` network.

First, disconnect from the current network:
```sh
docker network disconnect bridge ILoveDocker
```
Then, connect to the new network:
```sh
docker network connect Network_ILove ILoveDocker
```
Retrieve the new IP address and use the `ping` command to test communication.

To stop the ping command, press `Ctrl + C`.
