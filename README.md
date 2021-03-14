# SpringBoot + JPAHibernate + Postgres Dockerized

__Notes:__
- Code was written in the IntelliJ IDE.
- Everything is run from a Windows machine, as such translations of the commands maybe needed.

## Prerequisite
- Java11
- Postman (or some equivalent )
- SQLECTRON (or some equivalent )

## Setup

### Creating Docker network
Create a network for both containers to connect to.
```
docker network create -d bridge tutorial-network
```

### Running Postgres Docker container
From the root of the project, run the below command to start the Docker container for Postgres.
```
docker-compose -f ./docker/db/stack.yml up
```
This will start up a Postgres database with a table called "Tutorials" already created for us to use.

### Running API Docker container
Open a new terminal and from the root run the below command
```
docker-compose up --build
```
The script will:
- Copy the `pom.xml` and `src` folder into the docker container.
- Run `mvn package`.
- Run the application using the `SpringBootJPAPostgreSQL-1.0-SNAPSHOT.jar` jar file.

### Running Postman Scripts
Postman Scripts can be found in the root of the project under the `postman` directory.

## Clean up 

### Stopping the API and Postgres Docker container
Open a new terminal and run the following command which will stop the `SpringBootJPAPostgresSQL` and `postgres-db` containers.

Before you run the command below, run `docker ps` to see that the containers are present.
```
docker stop SpringBootJPAPostgresSQL postgres-db
```
Notes:
- You can run ```docker ps``` to verify that they are no longer running.
- With that said, the containers exist and can be see by running `docker ps -a`.

### Remove API and Postgres Docker containers
Note: If you do not plan to run this example again, follow these steps to remove the containers.

Find the containers to be removed `maven-docker-app-image` and `postgres:latest` by running the following command.

```
docker ps -a
```

Make note of their ids and run the following command replacing `containerIdForMaven` and `containerIdForPostgres` with their respective ids.
```
docker container rm containerIdForMaven containerIdForPostgres
```
Note:
- This will also remove any associated images.
- To verify this we can run `docker images ls` to note that there are no images associated to this example (maven and postgres).

### Remove the Docker network created
Note: If you do not plan to run this example again, follow these steps to remove the network.

To remove the `tutorial-network` created, run the following command.
 
```
docker network rm tutorial-network
```
Note: This command may initial fail if the containers associated to it (`maven-docker-app-image` and `postgres:latest`) are not stopped first.

### Resources
[Spring Boot PostgresSQL Example by bezkoder](https://bezkoder.com/spring-boot-postgresql-example/)

[Dockerhub Postgres documentation](https://hub.docker.com/_/postgres/)

[SQLECTRON-GUI, A simple and lightweight SQL client desktop/terminal
with cross database and platform support.](https://sqlectron.github.io/)
