import os
import json
from flask import Flask, render_template, abort, url_for, json, jsonify

# App
app = Flask(__name__,template_folder='.')

# Load the file
with open('file.json', 'r') as file_json:
    thisdata = file_json.read()

# Route
@app.route("/")
def index():
    return render_template('index.html', title = "MyPythonApp", jsonfile = json.dumps(thisdata))

# Run the program
if __name__ == '__main__':
    app.run(debug=True)