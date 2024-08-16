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

        
    
    Now that it is running, you can just go to the path indicated by the “Running” line. Mine is "http://192.168.1.3:3000/”

