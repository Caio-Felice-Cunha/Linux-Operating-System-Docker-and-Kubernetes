# Base image
FROM nginx:1.23-alpine

# Remove the default web server configuration file
RUN rm /etc/nginx/conf.d/*

# Copy the file with our settings
COPY ./conf/nginx.conf /etc/nginx/conf.d/
