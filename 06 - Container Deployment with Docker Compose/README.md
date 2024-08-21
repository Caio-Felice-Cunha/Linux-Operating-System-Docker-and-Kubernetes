# 06 - Container Deployment with Docker Compose

Welcome to my Docker Compose studies repository! This repository documents my learning journey and hands-on experience with deploying containers using Docker Compose. Below is an overview of the topics and deployments covered.

In the last studies ([5: Python Application Deployment with Linux and Docker](https://github.com/Caio-Felice-Cunha/Linux-Operating-System-Docker-and-Kubernetes/tree/main/05%20-%20Deploying%20Python%20Applications%20with%20Linux%20and%20Docker)), we explored how to use Dockerfile to build a custom image and deploy a single container. However, when it comes to deploying multiple containers as part of a single system, Docker Compose is the tool of choice. This section focuses on this tool and is divided into two parts:

- **Deploy 1**: Stack for Deploying a Web App with Python and Redis.
- **Deploy 2**: Stack for Deploying a Web App, API, and Database.


## Here is what you are going to learn

1. Deploying Containers with Docker Compose: This section covers the basics of deploying containers using Docker Compose. You'll learn how Docker Compose simplifies multi-container deployments and how it fits into modern development workflows;
2. When to Use Docker Compose? Here, I discuss scenarios where Docker Compose is particularly useful, such as when managing complex applications that require multiple services working together.;
3. Deploy 1: Stack for Deploying Web Apps with Python and Redis;
4. Defining Individual Containers: In this section, I explain how to define individual containers for a Python web application and a Redis database;
5. Creating Individual Containers: Learn how to create and configure individual containers for each service using Dockerfiles;
6. Creating the YAML File and Deploying: This section guides you through creating a YAML file for Docker Compose to define the services and how to deploy them;
7. Deploying and Persisting Data: Here, I cover techniques for persisting data between container restarts, ensuring data is not lost;
8. Deploy 2: Stack for Deploying Web Apps, APIs and Databases;
9. Defining Stack Containers: In this section, I explore how to define containers for a more complex stack involving web apps, APIs, and databases;
10. Creating the Stack Container with NGINX: Learn how to create and configure a container for the NGINX web server;
11. Creating the Stack Container with NODE.JS: This section covers the steps to create and configure a container for a Node.js application;
12. Configuring the YAML File: Here, I guide you through the process of configuring the YAML file for the stack, ensuring all services work together seamlessly;
13. Deploying and Testing the API: Finally, I demonstrate how to deploy the stack and test the API to ensure everything is functioning correctly;


# This Series:
- [1: Linux Terminal in Docker](https://github.com/Caio-Felice-Cunha/Linux-Operating-System-Docker-and-Kubernetes/tree/main/01-Linux-Management-With-Docker)
- [2: Directory Structure, File System, Partitions, and Volumes](https://github.com/Caio-Felice-Cunha/Linux-Operating-System-Docker-and-Kubernetes/tree/main/02-Linux-Docker-Filesystem)
- [3: Networking with Docker and Linux](https://github.com/Caio-Felice-Cunha/Linux-Operating-System-Docker-and-Kubernetes/tree/main/03%20-%20Networking%20with%20Docker%20and%20Linux)
- [4: Automating Tasks with Bash Script](https://github.com/Caio-Felice-Cunha/Linux-Operating-System-Docker-and-Kubernetes/tree/main/04%20-%20CreatingBash%20Scripts%20for%20Automation)
- [5: Python Application Deployment with Linux and Docker](https://github.com/Caio-Felice-Cunha/Linux-Operating-System-Docker-and-Kubernetes/tree/main/05%20-%20Deploying%20Python%20Applications%20with%20Linux%20and%20Docker)
- You are here! [6: Container Deployment with Docker Compose](https://github.com/Caio-Felice-Cunha/Linux-Operating-System-Docker-and-Kubernetes/tree/main/06%20-%20Container%20Deployment%20with%20Docker%20Compose)
- [7: Container Orchestration with Docker](https://github.com/Caio-Felice-Cunha/Linux-Operating-System-Docker-and-Kubernetes/tree/main/07%20-%20Docker%20Container%20Orchestration)
- NOT YET, BUT SOON [8: Container Orchestration with Kubernetes]()
- NOT YET, BUT SOON [9: Guide for Orchestrating a Machine Learning App]()
- NOT YET, BUT SOON [10: Guide for Orchestrating a Data Engineering Pipeline]()
