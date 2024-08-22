# Explaning the files content
### File: app.py

```json
# Imports
import time
import redis
from flask import Flask

# Create the Flask app
app = Flask(__name__)

# Connect to Redis host
cache = redis.Redis(host='mydb', port=6379)

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

The code you've provided is a simple web application using Flask and Redis to track the number of times the root page (`/`) has been accessed. Let's break it down step by step:

##### 1. **Imports**

```python
import time
import redis
from flask import Flask

```

- **time**: This module provides various time-related functions, such as delays.
- **redis**: This is a Python client for Redis, which is an in-memory data structure store often used as a database, cache, and message broker.
- **Flask**: Flask is a micro web framework written in Python that allows you to build web applications.

#### 2. **Create the Flask app**

```python
app = Flask(__name__)

```

- **app**: This line creates an instance of the Flask class. This instance becomes the WSGI application that can be run by a WSGI server.

#### 3. **Connect to Redis host**

```python
cache = redis.Redis(host='mydb', port=6379)

```

- **cache**: This line establishes a connection to a Redis server. The server is assumed to be running on a host named `mydb` at port `6379` (which is the default port for Redis). This connection is used to interact with Redis, such as incrementing counters or retrieving values.

#### 4. **Create a function to count accesses**

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

- **get_hit_count()**: This function is designed to increment a counter in Redis and handle potential connection errors.
    - **retries = 5**: The function allows for up to 5 retries in case the Redis server is temporarily unavailable.
    - **cache.incr('hits')**: This line increments the value of the key `'hits'` in Redis. If the key does not exist, it is created and set to 1. The function returns the new value of `'hits'`.
    - **redis.exceptions.ConnectionError**: This block catches a connection error. If the Redis server is unavailable, it retries up to 5 times, with a 0.5-second delay between each retry (`time.sleep(0.5)`).
    - **raise exc**: If all retries fail, the exception is raised, which will cause the program to crash, signaling an issue that needs addressing.

#### 5. **Create the root route with the hello function**

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

- **@app.route('/')**: This decorator defines the route for the root URL (`/`). When a user visits this URL, the `hello()` function is called.
- **hello()**: This function is executed when the root URL is accessed.
    - **mycounter = get_hit_count()**: This line calls the `get_hit_count()` function to retrieve and increment the current hit count.
    - **counting = 'Success! This page has been accessed {} times.\n'.format(mycounter)**: A message is created indicating how many times the page has been accessed.
    - **return counting**: The message is returned to the user's browser as a response.

#### 6. **Redundant Conditional**

```python
if mycounter == 1:
    counting = 'Success! This page has been accessed {} times.\\n'.format(mycounter)
else:
    counting = 'Success! This page has been accessed {} times.\\n'.format(mycounter)

```

- This block is redundant since both the `if` and `else` branches produce the same output. You can simplify it by removing the `if-else` structure altogether.

#### Summary

- The application is a simple Flask web app that connects to a Redis instance.
- Every time someone accesses the root URL (`/`), the `hello()` function increments the `'hits'` counter in Redis and returns a message showing how many times the page has been accessed.
- The code is designed to handle temporary Redis connection issues by retrying up to 5 times before failing.

### File: docker-compose.yml

```json
version: "3.9"

services:

  web:
    build:
      context: .
      dockerfile: Dockerfile.app
    image: Orchestration-web:v1

  redis:
    build:
      context: .
      dockerfile: Dockerfile.db

  web2:
    build:
      context: .
      dockerfile: Dockerfile.app
    volumes:
      - .:/code
    image: Orchestration-web:v2
```

The `docker-compose.yml` file you provided is used to define and manage multi-container Docker applications. It allows you to define services, networks, and volumes that make up your application in a single YAML file. This specific file sets up a Docker application with three services: `web`, `redis`, and `web2`. Let’s break down each part of this file.

#### 1. **Version**

```yaml
version: "3.9"

```

- **version: "3.9"**: This specifies the version of the Docker Compose file format being used. Version 3.9 is one of the newer versions, supporting a wide range of features, including configurations for more advanced networking and volume management.

#### 2. **Services**

```yaml
services:

```

- **services**: This section defines the different services that will run as containers in your application. Each service can be thought of as a containerized application or component within your system.

#### 3. **Service 1: web**

```yaml
  web:
    build:
      context: .
      dockerfile: Dockerfile.app
    image: Orchestration-web:v1

