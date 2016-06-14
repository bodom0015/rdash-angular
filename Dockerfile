#
# Build: docker build -t ndslabs-gui -f Dockerfile.ndslabs-gui .
#
# Single-node Usage: docker run -it -d -p 30000:8080 -e APISERVER_HOST=<ExternalIp> -e APISERVER_PORT=30000 ndslabs-gui
# Multi-node Usage: docker run -it -d -p 8080:8080 -e APISERVER_HOST=<ClusterIP> -e APISERVER_PATH="/api" ndslabs-gui
#

# This image will be based on the official nodejs docker image
FROM node:latest

# Copy in the source
COPY . /home/
 
# Set in what directory commands will run
WORKDIR /home

# Install dependencies
RUN npm install -g bower gulp && \
    npm install && \
    bower install --config.interactive=false --allow-root && \
    gulp build

# Tell Docker we plan to use this port (http-server's default)
EXPOSE 8888

# The command to run our app when the container is run
CMD [ "gulp" ]
