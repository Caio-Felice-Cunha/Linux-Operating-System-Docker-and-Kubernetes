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


















# Deploy 02: Stack for Deploying Web App, API and Database
