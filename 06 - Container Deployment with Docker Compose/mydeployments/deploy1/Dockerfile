
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