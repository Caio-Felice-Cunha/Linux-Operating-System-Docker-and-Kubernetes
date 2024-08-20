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

We will deploy 3 containers with a single command, using Docker Compose, and thus deploy a web application with a database API. These will be the 3 containers:

- Container 1 – Runs the Web App in HTML;
- Container 2 – Runs the API with Node.JS;
- Container 2 – Runs the database with PostgreSQL.

The Web App is what we call the Front-end, what the user accesses and interacts with. The database is what we call the Back-end, where the company's data and business intelligence are stored.

The API is also considered Back-end, but it is responsible for the connection between the Front-end and Back-end (Back-end can be an application, a database or both).

Our app will not have a user interface because our focus here is not on page design but on the process of deploying and orchestrating containers with Docker Compose.

Let's get to work.

We will use a Postgres Docker image as our database.

In addition, I want to run a web application. To achieve this, we'll use Nginx as our base image to serve as the web server. However, I plan to customize it using a Dockerfile to better suit our needs.

Next, we'll need to connect the front-end (Nginx) with the back-end (Postgres) using Node.js.

docker-compose.yml

```bash
version: '3'

services:

  dsa_database:
    container_name: my_database
    hostname: my_database
    image: postgres
    volumes:
      - ./volume:/var/lib/postgresql
    environment:
      - POSTGRES_DB=mydb
      - POSTGRES_USER=justme
      - POSTGRES_PASSWORD=mypasswordhere
    ports:
      - 54321:5432
    restart: unless-stopped
    healthcheck:
      test: "exit 0"

  dsa_api:
    container_name: my_api
    hostname: my_api
    build:
      context: ./my_api
      dockerfile: Dockerfile
    ports:
     - 54322:5000
    volumes:
      - ./my_api/src/:/usr/src/app/
      - /usr/src/app/node_modules
    restart: unless-stopped
    environment:
      NODE_ENV: ${MY_ENVIRONMENT}
    depends_on:
      - my_database

  my_webserver:
      container_name: my_webserver
      hostname: my_webserver
      build:
          context: ./my_webserver
          dockerfile: Dockerfile
      ports:
        - 80:80
      volumes:
        - ./my_webserver/src/test:/usr/share/nginx/html
      restart: always
      depends_on:
        - my_database
```

This code is a `docker-compose.yml` file that defines a multi-container application using Docker Compose. The file specifies the services that will be part of the application, including their configurations, environments, ports, and dependencies. Here's a detailed explanation of each section:

### `version: '3'`

This specifies the version of the Docker Compose file format. Version 3 is commonly used and supports a wide range of Docker Compose features.

### `services:`

This section defines the individual services that make up the application. Each service is a containerized component with its own configuration.

---

### Service 1: `dsa_database`

This service represents the database part of the application using a Postgres container.

- **`container_name: my_database`**
    
    Sets the name of the container as `my_database`.
    
- **`hostname: my_database`**
    
    Sets the hostname inside the Docker network to `my_database`.
    
- **`image: postgres`**
    
    Specifies that the Postgres Docker image will be used to create this container.
    
- **`volumes:`**
    - **`./volume:/var/lib/postgresql`**
    Maps the local directory `./volume` to the container's directory `/var/lib/postgresql`. This allows persistent storage of database data on the host machine.
- **`environment:`**
    - **`POSTGRES_DB=mydb`**
    Creates a database named `mydb` when the Postgres container starts.
    - **`POSTGRES_USER=justme`**
    Sets the username for accessing the Postgres database.
    - **`POSTGRES_PASSWORD=mypasswordhere`**
    Sets the password for the Postgres user `justme`.
- **`ports:`**
    - **`54321:5432`**
    Maps port 54321 on the host machine to port 5432 in the container, allowing external access to the Postgres database.
- **`restart: unless-stopped`**
    
    Configures the container to automatically restart unless it is explicitly stopped by the user.
    
- **`healthcheck:`**
    - **`test: "exit 0"`**
    A health check that always returns a success status. In a real scenario, this would be a command that tests the actual health of the database.

---

### Service 2: `dsa_api`

This service represents the API layer of the application, likely built with Node.js.

- **`container_name: my_api`**
    
    Sets the container name to `my_api`.
    
- **`hostname: my_api`**
    
    Sets the hostname inside the Docker network to `my_api`.
    
- **`build:`**
    - **`context: ./my_api`**
    Specifies the build context directory for the Dockerfile. This means the Dockerfile for this service is located in the `./my_api` directory.
    - **`dockerfile: Dockerfile`**
    Specifies the name of the Dockerfile to use for building the image.
