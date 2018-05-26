# Jackrabbit Docker image for PostgreSQL backing db
Based on [divinelabs/jackrabbit](https://hub.docker.com/r/divinelabs/jackrabbit/) for mysql by [koemeet/jackrabbit-docker](https://github.com/koemeet/jackrabbit-docker)


It runs jackrabbit inside Tomcat as a webapp on port `8080`.



## Configuration
By default, configuration is done with the following environment variables
 - DB_POSTGRES_HOST
 - POSTGRES_DB
 - POSTGRES_USER
 - POSTGRES_PASSWORD

### Custom configuration

You can provide your own `repository.xml` configuration, you can do this by creating a volume at the
path `/repository.template.xml`. In here you can access environment variables by using `${ENV.VAR_NAME}`.
This file will be parsed and the output will be placed at `/opt/jackrabbit/repository.xml` automatically.

For example, this is a snippet from the default template:

```xml
<FileSystem class="org.apache.jackrabbit.core.fs.db.DbFileSystem">
    <param name="driver" value="org.postgresql.Driver"/>
    <param name="url" value="jdbc:postgresql://{ENV.DB_POSTGRES_HOST}/${ENV.POSTGRES_DB}"/>
    <param name="schema" value="postgresql"/>
    <param name="user" value="${ENV.POSTGRES_USER}"/>
    <param name="password" value="${ENV.POSTGRES_PASSWORD}"/>
    <param name="schemaObjectPrefix" value="globalstate_"/>
</FileSystem>
```

This way you can configure anything you like using environment variables! Have fun!

## Docker Compose
With docker-compose, linking to a postgres container is easy as
it is assigned a hostname based on the service name.
Here is an example to show how default template configuration can be used, as well as how to provide your own repository.xml template file
(note: this is just an example for the jackrabbit configuration and is not suitable for use as-is)
```yaml
version: '3'
services:
  postgres:
    image: postgres
    environment:
      POSTGRES_USER: mypostgresuser
      POSTGRES_PASSWORD: mypostgrespassword
      POSTGRES_DB: jackrabbit_db
    volumes:
      - "/var/lib/postgresql/data"
  
  jackrabbit:
    image: olicoad/jackrabbit-postgres
    environment:
      DB_POSTGRES_HOST: postgres
      POSTGRES_USER: mypostgresuser
      POSTGRES_PASSWORD: mypostgrespassword
      POSTGRES_DB: jackrabbit_db
    volumes:
        - "/opt/jackrabbit/repository"
      #optionally provide your own repository.xml
      - "./my-repository.template.xml:/repository.template.xml"
    ports:
      #exposed on port 8080 in the container
      - "8080:8080"
```