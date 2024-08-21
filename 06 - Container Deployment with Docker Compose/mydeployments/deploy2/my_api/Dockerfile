# Base image
FROM node:19-alpine

# Create the app folder
RUN mkdir -p /usr/src/app

# Sets the working folder
WORKDIR /usr/src/app

# Copy the dependencies file
COPY src/package.json .

# Install the dependencies
RUN npm install

# Copy the app files
COPY . .

# Exports
EXPOSE 80
CMD [ "npm", "run", "dev" ]
