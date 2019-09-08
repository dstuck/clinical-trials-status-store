Docker
======
* Docker-compose `depends_on` only waits until container has started,
not until the db has initialized so the pgql service should fail the
 first time it tries to connect to the database [ref](https://docs.docker.com/compose/compose-file/)

    * The log will say it's not set up to retry; that just means the
    postgraphile command will not retry, the docker command will

Postgraphile
============
* To get a list of all types (fields + builtins) in graphql run:
```
{
  __schema {
    types {
      name
    }
  }
}
```