- **`ports:`**
    - **`54322:5000`**
    Maps port 54322 on the host machine to port 5000 in the container, where the API is likely running.
- **`volumes:`**
    - **`./my_api/src/:/usr/src/app/`**
    Maps the local `./my_api/src/` directory to the container's `/usr/src/app/` directory. This allows live code changes in the host to be reflected in the container.
    - **`/usr/src/app/node_modules`**
    This is an anonymous volume that stores `node_modules` separately to avoid overwriting it with the host directory.
- **`restart: unless-stopped`**
    
    Configures the container to automatically restart unless it is explicitly stopped.
    
- **`environment:`**
    - **`NODE_ENV: ${MY_ENVIRONMENT}`**
    Sets the Node.js environment variable `NODE_ENV` using the value from the environment variable `MY_ENVIRONMENT` on the host machine.
- **`depends_on:`**
    - **`my_database`**
    Ensures that the `my_database` service starts before this API service.

---

### Service 3: `my_webserver`

This service represents the web server, likely serving static files and acting as a reverse proxy.

- **`container_name: my_webserver`**
    
    Sets the container name to `my_webserver`.
    
- **`hostname: my_webserver`**
    
    Sets the hostname inside the Docker network to `my_webserver`.
    
- **`build:`**
    - **`context: ./my_webserver`**
    Specifies the build context directory for the Dockerfile. This means the Dockerfile for this service is located in the `./my_webserver` directory.
    - **`dockerfile: Dockerfile`**
    Specifies the name of the Dockerfile to use for building the image.
- **`ports:`**
    - **`80:80`**
    Maps port 80 on the host machine to port 80 in the container, which is typically used for web traffic.
- **`volumes:`**
    - **`./my_webserver/src/test:/usr/share/nginx/html`**
    Maps the local directory `./my_webserver/src/test` to the container's `/usr/share/nginx/html` directory. This allows static files to be served by Nginx.
- **`restart: always`**
    
    Configures the container to always restart if it stops or fails.
    
- **`depends_on:`**
    - **`my_database`**
    Ensures that the `my_database` service starts before this web server service.

---

### Summary

This `docker-compose.yml` file defines a complete multi-service application consisting of a Postgres database (`dsa_database`), an API service (`dsa_api`), and a web server (`my_webserver`). Each service is configured to interact with others via Docker networks, with specific environment variables, volumes for data persistence, and ports for external access. The file ensures that the services are started in the correct order and remain running unless manually stopped.

Let’s see the my_webserver folder.

## Dockerfile

```bash
# Base image
FROM nginx:1.23-alpine

# Remove the default web server configuration file
RUN rm /etc/nginx/conf.d/*

# Copy the file with our settings
COPY ./conf/nginx.conf /etc/nginx/conf.d/
```

This Dockerfile is used to create a custom Docker image for an Nginx web server. Here's a detailed explanation of each line:

### 1. `FROM nginx:1.23-alpine`

- **Purpose**: Specifies the base image for the Docker image you are creating.
- **Details**:
    - `nginx:1.23-alpine` refers to the Nginx web server version 1.23, using the `alpine` variant. The `alpine` variant is a minimal, lightweight version of the image, which is popular for its small size and efficiency. Starting with this base image means you have a fully functional Nginx web server as a foundation.

### 2. `RUN rm /etc/nginx/conf.d/*`

- **Purpose**: Removes the default Nginx configuration files.
- **Details**:
    - The `RUN` command is used to execute commands in the Docker container during the image build process.
    - `rm /etc/nginx/conf.d/*` removes all files in the `/etc/nginx/conf.d/` directory, which is where Nginx stores its configuration files for virtual hosts. By removing these files, you ensure that the default configuration is cleared out, allowing you to replace it with your custom configuration.

### 3. `COPY ./conf/nginx.conf /etc/nginx/conf.d/`

- **Purpose**: Copies your custom Nginx configuration file into the container.
- **Details**:
    - The `COPY` command copies files or directories from your local file system (on your development machine) into the Docker image.
    - `./conf/nginx.conf` refers to a custom Nginx configuration file located in the `conf` directory relative to the location of the Dockerfile on your local machine.
    - `/etc/nginx/conf.d/` is the directory in the container where Nginx looks for configuration files. By copying your `nginx.conf` file here, you're replacing the default configuration with your custom settings.

### Summary

This Dockerfile creates a custom Nginx image by:

1. Using the lightweight Nginx `alpine` image as a base.
2. Removing any default Nginx configuration to avoid conflicts.
3. Replacing the default configuration with a custom Nginx configuration file from your local system.

