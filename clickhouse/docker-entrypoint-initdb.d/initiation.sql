-- Create database if does not exist
CREATE DATABASE IF NOT EXISTS imdb;

-- Create table
CREATE TABLE IF NOT EXISTS imdb.actors
(
    id         UInt32,
    first_name String,
    last_name  String,
    gender     FixedString(1)
) ENGINE = MergeTree ORDER BY (id, first_name, last_name, gender);

CREATE TABLE IF NOT EXISTS imdb.directors
(
    id         UInt32,
    first_name String,
    last_name  String
) ENGINE = MergeTree ORDER BY (id, first_name, last_name);

CREATE TABLE IF NOT EXISTS imdb.genres
(
    movie_id UInt32,
    genre    String
) ENGINE = MergeTree ORDER BY (movie_id, genre);

CREATE TABLE IF NOT EXISTS imdb.movie_directors
(
    director_id UInt32,
    movie_id    UInt64
) ENGINE = MergeTree ORDER BY (director_id, movie_id);

CREATE TABLE IF NOT EXISTS imdb.movies
(
    id   UInt32,
    name String,
    year UInt32,
    rank Float32 DEFAULT 0
) ENGINE = MergeTree ORDER BY (id, name, year);

CREATE TABLE IF NOT EXISTS imdb.roles
(
    actor_id   UInt32,
    movie_id   UInt32,
    role       String,
    created_at DateTime DEFAULT now()
) ENGINE = MergeTree ORDER BY (actor_id, movie_id);

-- Insert data if table imdb.actors does not exist
INSERT INTO imdb.actors
SELECT *
FROM s3('https://datasets-documentation.s3.eu-west-3.amazonaws.com/imdb/imdb_ijs_actors.tsv.gz',
'TSVWithNames')
WHERE NOT EXISTS (SELECT 1 FROM system.tables WHERE database = 'imdb' AND name = 'actors');

-- Insert data if table imdb.directors does not exist
INSERT INTO imdb.directors
SELECT *
FROM s3('https://datasets-documentation.s3.eu-west-3.amazonaws.com/imdb/imdb_ijs_directors.tsv.gz',
'TSVWithNames')
WHERE NOT EXISTS (SELECT 1 FROM system.tables WHERE database = 'imdb' AND name = 'directors');

-- Insert data if table imdb.genres does not exist
INSERT INTO imdb.genres
SELECT *
FROM s3('https://datasets-documentation.s3.eu-west-3.amazonaws.com/imdb/imdb_ijs_movies_genres.tsv.gz',
'TSVWithNames')
WHERE NOT EXISTS (SELECT 1 FROM system.tables WHERE database = 'imdb' AND name = 'genres');

-- Insert data if table imdb.movie_directors does not exist
INSERT INTO imdb.movie_directors
SELECT *
FROM s3('https://datasets-documentation.s3.eu-west-3.amazonaws.com/imdb/imdb_ijs_movies_directors.tsv.gz',
        'TSVWithNames')
WHERE NOT EXISTS (SELECT 1 FROM system.tables WHERE database = 'imdb' AND name = 'movie_directors');

-- Insert data if table imdb.movies does not exist
INSERT INTO imdb.movies
SELECT *
FROM s3('https://datasets-documentation.s3.eu-west-3.amazonaws.com/imdb/imdb_ijs_movies.tsv.gz',
'TSVWithNames')
WHERE NOT EXISTS (SELECT 1 FROM system.tables WHERE database = 'imdb' AND name = 'movies');

-- Insert data if table imdb.roles does not exist
INSERT INTO imdb.roles(actor_id, movie_id, role)
SELECT actor_id, movie_id, role
FROM s3('https://datasets-documentation.s3.eu-west-3.amazonaws.com/imdb/imdb_ijs_roles.tsv.gz',
'TSVWithNames')
WHERE NOT EXISTS (SELECT 1 FROM system.tables WHERE database = 'imdb' AND name = 'roles');
