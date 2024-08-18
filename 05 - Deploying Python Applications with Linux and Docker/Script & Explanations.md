# Preparing the Work Environment

First: You need to have Anaconda Python installed in your computer.

Second: We are going to create a image from 0, not using any image pre made

Third: Download the files 'app.py' and 'file.json'

Lastly: We are going to use a .json file from: `https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Objects/JSON`

# Building and Testing the App Locally
## Let me just explain the three main files:

Here's an explanation of each file and how they work together in the Python Application Deployment project:

### 1. `app.py`

**Purpose**: This is the main application file for your Flask web application. It sets up the server, loads the data, and handles the routing.

**Key Components**:

- **Imports**: The necessary modules (`os`, `json`, `Flask`, etc.) are imported. Flask is used to create the web application.
- **Flask Application**: `app = Flask(__name__, template_folder='.')` initializes a Flask application, with the template folder set to the current directory (`.`).
- **Loading the JSON Data**: The JSON data is loaded from `file.json` using `with open('file.json', 'r') as file_json:`, and the content is stored in `thisdata`.
- **Routing**: The `@app.route("/")` decorator defines the route for the home page (`/`). The `index` function renders the `index.html` template, passing the JSON data (`thisdata`) to the template as `jsonfile`.
- **Running the Server**: The application is set to run in debug mode with `app.run(debug=True)`.

### 2. `file.json`

**Purpose**: This file contains the JSON data that will be loaded and displayed by the Flask application.

**Key Components**:

- **JSON Structure**: The file defines a JSON object representing a "Super hero squad" with details like the squad's name, hometown, formation year, secret base, and a list of members, each with their name, age, secret identity, and powers.
- **Use in the App**: This JSON data is read by `app.py` and passed to the front-end to be rendered on the web page.

### 3. `index.html`

**Purpose**: This is the front-end HTML file that displays the content of your Flask application.

**Key Components**:

- **HTML Structure**: The file is a simple HTML document with a header (`<h2>MyPythonApp</h2>`) and a paragraph element (`<p id="AppPython"></p>`) where the JSON data will be displayed.
- **JavaScript**: The script block:
    - Converts the passed JSON data (`jsonfile`) from a string to a JavaScript object using `JSON.parse(jsonfile)`.
    - Updates the inner HTML of the `<p>` element with the content of the parsed JSON object.

### How They Work Together:

1. **Server-Side**:
    - `app.py` serves as the backend, loading the JSON data from `file.json` and setting up routes.
    - The Flask server delivers the `index.html` page when the root URL (`/`) is accessed.
2. **Client-Side**:
    - When a user visits the application, the Flask server responds with the `index.html` file.
    - The JSON data loaded by Flask is passed to the HTML template and is rendered on the webpage by the JavaScript code.

This setup is a simple example of a Flask web application that serves JSON data to a front-end HTML page and dynamically displays it.

# Let's Go
1. Install Flask with `pip install flask`
2. Download the "requirements.txt" file

### RUN

In your command line prompt, run this command

```bash
flask run --host 0.0.0.0 --port 3000
```

