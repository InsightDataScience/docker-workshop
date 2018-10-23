# Chapter 1: First Docker Container!

Let us get started with the "Hello World!" of Docker. In this directory, take a closer look at the Dockerfile.
This is where we specify what our container will look like. A Dockerfile is a recipe to produce a Docker image. A Docker image is a file that can be used to spin up containers with a predefined configuration.

Our particular example of a Dockerfile is quite empty - just two lines. The first line
```
FROM alpine:3.7
```
tells us which base Docker image we are using. The image `alpine:3.7` is a minimalistic Linux system. We are not modifying this base image at all but instead just specify a command we want to run when spinning up a container with this image:
```
CMD ["echo", "hello world!" ]
```

## Building and Running Containers

Now that we have a Dockerfile, we can use it to to create a Docker image via

    docker build -t hello-world .

This creates an image tagged hello-world. The `.` specifies that the image we are building is based on the Dockerfile in the current directory. We can convince ourselves that the image was built successfull by use of the command:

    docker image ls

which displays all current images. Now that we have an image, we can start a container based on it. The command `docker run` starts a new container:

    docker run --name hello-world hello-world

The `--name` option allows us to name the container `hello-world`. The second `hello-world` directs docker to use the image tagged `hello-world` to spin up the container. Our terminal should print `hello world!` as we start the container.
Let us now see the list of running, active containers via

    docker ps

It is empty! This is because our container did not have anything to do after printing `hello world!`. We can get more information if we add the `-a` option:

    docker ps -a

Now we can see that the container has an `exited` status.
In order to remove a (stopped) container, we can use the `rm` command:

    docker rm hello-world

Let us now use  `docker-run` again but add one option and one parameter:

    docker run -d -it --name hello-world hello-world /bin/sh

The option `-d` activates detached mode, a mode where the container runs in the background. The option `-it` runs the container in an interactive mode. The command after the docker image `/bin/sh` direct `docker run` to execute this command after creating the container. This particular command started a shell process that waits for our input. In particular, it runs until we close it. Hence, when executing

    docker ps

We now see a running container! If we want to executed a command in a running container we can use `docker exec`:

    docker exec hello-world ls

The command executes `ls` in the container `hello-world`. This shows us the file system of our container.

That was a lot of information! An important command we did not touch is `docker logs`, we encourage you to try that command yourself before moving into the second chapter.
