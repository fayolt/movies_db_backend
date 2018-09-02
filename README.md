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
docker-compose up -d
```

* Stop the containers 

```sh
docker-compose down
```

Now the backend app is available at [`localhost:4000`](http://localhost:4000)

## Functionning

* At startup the local database is provisionned with initial data [`movies.json`](https://gist.github.com/alexandremeunier/49533eebe2ec93b14d32b2333272f9f8)

* An Algolia index is also created and data is indexed

* The end [`/api/movies/sync`](http:l//localhost:4000/api/movies/sync) can also be used to index all the data contained in the local database into Algolia index

## Encountered Issues
  
* 2 records with too big size
