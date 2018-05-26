FROM divinelabs/jackrabbit

ADD postgresql-9.4-1201.jdbc41.jar /usr/local/tomcat/lib/postgresql-9.4-1201.jdbc41.jar
ADD repository.template.xml /repository.template.xml

ENV DB_POSTGRES_HOST postgres
ENV POSTGRES_USER root
ENV POSTGRES_PASSWORD password
ENV POSTGRES_DB jackrabbit