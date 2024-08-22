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