```

- **web**: This defines the first service, named `web`.
    - **build**: This section specifies how the Docker image for this service should be built.
        - **context: .**: The build context is set to the current directory (`.`). This is where Docker will look for the `Dockerfile.app` and any other files it needs to build the image.
        - **dockerfile: Dockerfile.app**: This specifies that Docker should use the `Dockerfile.app` file (located in the build context) to build the image for this service.
    - **image: Orchestration-web:v1**: Once built, the image will be tagged as `Orchestration-web:v1`. This image can be reused later without rebuilding.

#### 4. **Service 2: redis**

```yaml
  redis:
    build:
      context: .
      dockerfile: Dockerfile.db

```

- **redis**: This defines the second service, named `redis`.
    - **build**: Similar to the `web` service, this section specifies how to build the Docker image for this service.
        - **context: .**: The build context is again set to the current directory.
        - **dockerfile: Dockerfile.db**: This specifies that Docker should use the `Dockerfile.db` file (located in the build context) to build the image for this service.

#### 5. **Service 3: web2**

```yaml
  web2:
    build:
      context: .
      dockerfile: Dockerfile.app
    volumes:
      - .:/code
    image: Orchestration-web:v2

```

- **web2**: This defines the third service, named `web2`.
    - **build**: Similar to the other services, this section specifies how to build the Docker image for this service.
        - **context: .**: The build context is again set to the current directory.
        - **dockerfile: Dockerfile.app**: This service also uses the `Dockerfile.app` file to build its image, just like the `web` service. However, it will result in a different image because it's tagged differently.
    - **volumes**:
        - **.-:/code**: This mounts the current directory (`.`) on the host machine to the `/code` directory inside the container. This allows you to share files between the host and the container, which can be useful for development, as changes made to files on the host will be reflected in the container immediately.
    - **image: Orchestration-web:v2**: Once built, the image will be tagged as `Orchestration-web:v2`.

#### **Summary**

- **web**: This service is built using `Dockerfile.app` and is tagged as `Orchestration-web:v1`.
- **redis**: This service is built using `Dockerfile.db`, which is likely configured for the Redis server.
- **web2**: This service is similar to the `web` service but includes a volume mapping to share files between the host and container. It is tagged as `Orchestration-web:v2`.

#### **Use Case**

- **web and web2**: These could represent two different versions or configurations of a web application, allowing you to run them in parallel or compare different setups.
- **redis**: This is likely the database or cache layer, specifically using Redis, which can be used by both `web` and `web2` services.

This setup is useful for running different environments (e.g., testing, staging, production) simultaneously or for easily switching between different versions of an application by simply changing the service name or image tag.

### File: Dockerfile.app

```json
# Create image from Alpine version with Python 3.9
FROM python:3.9-alpine

# Workbook
WORKDIR /code

# Environment variable with the app file
ENV FLASK_APP=app.py

# Environment variable with the ip for the app
ENV FLASK_RUN_HOST=0.0.0.0

# Install additional packages on the OS
RUN apk add --no-cache gcc musl-dev linux-headers

# Copy the requirements file from the host machine to the container
COPY requirements.txt requirements.txt

# Install dependencies
RUN pip install -r requirements.txt

# Expose of post 5000
EXPOSE 5000

# Copy files from the host to the container
COPY . .

# Run the app with Flask
CMD ["flask", "run"]
```

The `Dockerfile.app` you provided is used to create a Docker image for a Python-based Flask application. This file specifies all the steps required to set up an environment where the application can run. Let’s break it down in detail:

#### 1. **Base Image**

```
FROM python:3.9-alpine

```

- **FROM python:3.9-alpine**: This line sets the base image for the Docker image you are building.
    - **python:3.9-alpine**: This is a lightweight version of Python 3.9, based on the Alpine Linux distribution. Alpine images are minimalistic, making the resulting Docker image smaller and more efficient.

#### 2. **Set the Working Directory**

```
WORKDIR /code

```

- **WORKDIR /code**: This command sets the working directory inside the container to `/code`. All subsequent commands (like `COPY`, `RUN`, etc.) will be executed relative to this directory. If the directory does not exist, it will be created.

#### 3. **Set Environment Variables**

```
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

