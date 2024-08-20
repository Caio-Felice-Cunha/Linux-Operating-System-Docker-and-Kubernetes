# When to Use Docker Compose?
Docker Compose is a Docker tool used to define and run applications that require multiple containers. With Compose, you can configure the services of an application using a YAML file and create all the necessary services from this configuration, each running in its own Docker container.

Think of Docker Compose as an automated workflow for managing multiple containers. It's a powerful tool for development, testing, CI (Continuous Integration) workflows, and even production environments. Docker Compose is installed when you set up Docker Desktop, but it can also be installed separately, just like Docker itself.

Here’s the documentation for Docker Compose:
[Docker Compose Documentation](https://docs.docker.com/compose/)

For installation details (if you've installed Docker Desktop, Compose is already available):
[Installation Instructions](https://docs.docker.com/compose/install/)

Some of the most popular features of Docker Compose include:

- Managing multiple isolated environments on a single host.
- Preserving data in volumes when containers are created or destroyed.
- Recreating only the containers that have been updated.
- Transferring variables between environments in a composition.
- Orchestrating multiple containers that work together on the same host machine.

Regarding the last feature, here are some important points to keep in mind:

1. We use a Dockerfile to create a custom image and, from that image, create one or more containers.
2. We use Docker Compose to create multiple containers on the same host machine, each container having its own Dockerfile or an image from Docker Hub. Docker Compose handles the orchestration of these containers on the same machine.
3. For orchestrating containers across multiple host machines, we use Docker Swarm or Kubernetes.

The process for using Docker Compose is as follows:

1. Determine how many containers are needed (e.g., one container for a web application and another for a database).
2. Create a Dockerfile (or specify the image to be used) for each container.
3. Create a `docker-compose.yaml` file with the parameters for each container, including how data persistence (such as for the database) will be handled.
4. Run the `docker compose up` command to initialize the stack (the group of containers) and `docker compose down` to stop it. Use `docker compose up -d` to keep the stack running in the background.
5. Access your application.

# Deploy 01: Stack for Deploying Web Apps with Python and Redis

We are going to deploy two containers with a single command using Docker Compose, allowing us to deploy a web application seamlessly. These are the two containers we'll be working with:

- **Container 1**: Runs a Python application using the Flask web framework.
- **Container 2**: Runs Redis, an in-memory data store.

Redis is a fully open-source key-value storage system that operates as a data server. 

You can find the official Redis image on Docker Hub: [Redis on Docker Hub](https://hub.docker.com/_/redis). 

Additionally, here’s the official Redis website: [Redis Official Site](https://redis.io/).

Redis provides in-memory data structures and specific operators to manage data in real-time at scale and speed. Originally designed as a cache database, Redis has since evolved into a primary database. Many modern applications now use Redis as their primary database due to its performance. However, most Redis service providers support Redis as a cache, not as a primary database.

Our Python application will generate an automatic counter each time you access the application through a web browser and will record this count in Redis in real-time. Let's get started! 

### Explanning the code

For the first container (Python App) we are going to use Dockerfile (because we want to customize our image for our Python app).

When treating with the second container (Redis), I do not want to customize the container.

### docker-compose.yml

```bash
version: "3.9"

services:

  web:
    build: .
    ports:
      - "8000:5000"

  redis:
    image: "redis:alpine"
```

This code is a `docker-compose.yml` file written in YAML (Yet Another Markup Language). It defines and manages multiple services for a Docker application, making it easier to build, run, and manage multi-container Docker applications.

#### Breakdown of the Code

1. **`version: "3.9"`**:
    - This specifies the version of the Docker Compose file format being used. Docker Compose is a tool for defining and running multi-container Docker applications, and the version number defines the syntax and features that can be used in the file. Version "3.9" is one of the more recent versions, supporting a range of features and configurations.
2. **`services:`**:
    - This section defines the different services (containers) that make up the application. In this file, there are two services: `web` and `redis`.
3. **`web:`**:
    - **`build: .`**:
        - This tells Docker Compose to build the Docker image for this service using the Dockerfile located in the current directory (`.`). The Dockerfile will contain the instructions to create the environment for the web service (e.g., installing dependencies, copying application files, etc.).
    - **`ports:`**:
        - This maps network ports between the host machine and the container. The format is `"host_port:container_port"`.
        - **`"8000:5000"`**:
            - This maps port 8000 on the host machine to port 5000 inside the container. This means that when you access `http://localhost:8000` on your host machine, the request is forwarded to port 5000 in the `web` container, where the web application is expected to be running.
4. **`redis:`**:
    - **`image: "redis:alpine"`**:
        - This specifies that the `redis` service should be built from the `redis:alpine` Docker image. This image is a lightweight version of Redis (an in-memory data structure store) based on the Alpine Linux distribution. Redis is often used as a cache or message broker in web applications.

#### Summary

This Docker Compose file defines a simple multi-container application with two services:

- **`web`**: A custom service built from a Dockerfile in the current directory, with a web application accessible on port 8000.
- **`redis`**: A Redis service using the official lightweight Alpine-based image.

The application can be started by running `docker-compose up` in the directory containing this `docker-compose.yml` file, which will build and start both services, allowing them to work together within a Docker environment.

### Dockerfile

```bash
# Create image from Alpine version with Python 3.9
FROM python:3.9-alpine

# Workbook
WORKDIR /code

# Environment variable with the app file
ENV FLASK_APP=app.py

# Environment variable with the ip for the app
ENV FLASK_RUN_HOST=0.0.0.0

# Installs additional packages on the OS
RUN apk add --no-cache gcc musl-dev linux-headers

# Copies the requirements file from the host machine to the container
COPY requirements.txt requirements.txt

# Install the dependencies
RUN pip install -r requirements.txt

# Door Expose 5000
EXPOSE 5000

# Copy files from the host to the container
COPY . .

# Run the app with Flask
CMD ["flask", "run"]
```

This is a `Dockerfile`, which is a script containing a series of instructions used to build a Docker image. A Docker image is a lightweight, standalone, and executable software package that includes everything needed to run a piece of software, including the code, runtime, libraries, environment variables, and configurations.

Let's break down each line of the `Dockerfile`:

##### 1. **`FROM python:3.9-alpine`**

- **Base Image**:
    - This line specifies the base image for the Docker container, which is `python:3.9-alpine`. This is a lightweight version of Python 3.9 running on Alpine Linux, a minimalistic and security-oriented Linux distribution. Using a minimal base image reduces the size of the final Docker image.

##### 2. **`WORKDIR /code`**

- **Working Directory**:
    - This sets the working directory inside the container to `/code`. All subsequent commands that operate on files (e.g., `COPY`, `RUN`) will be executed relative to this directory. If the directory does not exist, it will be created.

##### 3. **`ENV FLASK_APP=app.py`**

- **Environment Variable**:
    - This sets the environment variable `FLASK_APP` to `app.py`, which tells Flask that `app.py` is the main application file to run. This is necessary for Flask to identify the entry point of your application.

##### 4. **`ENV FLASK_RUN_HOST=0.0.0.0`**

- **Environment Variable**:
    - This sets the `FLASK_RUN_HOST` environment variable to `0.0.0.0`, which configures Flask to listen on all available IP addresses in the container. This is essential for making the Flask application accessible from outside the container.

##### 5. **`RUN apk add --no-cache gcc musl-dev linux-headers`**

- **Installing Additional Packages**:
    - `RUN` executes a command in the container during the build process.
    - `apk add` is used to install packages in Alpine Linux. The `-no-cache` flag prevents the caching of the package index, reducing the size of the final image.
    - The packages installed are:
        - `gcc`: The GNU Compiler Collection, needed to compile certain Python packages.
        - `musl-dev`: A lightweight, standard C library for Linux-based systems.
        - `linux-headers`: Header files for the Linux kernel, often required to compile C extensions for Python packages.

##### 6. **`COPY requirements.txt requirements.txt`**

- **Copying Files**:
    - This copies the `requirements.txt` file from the host machine (where you run the Docker build) into the container’s working directory (`/code`). The `requirements.txt` file typically lists the Python packages needed by the application.

##### 7. **`RUN pip install -r requirements.txt`**

- **Installing Python Dependencies**:
    - This runs the `pip install` command inside the container to install the Python packages listed in `requirements.txt`. This ensures that all necessary dependencies are available for the application to run.

##### 8. **`EXPOSE 5000`**

- **Exposing a Port**:
    - This tells Docker that the container will listen on port 5000 at runtime. While this doesn't actually publish the port (which is done with `docker run -p`), it serves as documentation and can be used by Docker in certain network configurations.

##### 9. **`COPY . .`**

- **Copying Files**:
    - This copies all the files and directories from the current directory on the host machine into the current working directory (`/code`) in the container. This includes your application code and any other necessary files.

##### 10. **`CMD ["flask", "run"]`**

- **Default Command**:
    - This specifies the default command to run when the container starts. Here, it instructs Docker to run `flask run`, which starts the Flask development server. This command uses the `FLASK_APP` and `FLASK_RUN_HOST` environment variables set earlier to determine which app to run and where to listen.

#### Summary

This `Dockerfile` creates a Docker image for a Python Flask application. It starts with a minimal Alpine Linux-based Python environment, installs the necessary system and Python dependencies, copies the application code into the container, and finally, sets up the environment to run the Flask application on port 5000. When the container is run, the Flask app will be accessible on port 5000 of the container, which can be mapped to a port on the host machine.

### app.py

```bash
# Imports
import time
import redis
from flask import Flask

# Create the Flask app
app = Flask(__name__)

# Connect to Redis host
cache = redis.Redis(host='redis', port=6379)

# Create a function to count accesses
def get_hit_count():
    retries = 5
    while True:
        try:
            return cache.incr('hits')
        except redis.exceptions.ConnectionError as exc:
            if retries == 0:
                raise exc
            retries -= 1
            time.sleep(0.5)

# Create the root route with the hello function
@app.route('/')
def hello():

    # Get the count
    mycounter = get_hit_count()

    # Check the counter
    if mycounter == 1:
        counting = 'Success! This page has been accessed {} times.\n'.format(mycounter)
    else:
        counting = 'Success! This page has been accessed {} times.\n'.format(mycounter)

    return counting
```

This Python script is a simple web application built using the Flask framework. It demonstrates how to connect to a Redis database to keep track of the number of times the root page of the application has been accessed. Let's go through the code in detail:

##### 1. **Imports**

```python
import time
import redis
from flask import Flask

```

- **`time`**: This is a standard Python module that provides various time-related functions, such as pausing the execution of the code (`time.sleep()`).
- **`redis`**: This is the Python Redis client library, which allows the application to interact with a Redis database.
- **`Flask`**: This is the web framework used to create the web application.

##### 2. **Create the Flask app**

```python
app = Flask(__name__)

```

- This line creates an instance of the Flask class, which represents the web application. The `__name__` argument helps Flask determine the root path of the application, which is useful for loading templates and static files.

##### 3. **Connect to Redis host**

```python
cache = redis.Redis(host='redis', port=6379)

```

- This line creates a connection to a Redis server.
    - **`host='redis'`**: This specifies the hostname of the Redis server. In a Docker setup, the Redis service might be running in a separate container named `redis`, which is why the hostname is set to `'redis'`.
    - **`port=6379`**: This is the default port on which the Redis server listens.

##### 4. **Create a function to count accesses**

```python
def get_hit_count():
    retries = 5
    while True:
        try:
            return cache.incr('hits')
        except redis.exceptions.ConnectionError as exc:
            if retries == 0:
                raise exc
            retries -= 1
            time.sleep(0.5)

```

- **`get_hit_count()`** is a function that increments a counter in Redis each time it is called. This counter tracks the number of times the root page has been accessed.
    - **`retries = 5`**: This sets a retry limit to handle potential connection errors when interacting with Redis.
    - **`while True:`**: This loop keeps trying to increment the counter until it succeeds or the retry limit is reached.
    - **`cache.incr('hits')`**: This line attempts to increment the value stored at the key `'hits'` in the Redis database. If the key does not exist, Redis will create it with an initial value of 0 and then increment it.
    - **`except redis.exceptions.ConnectionError as exc:`**: If a connection error occurs, the function catches the exception and retries up to 5 times, with a 0.5-second pause between each attempt (`time.sleep(0.5)`).

##### 5. **Create the root route with the hello function**

```python
@app.route('/')
def hello():
    mycounter = get_hit_count()
    if mycounter == 1:
        counting = 'Success! This page has been accessed {} times.\\n'.format(mycounter)
    else:
        counting = 'Success! This page has been accessed {} times.\\n'.format(mycounter)
    return counting

```

- **`@app.route('/')`**: This decorator defines a route for the root URL (`/`). When a user accesses the root URL of the application, the `hello()` function is executed.
- **`mycounter = get_hit_count()`**: This line calls the `get_hit_count()` function to increment the counter and retrieve the current number of accesses.
- **`if mycounter == 1:`**: The script checks if the counter is 1, which would mean this is the first access to the page.
- **`counting = 'Success! This page has been accessed {} times.\\n'.format(mycounter)`**: This line formats a string with the current value of the counter and assigns it to the `counting` variable.
- **`return counting`**: The function returns the `counting` string, which is sent as the HTTP response to the client.

#### Summary

This script is a simple Flask web application that connects to a Redis database to track the number of times the root page (`/`) has been accessed. Each time the page is visited, the `get_hit_count()` function increments a counter in Redis, and the current count is displayed on the page. The application also handles potential Redis connection issues by retrying the connection a few times before raising an exception. This is a typical example of how microservices might interact in a distributed system, with Flask handling the web server duties and Redis serving as a lightweight, fast data store.

## Let's Go

`cd C:/Users/Caio/Downloads/mydeployments/deploy1`

`docker compose up` → THIS COMMAND SHOULD BE RUNNED IN THE SAME FOLDER OF THE YML FILE

![image](https://github.com/user-attachments/assets/0a094a70-aed7-4033-b606-de5a3fca25c2)

Access the app `localhost:8000`

![image](https://github.com/user-attachments/assets/1112de47-5ff0-4f45-a0ff-821ad1a6f0cd)

`ctrl + c` to stop the app

`docker compose down` to delete the containers (compose)

![image](https://github.com/user-attachments/assets/e850cb32-c51d-4810-bda8-ce40c1acc0c4)


`docker compose up -d` if you want to run in the background

## CI/CD

Now, let's say you need to make changes to your application. What now?

Go to the file "app.py" and change the text "Success! This page has been accessed" to anything you want, and go back to the app to see if something changed.

In this case, if you did the same as above, you will have to stop your application and remap everything again from scratch.

Now, imagine that every time you want to update, you will have to do this. It would be a huge headache.

However, we have a solution for you, because Docker allows CI/CD

**CI/CD** stands for **Continuous Integration** and **Continuous Deployment/Continuous Delivery**. It's a set of practices used in software development to automate the process of integrating code changes, testing, and deploying applications, leading to more efficient and reliable software delivery.

### 1. **Continuous Integration (CI)**
   - **What is CI?**
     - Continuous Integration is a practice where developers frequently integrate their code changes into a shared repository, typically multiple times a day. Each integration is automatically verified by building the application and running a series of tests to detect integration errors as quickly as possible.

   - **Key Components of CI:**
     - **Automated Builds**: Every time a developer commits code to the repository, the CI system automatically builds the software. This ensures that the new code is compatible with the existing codebase.
     - **Automated Testing**: After building the application, automated tests (unit tests, integration tests, etc.) are run to ensure that the new changes do not break existing functionality.
     - **Early Detection of Issues**: By integrating frequently and running automated tests, issues can be detected early, making them easier and less costly to fix.

   - **Benefits of CI:**
     - Early detection of bugs and integration issues.
     - Faster feedback on code quality.
     - Encourages frequent code commits and collaboration.

### 2. **Continuous Deployment (CD)**
   - **What is CD?**
     - Continuous Deployment is an extension of Continuous Integration. It refers to automatically deploying every change that passes the CI process to production, without any manual intervention. The goal is to ensure that the code in the main branch is always in a deployable state and that updates can be released to users quickly and reliably.

   - **Key Components of Continuous Deployment:**
     - **Automated Deployment**: The system automatically deploys the application to production or other environments after it passes the CI pipeline.
     - **Monitoring**: Once the application is deployed, continuous monitoring is essential to detect any issues in the live environment.
     - **Rollback Mechanisms**: In case of deployment failures, automated rollback mechanisms are often put in place to revert to the last stable version.

   - **Benefits of Continuous Deployment:**
     - Faster release cycles and quicker delivery of features and fixes.
     - Reduces the risk of deployment errors due to automation.
     - Provides immediate feedback from production, enabling rapid iteration and improvement.

### 3. **Continuous Delivery (CD)**
   - **What is CD?**
     - Continuous Delivery is similar to Continuous Deployment but with a key difference: in Continuous Delivery, the deployment to production is not automated. Instead, the application is automatically deployed to a staging environment, where it is ready for manual approval before being released to production. This approach is often used when organizations require additional manual checks or approvals before releasing software.

   - **Key Components of Continuous Delivery:**
     - **Automated Testing and Deployment to Staging**: The application is built, tested, and deployed to a staging environment automatically.
     - **Manual Approval**: After deployment to staging, a manual step is required to review and approve the release to production.
     - **Deployment Pipelines**: Tools like Jenkins, GitLab CI, or CircleCI are used to create and manage deployment pipelines.

   - **Benefits of Continuous Delivery:**
     - Reduces the risk of issues in production by allowing for manual review.
     - Ensures that the software is always in a release-ready state.
     - Provides a balance between automation and control.

### CI/CD Pipeline

A **CI/CD pipeline** is a series of steps that code changes go through to move from development to production. The pipeline typically includes:
- **Source Control Integration**: Code is pulled from a version control system like Git.
- **Build Stage**: The application is compiled, and dependencies are installed.
- **Testing Stage**: Automated tests are run to validate the code.
- **Deployment Stage**: The application is deployed to staging or production environments.
- **Monitoring**: Once deployed, the application is monitored for performance, errors, and user feedback.

### Summary

**CI/CD** aims to increase development efficiency and improve software quality by automating the integration, testing, and deployment processes. CI focuses on integrating code frequently with automated testing, while CD extends this by automating the deployment process, either to staging (Continuous Delivery) or directly to production (Continuous Deployment).

## Let's CI/CD THIS!
First, stop everything and delete all of your containers that were created for this lab. Also, delete the images and volumes. You must start form the beginning.

![image](https://github.com/user-attachments/assets/cb76d935-b2b3-4389-8c5c-edd296f6a013)

First, change the name of the file "docker-compose.yml" to "docker-compose.yml_v1".

Now, the "docker-compose.yml_v2" to "docker-compose.yml".

![image](https://github.com/user-attachments/assets/2fe042db-6021-46bc-950a-6c2c364e3d5e)

Go back to your command prompt line and run the command `docker compose up`

```bash
version: "3.9"

services:

  web:
    build: .
    ports:
      - "8000:5000"
    volumes:
      - .:/code
    environment:
      FLASK_DEBUG: True

  redis:
    image: "redis:alpine"
```

This `docker-compose.yml` file defines a multi-container Docker application that consists of a web service and a Redis service. The file uses version 3.9 of the Docker Compose syntax and provides configurations for building, running, and managing these services.

### Breakdown of the Code

1. **`version: "3.9"`**
    - This specifies the version of the Docker Compose file format being used. Version 3.9 is a recent version that supports a variety of features for managing multi-container applications.
2. **`services:`**
    - This section defines the individual services (containers) that make up the application. In this case, there are two services: `web` and `redis`.

### Web Service

1. **`web:`**
    - This section defines the configuration for the `web` service, which likely hosts a web application.
    - **`build: .`**
        - This tells Docker Compose to build the Docker image for the `web` service using the Dockerfile located in the current directory (`.`). The Dockerfile contains instructions on how to set up the environment for the web service, including installing dependencies and copying application files.
    - **`ports:`**
        - This maps network ports between the host machine and the container.
        - **`"8000:5000"`**:
            - This line maps port 8000 on the host machine to port 5000 in the `web` container. This means that when you access `http://localhost:8000` on your host machine, the request is forwarded to port 5000 inside the container, where the web application is running.
    - **`volumes:`**
        - Volumes are used to share files and directories between the host machine and the container.
        - **`.:/code`**:
            - This line maps the current directory (`.`) on the host machine to the `/code` directory in the container. This allows for live code changes on the host to be reflected immediately inside the container. This is especially useful during development, as it enables real-time updates without needing to rebuild the container every time a change is made.
    - **`environment:`**
        - This section allows you to set environment variables within the container.
        - **`FLASK_DEBUG: True`**:
            - This sets the `FLASK_DEBUG` environment variable to `True`, enabling Flask's debug mode. When debug mode is enabled, Flask provides detailed error messages and automatically reloads the application when code changes are detected. This is very useful during development.

### Redis Service

1. **`redis:`**
    - This section defines the configuration for the `redis` service, which provides a Redis database that the web application can use for caching, session management, or other purposes.
    - **`image: "redis:alpine"`**
        - This specifies that the `redis` service should be built from the `redis:alpine` Docker image. `redis:alpine` is a lightweight version of the Redis image, based on the Alpine Linux distribution. It's a popular choice for environments where minimizing the size of the image is important.

### Summary

This `docker-compose.yml` file describes a simple development environment with two services:

- **`web`**: This service builds a Docker container from a Dockerfile in the current directory. It exposes the web application on port 8000, mounts the current directory into the container to allow for live updates during development, and enables Flask's debug mode.
- **`redis`**: This service uses a lightweight Redis image based on Alpine Linux, providing an in-memory data store that the `web` service can use.

The setup is ideal for developing a Flask web application that relies on Redis, allowing for efficient development with real-time code updates and an integrated debug mode.

### NOW YOU CAN GO TO THE APP.PY AND CHANGE THE MESSAGE. YOUR APP WILL UPDATE IN REAL TIME.
### THIS IS CI/CD IN PRACTICE!





# Deploy 02: Stack for Deploying Web App, API and Database
