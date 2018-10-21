# Chapter 1: First Docker Container!

Let us get started with the "Hello World!" of Docker. In this directory, take a closer look at the Dockerfile.
This is where we specify what our container will look like.


Describe Dockerfile in more detail.

## Building and Running Containers

   docker build -t hello-world .

   docker image ls

   docker run --name hello-world hello-world

   docker ps

   docker ps -a

   docker rm hello-world

   docker run -d --name hello-world hello-world /bin/sh

   docker ps

   docker exec hello-world ls

Instructions on how to investiage what is going on.
Introduction of docker exec vs docker run

Mention the weird Windows stuff.