```

- **ENV FLASK_APP=[app.py](http://app.py/)**: This environment variable tells Flask which file to use as the application entry point. In this case, `app.py` is set as the main application file.
- **ENV FLASK_RUN_HOST=0.0.0.0**: This environment variable specifies the host IP address where the Flask app will listen. `0.0.0.0` makes the application accessible externally by binding it to all available IP addresses within the container.

#### 4. **Install Additional Packages**

```
RUN apk add --no-cache gcc musl-dev linux-headers

```

- **RUN apk add --no-cache gcc musl-dev linux-headers**: This command installs additional packages necessary for compiling Python dependencies that require C extensions (like some libraries in the `requirements.txt`).
    - **apk**: The package manager for Alpine Linux.
    - **-no-cache**: Prevents `apk` from caching the index of available packages, saving space.
    - **gcc**: The GNU Compiler Collection, essential for compiling C code.
    - **musl-dev**: Musl is a lightweight implementation of the standard library for Linux-based systems. The `dev` package includes development headers.
    - **linux-headers**: Essential header files for the Linux kernel, needed to compile some Python packages.

#### 5. **Copy the Requirements File**

```
COPY requirements.txt requirements.txt

```

- **COPY requirements.txt requirements.txt**: This command copies the `requirements.txt` file from your host machine (where you run `docker build`) to the working directory (`/code`) inside the container. This file typically contains a list of Python packages that need to be installed.

#### 6. **Install Python Dependencies**

```
RUN pip install -r requirements.txt

```


- **RUN pip install -r requirements.txt**: This command installs the Python packages specified in `requirements.txt`. `pip` is the Python package installer.

#### 7. **Expose a Port**

```
EXPOSE 5000

```

- **EXPOSE 5000**: This tells Docker that the container will listen on port 5000 at runtime. This is the default port Flask uses when running in development mode. Exposing the port does not publish it to the host machine by itself but documents the intended port.

#### 8. **Copy Application Files**

```
COPY . .

```

- **COPY . .**: This command copies all files and directories from the current directory on the host machine to the working directory (`/code`) inside the container. This includes your `app.py` and any other necessary files for the application to run.

#### 9. **Run the Flask Application**

```
CMD ["flask", "run"]

```

- **CMD ["flask", "run"]**: This command specifies the default command to run when the container starts. In this case, it runs the Flask application using the command `flask run`. This will start the Flask development server on port 5000, using the settings defined by the environment variables.

#### **Summary**

- The `Dockerfile.app` creates a lightweight, isolated environment to run a Flask web application using Python 3.9 on an Alpine Linux base image.
- It sets up the working directory, installs necessary system dependencies, and then installs the Python dependencies from `requirements.txt`.
- The Flask application is configured to run on all available IPs inside the container on port 5000.
- Finally, the application files are copied into the container, and the Flask server is started when the container runs.

This setup ensures that the application runs consistently across different environments, which is especially useful for development, testing, and production deployments.

### File: Dockerfile.db

```json
# Create image from Alpine version of Redis
FROM "redis:alpine"
```

#### File: requirements.txt

```json
flask
redis
```




# Let's go 

## In your command line (prompt), type this commands bellow. You will also find a brief explanations for each command.


### 1. **Building Docker Images**

```bash
docker-compose build
```

- **Purpose:** This command is used to build the Docker images as specified in the `docker-compose.yml` file. Docker Compose reads the file, pulls the base images, and executes any specified instructions (like installing dependencies, copying files, etc.) to create the final image.
- **Context:** In this case, you're creating the images for the app you used in [06 - Container Deployment with Docker Compose](https://github.com/Caio-Felice-Cunha/Linux-Operating-System-Docker-and-Kubernetes/tree/main/06%20-%20Container%20Deployment%20with%20Docker%20Compose), which will later be used in the swarm.
- **Note:** If the images do not appear in Docker Desktop, restarting the application can help refresh the view.

### 2. **Initializing a Docker Swarm**

```bash
docker swarm init
```

- **Purpose:** This command initializes a new Docker Swarm, turning the Docker Engine on your current machine into a swarm manager.
- **Swarm Mode:** Swarm mode is a Docker feature that allows you to manage a cluster of Docker Engines, providing native orchestration and clustering capabilities. A swarm consists of multiple Docker nodes (machines running Docker), with one or more being managers and others being workers.
- **Cluster Management:** Once the swarm is initialized, your current machine becomes the manager, capable of orchestrating services across multiple worker nodes.

### 3. **Creating a Docker Overlay Network**

```bash
docker network create --driver overlay orchestration
```

- **Purpose:** This command creates a new network using Docker's overlay driver. The overlay network allows containers running on different Docker nodes (within the swarm) to communicate with each other securely.
- **Overlay Network:** An overlay network extends across all nodes in the swarm, enabling communication between containers even if they are running on different physical or virtual machines.
- **Use Case:** The network named `orchestration` will be used by the services you define, allowing them to communicate seamlessly within the swarm.

### 4. **Creating a Service for the Web Application**

```bash
docker service create --name mywebapp --network orchestration --replicas 3 -p 8000:5000 orchestration-web:v1
```

- **Service Creation:** This command creates a new service within the swarm.
- **Options Breakdown:**
  - `--name mywebapp`: Names the service "mywebapp."
  - `--network orchestration`: Connects the service to the `orchestration` network created earlier.
  - `--replicas 3`: Ensures that three instances (replicas) of this service will be running at all times.
  - `-p 8000:5000`: Maps port 8000 on the host machine to port 5000 inside the container, making the web application accessible on `http://localhost:8000`.
  - `orchestration-web:v1`: Specifies the image to be used for the service. This is the first version (`v1`) of the web application image.
