# Base image (LTS; node 19 was an EOL odd-numbered release)
FROM node:20-alpine

# Create the app folder
RUN mkdir -p /usr/src/app

# Sets the working folder
WORKDIR /usr/src/app

# Copy the dependencies file
COPY src/package.json .

# Install the dependencies
RUN npm install

# Copy the app files (the source lives in ./src, and CMD runs server.js from
# WORKDIR, so copy the contents of src/ directly into /usr/src/app)
COPY src/ .

# Exports (the app listens on 5000, see server.js)
EXPOSE 5000
CMD [ "npm", "run", "dev" ]
