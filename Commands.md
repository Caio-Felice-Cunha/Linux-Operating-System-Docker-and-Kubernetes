# Creating Docker Image and Container with Linux

### First we go to the prompt (command in line):

* docker pull ubuntu # download ubuntu docker image

* docker run -d -p --name Linux-Manag-Docker ubuntu # create container. '-d'stands for detached mode to run in the background.

* docker ps # view the running containers

## Now we can go to the Docker Desktop Terminal or keep in the prompt

### Prompt

* docker exec -i -t Linux-Manag-Docker /bin/bash # 'exec' is to perform an action with an already created container 'i' allows interaction with the container '-t' is to use this terminal '/bin/bash' is to enter the shell

### Github Desktop

#### Once created, go to Docker Desktop than Containers than 3 dots than Terminal

* bash # open shell

* ls -la # view container
