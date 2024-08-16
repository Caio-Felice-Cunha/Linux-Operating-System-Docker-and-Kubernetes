# Networking with Docker and Linux

## What exactly is a Network Environment?
A network environment refers to the setup and configuration of network resources, protocols, and topologies that enable communication between devices. It involves the management of network interfaces, IP addresses, routing, and services. In the context of Docker and Linux, it encompasses the virtual network infrastructure that containers use to communicate with each other and the outside world.

## Docker Network Driver
Docker provides several network drivers that determine how networking is managed for containers. The main types of Docker network drivers are:
- **Bridge:** The default driver, creating a private internal network on the host.
- **Host:** Removes network isolation between the container and the Docker host, using the host’s network directly.
- **Overlay:** Enables multi-host networking, suitable for Swarm services.
- **Macvlan:** Assigns a MAC address to containers, making them appear as physical devices.
- **None:** Disables all networking, useful for standalone containers.

## Inspecting the Default Network
Docker automatically creates a default bridge network called `bridge`. To inspect this network, you can use the following command:
```sh
docker network inspect bridge
```
This command provides details such as network ID, driver type, subnet, and connected containers.

## Creating a Container Network in Docker
You can create custom networks to better manage container communication. For example, to create a bridge network:
```sh
docker network create --driver bridge my_custom_network
```
This command creates a new network named `my_custom_network` using the bridge driver. Containers connected to this network can communicate with each other.

## Network Configuration in Linux
Network configuration in Linux involves setting up network interfaces, IP addresses, routes, and DNS. Some common commands include:
- `ifconfig`: View and configure network interfaces.
- `ip addr`: Display IP addresses and properties of network interfaces.
- `route`: Display and modify the IP routing table.
- `netstat`: Display network connections, routing tables, and interface statistics.
- `systemctl`: Manage network services (e.g., `systemctl restart networking`).

## Moving a Container to Another Network
Sometimes, you may need to move a running container from one network to another. To do this, use the following steps:
1. **Disconnect the container from the current network:**
   ```sh
   docker network disconnect <network_name> <container_name>
   ```
2. **Connect the container to the new network:**
   ```sh
   docker network connect <new_network_name> <container_name>
   ```

By following these steps, the container will be moved to the specified network without needing to stop and restart it.

# This Series:
- [1: Linux Terminal in Docker](https://github.com/Caio-Felice-Cunha/Linux-Operating-System-Docker-and-Kubernetes/tree/main/01-Linux-Management-With-Docker)
- [2: Directory Structure, File System, Partitions, and Volumes](https://github.com/Caio-Felice-Cunha/Linux-Operating-System-Docker-and-Kubernetes/tree/main/02-Linux-Docker-Filesystem)
- You are here! [3: Networking with Docker and Linux](https://github.com/Caio-Felice-Cunha/Linux-Operating-System-Docker-and-Kubernetes/tree/main/03%20-%20Networking%20with%20Docker%20and%20Linux)
- [4: Automating Tasks with Bash Script](https://github.com/Caio-Felice-Cunha/Linux-Operating-System-Docker-and-Kubernetes/tree/main/04%20-%20CreatingBash%20Scripts%20for%20Automation)
- [5: Python Application Deployment with Linux and Docker](https://github.com/Caio-Felice-Cunha/Linux-Operating-System-Docker-and-Kubernetes/tree/main/05%20-%20Deploying%20Python%20Applications%20with%20Linux%20and%20Docker)
- NOT YET, BUT SOON [6: Container Deployment with Docker Compose]()
- NOT YET, BUT SOON [7: Container Orchestration with Docker]()
- NOT YET, BUT SOON [8: Container Orchestration with Kubernetes]()
- NOT YET, BUT SOON [9: Guide for Orchestrating a Machine Learning App]()
- NOT YET, BUT SOON [10: Guide for Orchestrating a Data Engineering Pipeline]()
- NOT YET, BUT SOON [11: Firewall, Access Rules, and SSH Configuration]()
- NOT YET, BUT SOON [12: Service Management]()
