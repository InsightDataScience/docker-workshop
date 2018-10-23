# Chapter 4: Putting it all together via docker-compose!

While it useful to run Docker containers by themselves, the real power of Docker is only unleashed once we build and orchestrate a whole platform consisting of multiple containers using container orchestration tools. One of the best solutions for this is [Kubernetes](https://kubernetes.io/), but for the purpose of this workshop, it will suffice to use `docker-compose`, an orchestration tool that ships with our installation of Docker (if you are using Linux, you might have to install it separately).

Most of the files in the `jupyter` folder are directly taken from Chapter 2.  However, we also now have a `docker-compose.yml` file!
Here yml stands for "Yet Another Markup Language", it is a language commonly used for configuration files.
Before looking at the rest of the repository, let us dive into the `docker-compose` file:

We first declare that we are using version 3 of `docker-compose`:

    version: '3'

We now define `services`. Each service uses an image to build one or more containers. We will only build one container per service, but you can imagine that having multiple containers running the same service can help serve millions of users!
The first service we define is a database service:
```
services:
  db:
    image: "postgres:9.6.5"
    volumes:
      - "dbdata2:/var/lib/postgresql/data"
      - ./init-tables.sh:/docker-entrypoint-initdb.d/init-tables.sh
    env_file:  
      - env_file
    networks:
      - nw
```
This service uses the same image that we used in Chapter 3. The declaration of the first volume is also analogous to what we declared in Chapter 3. The second volume mounts the script `init-tables.sh` in the `chapter4` folder to the folder `docker-entrypoint-initdb.d`. This is a feature of the `postgres` image: Any script in that folder will be used to setup the database when first started. We are using this feature to setup a table and insert two entries just like we did by hand in Chapter 3. Feel free to look into `init-tables.sh` to see that the commands are basically the same.
`docker-compose` allows us to declare a bunch of enviromental variables via a file - we have named this file env_file and it is similar to what we defined back in Chapter 3.
Lastly, we attach the `db` service to the network `nw`. More on this later! Let us first move on to the jupyter service.
```
  jupyter-server:
    build: ./jupyter
    volumes:
      - "notebooks2:/jupyter_notebooks"
    ports:
      - 8888:8888
    env_file:
      - env_file
    networks:
      - nw
    depends_on:
      - db
```
Rather than using an image for this service, we give `docker-compose` a build path. This path leads to a `Dockerfile` identical to what we used in Chapter 2 and will allow `docker-compose` to create a jupyter server. The `ports` command ensures what the option `-p 8888:8888` ensured in `docker run`: That we can access the server from outside the containers. To make it easy for us to connect from a jupyter notebook to the database service, we load the same environmental variables. We also attach ourselves to the same network. Lastly, we declare that this service depends on the service `db`. This means that we will only start this service once the `db` service has started.

Let us now finally talk about networking! Now that we want to build a platform of containers, we need to declare networks and attach containers to them. The snippet
```
networks:
  nw:
    driver: bridge
```
declares the network `nw`. The `driver: bridge` option is the best option to simulate a network on a single machine. Read [here](https://docs.docker.com/compose/compose-file/#networks) for more details. As we attached both services to the same network, they will be able to find each other just by their name (in this case `db` and `jupyter-server` respectively).

Lastly, we declare the volumes that we are using for persistent data storage:
```
volumes:
  dbdata2:
  notebooks2:
```

## Building and Running the Platform

While there was a lot of new material in Chapter 4, building and running looks surprisingly familiar:
```
docker-compose build
docker-compose up 
```

Those two commands setup both our services and establish the network `nw`. Note that we added an example notebook in our `jupyter-server` service. Enter the server as usual and open it. You find some commands that load the content of the database into a pandas dataframe. We have a working platform!

Note that we can connect to the database using `user@db:5432`, this is because in our network `nw`, the database server can be found via its name `db`.

This completes our tutorial, we hope you enjoyed it! If you are interested in containerization technologies and concepts such as Infrastructure as Code, be sure to check out the [DevOps Engineering program](https://www.insightdevops.com) at Insight Data Science!
