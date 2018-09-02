# MoviesDbBackend

## Prerequisite to run the application

* Docker & Docker Compose

## To start the backend app

* Provide Algolia application ID and API key (NOT SEARCH API KEY)

    Add a file named `.env` in the root directory of the project containing both the application ID and the API key in the format

```sh
ALGOLIA_APPLICATION_ID=YOUR_APPLICATION_ID
ALGOLIA_API_KEY=YOUR_API_KEY
```

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

* An Algolia index named `movies_db_index` is created and data is indexed right away

* The endpoint [`/api/movies/sync`](http:l//localhost:4000/api/movies/sync) can also be used to index all the data contained in the local database into Algolia index

## Encountered Issues
  
* 2 records with too big size