- **Result:** The service ensures that three instances of your web application are running and accessible via port 8000 on the host machine.

### 5. **Creating a Redis Database Service**

```bash
docker service create --name mydb --network orchestration --replicas 3 orchestration-redis
```

- **Service Creation:** Similar to the web application service, this command creates a service for the Redis database.
- **Options Breakdown:**
  - `--name mydb`: Names the service "mydb."
  - `--network orchestration`: Connects the service to the `orchestration` network.
  - `--replicas 3`: Ensures three instances of the Redis service are running.
  - `orchestration-redis`: Specifies the image to be used for this service (a custom or official Redis image).
- **Result:** The service guarantees that three instances of the Redis database are always running within the swarm, connected to the same network as the web application.

### 6. **Scaling the Web Application**

```bash
docker service scale mywebapp=5
```

- **Purpose:** This command increases the number of replicas (instances) of the `mywebapp` service from 3 to 5.
- **Dynamic Scaling:** Docker Swarm automatically launches the additional replicas across the swarm, ensuring load balancing and redundancy.
- **Use Case:** Scaling is often required to handle increased traffic, ensuring that the application can serve more requests simultaneously.

### 7. **Updating the Web Application Image**

```bash
docker service update --image orchestration-web:v2 mywebapp
```

- **Purpose:** This command updates the running `mywebapp` service to use a new version of the image, `orchestration-web:v2`.
- **Rolling Updates:** Docker performs a rolling update, gradually replacing old containers with new ones using the updated image. This process ensures minimal downtime.
- **Versioning:** The `:v2` denotes that this is the second version of the web application's Docker image.
- **Use Case:** Updating the application to a new version (e.g., with bug fixes, new features, or performance improvements) without taking the entire service offline.

### 8. **Managing Services and Containers**

Commands to inspect services:

```bash
docker service ls
```
- **Purpose:** Lists all running services within the swarm, showing details such as service names, replica counts, and update status.

```bash
docker service inspect --pretty mywebapp
```
- **Purpose:** Provides detailed information about the `mywebapp` service in a human-readable format.

```bash
docker service inspect --pretty mydb
```
- **Purpose:** Similar to the previous command, but for the `mydb` service.

```bash
docker service ps mydb
```
- **Purpose:** Lists the tasks (individual containers) running for the `mydb` service, showing their status and placement.

```bash
docker service ps mywebapp
```
- **Purpose:** Lists the tasks running for the `mywebapp` service, providing insight into which nodes the containers are running on, their status, and other relevant details.

### 9. **Stopping and Removing Services**

```bash
docker service rm mywebapp
docker service rm mydb
```

- **Purpose:** These commands stop and remove the specified services from the swarm.
- **Stopping Services:** When you remove a service, Docker Swarm stops all running containers (replicas) of that service and removes them from the swarm.
- **Cleanup:** This is typically done when the service is no longer needed or when you want to completely shut down a specific component of your application stack.

Each of these commands is crucial in orchestrating Docker containers in a production environment, allowing for scalable, reliable, and manageable deployment of applications and services.