- Problems: If you have some kind of **port** problem or warning, just change the number 3000 to another one.
- You can also encounter this Flask location problem. This just means that you have to run this prompt in the same folder of the “app.py” file.
    
    ![image](https://github.com/user-attachments/assets/a1be3ab0-f6b5-4ff6-9b1f-3e5c8c4f5e5d)

    
    - My file is in my folder: C:\Users\Caio\Downloads\MyPythonApp
        - REMEMBER TO CHANGE “\” to “/”
        - `cd C:/Users/Caio/Downloads/MyPythonApp`
        
        ![image](https://github.com/user-attachments/assets/497cd41a-d1aa-417f-9651-a9c652b07659)

        
    
    Now that it is running, you can just go to the path indicated by the “Running” line. Mine is "http://192.168.1.3:3000/"

# App Deployment Using Docker Container (Dockerfile)

```bash
docker build -t pythonapp-image:v1 .
```
![image](https://github.com/user-attachments/assets/cb0ca31f-5e76-4d02-bf11-a4a08246c71d)


```bash
docker run -dit --name MyPythonApp -p 3000:3000 pythonapp-image:v1
```

```bash
docker ps
```
![image](https://github.com/user-attachments/assets/1796fee8-9ea6-4e99-9a99-995e86f4a879)

![image](https://github.com/user-attachments/assets/5332dd3f-a467-4463-bff9-db15d2480a30)


This sequence of Docker commands is used to build, run, and manage a Docker container for the Python application defined by the Dockerfile. Here's a detailed explanation of each command:

### 1. `docker build -t PythonApp-image:v1 .`

- **Purpose**: This command builds a Docker image from the Dockerfile in the current directory.
- **Details**:
    - **`docker build`**: The `build` command is used to create a Docker image from a Dockerfile and the context provided (which includes the application code, dependencies, and other resources needed for the image).
    - **`t PythonApp-image:v1`**: The `t` flag tags the image with a name (`PythonApp-image`) and a version tag (`v1`). This makes it easier to identify and manage the image later on.
    - **`.`**: The period at the end of the command specifies the build context, which is the current directory. Docker will look for the Dockerfile and any other files it needs in this directory.

### What Happens During the Build?

- Docker reads the Dockerfile in the current directory.
- It executes the instructions in the Dockerfile (e.g., setting the base image, copying files, installing dependencies).
- Once all instructions are executed, Docker packages the resulting file system into an image, which is tagged as `PythonApp-image:v1`.

### 2. `docker run -dit --name MyPythonApp -p 3000:3000 PythonApp-image:v1`

- **Purpose**: This command runs a container from the image you just built, making the Python application accessible.
- **Details**:
    - **`docker run`**: This command creates and starts a new container from a specified image.
    - **`dit`**: These flags control how the container runs:
        - **`d`** (detached mode): Runs the container in the background, allowing you to continue using your terminal.
        - **`i`** (interactive): Keeps the STDIN open even if not attached, useful for keeping the container running if it expects input.
        - **`t`** (pseudo-TTY): Allocates a pseudo-TTY, which provides terminal-like input/output capabilities within the container.
    - **`-name MyPythonApp`**: This assigns a custom name (`MyPythonApp`) to the container, making it easier to manage or reference later.
    - **`p 3000:3000`**: This maps port 3000 on the host machine to port 3000 on the container.
        - The first `3000` refers to the host machine's port.
        - The second `3000` refers to the port inside the container (as exposed by the `EXPOSE 3000` command in the Dockerfile).
    - **`PythonApp-image:v1`**: This specifies the image to use for creating the container. It refers to the image you built and tagged earlier.

### What Happens When You Run This Command?

- Docker creates a container from the `PythonApp-image:v1` image.
- It maps the container’s port 3000 to port 3000 on your host machine, making the Flask application accessible at `http://localhost:3000` on your local machine.
- The container runs in detached mode (`d`), so it runs in the background, allowing you to use the terminal for other commands.

### 3. `docker ps`

- **Purpose**: This command lists the currently running containers.
- **Details**:
    - **`docker ps`**: This displays a table of all containers that are currently up and running.
    - **Information Shown**: The output typically includes details like the container ID, image used, the command the container is running, how long it has been running, and the ports being used.

### What Information Do You Get?

- **Container ID**: A unique identifier for each running container.
- **Image**: The Docker image from which the container was created (e.g., `PythonApp-image:v1`).
- **Command**: The command that is being executed inside the container (in this case, `flask run`).
- **Status**: Indicates how long the container has been running and whether it is healthy.
- **Ports**: Shows the port mappings between the host and the container (e.g., `0.0.0.0:3000->3000/tcp`).

### Summary:

- **`docker build -t PythonApp-image:v1 .`**: Builds a Docker image from your application's Dockerfile.
- **`docker run -dit --name MyPythonApp -p 3000:3000 PythonApp-image:v1`**: Runs a container from the built image, mapping port 3000 on your machine to port 3000 in the container.
- **`docker ps`**: Lists the currently running containers, allowing you to verify that your application is running and see its details.

This sequence allows you to build, deploy, and manage a containerized Python application efficiently using Docker.



```bash
# https://hub.docker.com/_/python
FROM python:3-alpine

# Create app directory
WORKDIR /app

# Install app dependencies
COPY requirements.txt ./

RUN pip install -r requirements.txt

# Bundle app source
COPY . .

EXPOSE 3000
CMD [ "flask", "run", "--host", "0.0.0.0", "--port", "3000"]
```

This Dockerfile is used to containerize a Python application, specifically one that likely uses the Flask web framework. Here's a detailed breakdown of each part of the code:

### 1. `FROM python:3-alpine`

- **Purpose**: This line specifies the base image for the Docker container.
- **Details**:
    - `python:3-alpine` refers to a lightweight version of the official Python image, built on top of the Alpine Linux distribution.
    - **Why Alpine?** Alpine is known for its minimal size, making the resulting Docker image smaller and faster to deploy. It includes just enough Linux to run the application, making it ideal for environments where minimizing resource usage is critical.
    - **Python 3**: This indicates that the Python 3 version of the interpreter will be used in the container.

### 2. `WORKDIR /app`

- **Purpose**: This sets the working directory for the application inside the container.
- **Details**:
    - **`/app`**: This is the directory within the container's filesystem where subsequent commands (like copying files or running commands) will operate. If the directory does not exist, Docker will create it.
    - **Working Directory**: It ensures that any relative file paths used in subsequent commands (like `COPY` or `RUN`) are based on `/app`.

### 3. `COPY requirements.txt ./`

- **Purpose**: This copies the `requirements.txt` file from your local machine to the container.
- **Details**:
    - **`requirements.txt`**: This file typically contains a list of Python dependencies that your application requires, with each package and its version specified.
    - **Destination (`./`)**: The file is copied into the current working directory of the container, which is `/app` as set by the `WORKDIR` command.

### 4. `RUN pip install -r requirements.txt`

- **Purpose**: This installs the Python dependencies specified in `requirements.txt` within the container.
- **Details**:
    - **`pip install`**: `pip` is the Python package installer, and `r requirements.txt` tells it to install all the packages listed in the `requirements.txt` file.
    - **Why `RUN`?** The `RUN` command executes the specified command inside the container. This installs the necessary libraries so that the application can run successfully within the container.

### 5. `COPY . .`

- **Purpose**: This copies the entire content of your local project directory to the container.
- **Details**:
    - **Source (`.`)**: The first dot refers to the current directory on your local machine.
    - **Destination (`.`)**: The second dot refers to the current directory within the container, which is `/app` as per the `WORKDIR` command.
    - **Result**: Your application's source code and any other files in your project directory will be available inside the container at `/app`.

### 6. `EXPOSE 3000`

- **Purpose**: This informs Docker that the container will listen on port 3000 at runtime.
- **Details**:
    - **Port 3000**: This is the network port that the Flask application will use to serve requests.
    - **EXPOSE**: This directive does not actually publish the port to the host machine; it only serves as documentation and configuration for when you run the container. You would still need to use the `p` flag when running the container to map the container's port 3000 to a port on your host machine (e.g., `docker run -p 3000:3000`).

### 7. `CMD [ "flask", "run", "--host", "0.0.0.0", "--port", "3000"]`

- **Purpose**: This specifies the command to run when the container starts.
- **Details**:
    - **`flask run`**: This is the command used to start a Flask application. It launches a development server that listens for incoming HTTP requests.
    - **`-host "0.0.0.0"`**: By default, Flask listens only on `localhost`, meaning it can't be accessed from outside the container. Setting the host to `0.0.0.0` makes the Flask app accessible from any network interface, allowing external access.
    - **`-port "3000"`**: This sets the port for the Flask app to listen on. It corresponds to the port specified in the `EXPOSE` command.

### Summary:

- This Dockerfile is designed to create a lightweight container for a Python Flask web application. It sets up the necessary environment by installing dependencies, copying the application code into the container, and configuring the Flask application to run on port 3000. The use of the Alpine-based Python image ensures that the container is small, fast, and efficient.

## Conclusion:
This approach is highly effective because it creates a lightweight container that consumes minimal memory, making it ideal for resource-efficient environments. 

Additionally, in a microservices architecture, where each part of the application runs in its own container, this method offers significant benefits. These include easier maintenance, as each microservice can be managed independently, and simplified updates, as changes can be deployed to individual containers without affecting the entire application. 

This modularity enhances scalability, reliability, and overall system performance.
