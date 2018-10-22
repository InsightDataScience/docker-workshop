# Chapter 3: Databases and binding volumes

In this Dockerfile, we are creating a PostgreSQL database and binding a volume.

Explain what this does and how it can be used for stateful containers.
Explain how to setup an initial table.
Explain how to ingest data via docker exec.

docker build -t db .
docker run -d -v dbdata:/var/lib/postgresql/data --name db db

 docker exec -it db psql -U me study
 CREATE TABLE participants (name VARCHAR(255), age int, score int);
 SELECT * FROM participants;
 INSERT INTO participants (name, age, score) VALUES ('Lucy', 33, 8), ('Jack', 44, 12);
 \q
 docker stop db
 docker start db
 docker exec -it db psql -U me study
 SELECT * FROM participants;
 
 
