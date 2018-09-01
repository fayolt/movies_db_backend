# MoviesDbBackend

## Prerequisite to run the application

* Docker & Docker Compose

## To start the backend app

* Build the images

```sh
docker-compose build
```
* Start the containers 

```sh
docker-compose up
```

Now the backend app is available at [`localhost:4000`](http://localhost:4000)

## Functionning

* At startup the local database is provisionned with initial data [``]

* An Algolia index is also created and data is indexed

## Encountered Issues
  
* 2 records with too big size