This setup allows you to define how the Nginx server should behave, such as routing, serving static files, handling proxies, etc., according to your specific needs.

Now, inside the conf folder

## nginx.conf

```bash
server { 
  listen 80;
  server_name frontend;

  location / {
    root /usr/share/nginx/html;
    try_files $uri /index.html;
  }
 
  location /api/ {
    proxy_set_header        X-Real-IP       $remote_addr;
    proxy_set_header        Access-Control-Allow-Origin   *;

    proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header        X-NginX-Proxy   true;
    proxy_pass              http://my_api:5000/;
    proxy_ssl_session_reuse off;
    proxy_set_header        Host            $http_host;
    proxy_cache_bypass      $http_upgrade;
    proxy_redirect          off;
  }
}
```

This `nginx.conf` file is an Nginx server configuration that defines how the server should handle incoming requests. Let's break down each part:

### `server { ... }`

- **Purpose**: This block defines a server configuration. It contains all the settings for handling incoming HTTP requests for a specific domain or IP address.

### `listen 80;`

- **Purpose**: Instructs Nginx to listen for incoming connections on port 80, which is the default port for HTTP traffic.

### `server_name frontend;`

- **Purpose**: Defines the server name or domain name that this configuration will respond to. In this case, `frontend` is used as the server name. This could be a domain like `example.com`, but here it's just a placeholder.

### `location / { ... }`

- **Purpose**: This block defines the behavior for requests to the root path (`/`).

### Inside `location / { ... }`:

- **`root /usr/share/nginx/html;`**
    - **Purpose**: Specifies the root directory for serving static files. In this case, it points to `/usr/share/nginx/html`, which is the standard directory where Nginx serves static content like HTML, CSS, and JavaScript files.
- **`try_files $uri /index.html;`**
    - **Purpose**: This directive attempts to serve the requested file (`$uri`) directly. If the file is not found, Nginx will serve `index.html` instead. This is commonly used in single-page applications (SPAs) where all routes are handled by the front-end, and `index.html` should be served for all non-file routes.

### `location /api/ { ... }`

- **Purpose**: This block defines how requests that start with `/api/` should be handled. Typically, these are requests that need to be forwarded to a back-end API service.

### Inside `location /api/ { ... }`:

- **`proxy_set_header X-Real-IP $remote_addr;`**
    - **Purpose**: Sets the `X-Real-IP` header to the IP address of the client making the request. This allows the backend service to know the original client IP.
- **`proxy_set_header Access-Control-Allow-Origin *;`**
    - **Purpose**: Adds a header to the response that allows all origins (``) to access the resources. This is used for handling Cross-Origin Resource Sharing (CORS) requests.
- **`proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;`**
    - **Purpose**: Appends the client’s IP address to the `X-Forwarded-For` header. This header is used to pass the original client IP address through a series of proxy servers.
- **`proxy_set_header X-NginX-Proxy true;`**
    - **Purpose**: Sets a custom header `X-NginX-Proxy` to `true`. This is often used to indicate that the request is being handled by Nginx as a reverse proxy.
- **`proxy_pass http://my_api:5000/;`**
    - **Purpose**: Forwards the request to the back-end service running at `http://my_api:5000/`. `my_api` is the hostname of the backend service (likely defined in Docker Compose), and port 5000 is where the service is listening.
- **`proxy_ssl_session_reuse off;`**
    - **Purpose**: Disables SSL session reuse. This can be useful if there are issues with SSL session caching, although it's not commonly needed for most configurations.
- **`proxy_set_header Host $http_host;`**
    - **Purpose**: Sets the `Host` header in the request to the value of `$http_host`, which is the original host header from the client request.
- **`proxy_cache_bypass $http_upgrade;`**
    - **Purpose**: Ensures that caching is bypassed for WebSocket or other protocol upgrade requests. The `$http_upgrade` variable is typically set when the client requests an upgrade from HTTP to WebSocket.
- **`proxy_redirect off;`**
    - **Purpose**: Disables automatic HTTP redirects by Nginx. This ensures that URLs in the response are not modified by Nginx.

### Summary

This `nginx.conf` file configures an Nginx server to:

1. Serve static files from the `/usr/share/nginx/html` directory, with a fallback to `index.html` for any non-file routes, which is ideal for single-page applications.
2. Proxy API requests that begin with `/api/` to a back-end service running on `http://my_api:5000/`.
3. Set appropriate headers for client IP forwarding, CORS handling, and other proxy-related tasks to ensure proper communication between the front-end and back-end services.

Just to finish, open the src folder, than text, we have our index.html file. It's a simple file. No need of explanations here.


