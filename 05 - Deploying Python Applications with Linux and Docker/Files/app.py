import json
from flask import Flask, render_template

# App
app = Flask(__name__, template_folder='.')

# Load the file as a Python object (dict), not a raw string
with open('file.json', 'r') as file_json:
    thisdata = json.load(file_json)

# Route
@app.route("/")
def index():
    return render_template('index.html', title="MyPythonApp", squad=thisdata)

# Run the program
if __name__ == '__main__':
    app.run(debug=True)
