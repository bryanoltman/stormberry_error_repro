# Stormberry Error Repro

## Prereq

Set up a containerized database using:

```
docker pull postgres
docker run \
    --name stormberry_demo \
    -p 127.0.0.1:5432:5432 \
    -e POSTGRES_USER=postgres \
    -e POSTGRES_DB=stormberry_demo \
    -e POSTGRES_PASSWORD=password \
    -d \
    postgres
```

## Running

`dart run bin/stormberry_err_repro`

Note that all posts are created with the same `createdAt` DateTime. When
comparing a Post retrieved through a User (i.e., `user.posts.first`) will have a
non-UTC createdAt, while a Post retrieved directly by id will have a UTC
createdAt, meaning the same object will be different depending on how it is
retrieved.
