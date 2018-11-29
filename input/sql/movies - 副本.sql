-- Source: https://unstats.un.org/unsd/methodology/m49/overview/
-- Source: https://whc.unesco.org/en/list/

--
-- Create database
--

-- CREATE DATABASE IF NOT EXISTS Movies;
-- USE Movies;

--
-- Drop tables
-- turn off FK checks temporarily to eliminate drop order issues
--

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS color, director, movie_language, country, content_rating, plot_keyword, genre, movie;
SET FOREIGN_KEY_CHECKS=1;

--
-- color
--

CREATE TABLE IF NOT EXISTS color
  (
    color_id INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
    color_name VARCHAR(150) NOT NULL UNIQUE,
    PRIMARY KEY (color_id)
  )
ENGINE=InnoDB
CHARACTER SET utf8mb4
COLLATE utf8mb4_0900_ai_ci;

INSERT IGNORE INTO color (color_name) VALUES
  ('Black and White'), ('Color');
--
-- directors.
--

CREATE TABLE IF NOT EXISTS director
  (
    director_id INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
    director_name VARCHAR(225) NOT NULL UNIQUE,
    PRIMARY KEY (director_id)
  )
ENGINE=InnoDB
CHARACTER SET utf8mb4
COLLATE utf8mb4_0900_ai_ci;

-- populate the movie director table.
LOAD DATA LOCAL INFILE 'D:/664/project/output/director_name.csv'
	IGNORE
	INTO TABLE `movies`.`director`
    CHARACTER SET utf8
    FIELDS ESCAPED BY '\\' 
    TERMINATED BY ',' 
    ENCLOSED BY '"' 
    LINES TERMINATED BY '\r\n' 
  (director_name)
SET director_name = IF(director_name = '', NULL, director_name);
--
-- movie language.
--

CREATE TABLE IF NOT EXISTS movie_language
  (
    language_id INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
    language_name VARCHAR(100) NOT NULL UNIQUE,
    PRIMARY KEY (language_id)
  )
ENGINE=InnoDB
CHARACTER SET utf8mb4
COLLATE utf8mb4_0900_ai_ci;

-- populate the movie_language table.
LOAD DATA LOCAL INFILE 'D:/664/project/output/language.csv'
	IGNORE
	INTO TABLE `movies`.`movie_language`
    CHARACTER SET utf8
    FIELDS ESCAPED BY '\\' 
    TERMINATED BY ',' 
    ENCLOSED BY '"' 
    LINES TERMINATED BY '\r\n' 
  (language_name)
SET language_name = IF(language_name = '', NULL, language_name);

--
-- country
--

CREATE TABLE IF NOT EXISTS country
  (
    country_id INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
    country_name VARCHAR(100) NOT NULL UNIQUE,
    PRIMARY KEY (country_id)
   )
ENGINE=InnoDB
CHARACTER SET utf8mb4
COLLATE utf8mb4_0900_ai_ci;

-- Insert country 
LOAD DATA LOCAL INFILE 'D:/664/project/output/country.csv'
	IGNORE
	INTO TABLE `movies`.`country`
    CHARACTER SET utf8
    FIELDS ESCAPED BY '\\' 
    TERMINATED BY ',' 
    ENCLOSED BY '"' 
    LINES TERMINATED BY '\r\n'
  (country_name)
SET country_name = IF(country_name = '', NULL, country_name);
--
-- content rating.
--

CREATE TABLE IF NOT EXISTS content_rating
  (
    content_rating_id INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
    content_rating VARCHAR(100) NOT NULL UNIQUE,
    PRIMARY KEY (content_rating_id)
   )
ENGINE=InnoDB
CHARACTER SET utf8mb4
COLLATE utf8mb4_0900_ai_ci;

-- Insert country 
LOAD DATA LOCAL INFILE 'D:/664/project/output/content_rating .csv'
	IGNORE
	INTO TABLE `movies`.`content_rating`
    CHARACTER SET utf8
    FIELDS ESCAPED BY '\\' 
    TERMINATED BY ',' 
    ENCLOSED BY '"' 
    LINES TERMINATED BY '\r\n'
  (content_rating)
SET content_rating = IF(content_rating = '', NULL, content_rating);
--
-- genre
--

CREATE TABLE IF NOT EXISTS genre
  (
    genre_id INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
    genre VARCHAR(100) NOT NULL UNIQUE,
    PRIMARY KEY (genre_id)
   )
ENGINE=InnoDB
CHARACTER SET utf8mb4
COLLATE utf8mb4_0900_ai_ci;

-- Insert genre
LOAD DATA LOCAL INFILE 'D:/664/project/output/genres_unique.csv'
	IGNORE
	INTO TABLE `movies`.`genre`
    CHARACTER SET utf8
    FIELDS ESCAPED BY '\\' 
    TERMINATED BY ',' 
    ENCLOSED BY '"' 
    LINES TERMINATED BY '\r\n'
	IGNORE 1 LINES
  (genre) 
SET genre = IF(genre = '', NULL, genre);  
--
-- plot_keyword
--

CREATE TABLE IF NOT EXISTS plot_keyword
  (
    keyword_id INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
    keyword VARCHAR(100) NOT NULL UNIQUE,
    PRIMARY KEY (keyword_id)
   )
ENGINE=InnoDB
CHARACTER SET utf8mb4
COLLATE utf8mb4_0900_ai_ci;

-- Insert plot keyword
LOAD DATA LOCAL INFILE 'D:/664/project/output/keywords_unique.csv'
	IGNORE
	INTO TABLE `movies`.`plot_keyword`
    CHARACTER SET utf8
    FIELDS ESCAPED BY '\\' 
    TERMINATED BY ',' 
    ENCLOSED BY '"' 
    LINES TERMINATED BY '\r\n'
	IGNORE 1 LINES
  (keyword)  
SET keyword = IF(keyword = '', NULL, keyword);  

-- Temporary target table for movie data import
CREATE TEMPORARY TABLE temp_movie
  (
    id INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
    movie_title VARCHAR(100) NOT NULL,
    title_year YEAR(4) NOT NULL,
    imdb_score DECIMAL(2, 1) NOT NULL, 
    duration INT NOT NULL,
    movie_imdb_link TEXT NOT NULL,
	color_name VARCHAR(150) NOT NULL,
	director_name VARCHAR(150) NOT NULL,
	language_name VARCHAR(150) NOT NULL,
	country_name VARCHAR(150) NOT NULL,
	content_rating VARCHAR(150) NOT NULL,
	genre VARCHAR(255) NOT NULL,
	keyword VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
  )
ENGINE=InnoDB
CHARACTER SET utf8mb4
COLLATE utf8mb4_0900_ai_ci;

-- Load data from external file.
-- Check for blank entries and set to NULL.
LOAD DATA LOCAL INFILE 'D:/664/project/input/csv/movie_metadata.csv'
INTO TABLE `movies`.`temp_movie`
    FIELDS TERMINATED BY ',' 
    ENCLOSED BY '"' 
    LINES TERMINATED BY '\n'
  IGNORE 1 LINES
  (color_name, director_name, @dummy, duration, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, movie_title, @dummy, @dummy, @dummy, 
   @dummy, @dummy, @movie_imdb_link, @dummy, language_name, country_name, content_rating, @dummy, title_year, @dummy, imdb_score, @dummy, @dummy)
   

  SET movie_title = IF(movie_title = '', NULL, movie_title),
  title_year = IF(title_year = '', NULL, title_year),
  imdb_score = IF(imdb_score = '', NULL, imdb_score),
  duration = IF(duration = '', NULL, duration),
  movie_imdb_link = IF(movie_imdb_link = '', NULL, movie_imdb_link),
  color_name = IF(color_name = '', NULL, color_name),
  director_name = IF(director_name = '', NULL, director_name),
  language_name = IF(language_name = '', NULL, language_name),
  country_name = IF(country_name = '', NULL, country_name),
  content_rating = IF(content_rating = '', NULL, content_rating);
--
-- movie
--

CREATE TABLE IF NOT EXISTS movie
  (
    movie_id INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
    movie_title VARCHAR(150) NOT NULL UNIQUE,
    title_year YEAR(4) NOT NULL,
    imdb_score DECIMAL(2, 1) NOT NULL, 
    duration INT NOT NULL,
    movie_imdb_link TEXT NOT NULL,
	color_id INTEGER NOT NULL,
	director_id INTEGER NOT NULL,
	language_id INTEGER NOT NULL,
	country_id INTEGER NOT NULL,
	content_rating_id INTEGER NOT NULL,
    PRIMARY KEY (movie_id),
    FOREIGN KEY (color_id) REFERENCES color(color_id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (director_id) REFERENCES director(director_id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (language_id) REFERENCES movie_language(language_id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (content_rating_id) REFERENCES content_rating(content_rating_id)
    ON DELETE RESTRICT ON UPDATE CASCADE	
   )
ENGINE=InnoDB
CHARACTER SET utf8mb4
COLLATE utf8mb4_0900_ai_ci;

-- Insert movie attributes only from temp table .
INSERT IGNORE INTO movie
  (
    movie_title, 
    title_year,
    imdb_score, 
    duration, 
    movie_imdb_link, 
	color_id, 
	director_id, 
	language_id, 
	country_id, 
	content_rating_id 
  )
SELECT tm.movie_title, tm.title_year, tm.imdb_score, tm.duration, tm.movie_imdb_link, 
		cl.color_id, d.director_id, ml.language_id, ct.country_id, cr.content_rating_id
  FROM temp_movie tm
       LEFT JOIN color cl
              ON tm.color_name = cl.color_name
       LEFT JOIN director d
              ON tm.director_name = d.director_name
       LEFT JOIN movie_language ml
              ON tm.language_name = ml.language_name
       LEFT JOIN country ct
              ON tm.country_name = ct.country_name
       LEFT JOIN content_rating cr
              ON tm.content_rating = cr.content_rating			  
 WHERE IFNULL(tm.color_name, 0) = IFNULL(cl.color_name, 0)
   AND IFNULL(tm.director_name, 0) = IFNULL(d.director_name, 0)
   AND IFNULL(tm.language_name, 0) = IFNULL(ml.language_name, 0)
   AND IFNULL(tm.country_name, 0) = IFNULL(ct.country_name, 0)
   AND IFNULL(tm.content_rating, 0) = IFNULL(cr.content_rating, 0)
 ORDER BY tm.movie_title;

--
-- Link UNSD country_area to UNESCO heritage_site
-- WARN: 'Old City of Jerusalem and its Walls' site is NOT associated with a UNSD M49 country_area.
--

-- Junction table linking heritage sites to states (many-to-many).
-- WARN: Django 2.x ORM does not recognize compound keys. Add otherwise superfluous primary key
-- to accommodate a weak ORM.

-- WARN: if a heritage_site record or country_area record is deleted the ON DELETE CASCADE
-- will delete associated records in this junction/associative table.

CREATE TABLE IF NOT EXISTS movie_genres
  (
    movie_genres_id INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
    movie_id INTEGER NOT NULL,
    genre_id INTEGER NOT NULL,
    PRIMARY KEY (movie_genres_id),
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genre(genre_id)
    ON DELETE CASCADE ON UPDATE CASCADE
  )
ENGINE=InnoDB
CHARACTER SET utf8mb4
COLLATE utf8mb4_0900_ai_ci;

-- Create temporary numbers table that will be used to split out comma-delimited lists of states.
CREATE TEMPORARY TABLE numbers
  (
    num INTEGER NOT NULL UNIQUE,
    PRIMARY KEY (num)
  )
ENGINE=InnoDB
CHARACTER SET utf8mb4
COLLATE utf8mb4_0900_ai_ci;

INSERT IGNORE INTO numbers (num) VALUES
  (1), (2), (3), (4), (5), (6), (7), (8), (9), (10), (11), (12), (13), (14), (15);

-- Create temporary table to store split out states.
CREATE TEMPORARY TABLE multi_movie_genres
  (
    id INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
    movie_title VARCHAR(255) NOT NULL,
    genre VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
  )
ENGINE=InnoDB
CHARACTER SET utf8mb4
COLLATE utf8mb4_0900_ai_ci;

-- This query splits the states and inserts them into the target temp table.
INSERT IGNORE INTO multi_movie_genres (movie_title, genre)
SELECT tm.movie_title,
       SUBSTRING_INDEX(SUBSTRING_INDEX(tm.genre, '|', numbers.num), '|', -1)
       AS genre
  FROM numbers
       INNER JOIN temp_movie tm
               ON CHAR_LENGTH(tm.genre) -
                  CHAR_LENGTH(REPLACE(tm.genre, '|', ''))
                  >= numbers.num - 1
 ORDER BY tm.id, numbers.num;

DROP TEMPORARY TABLE numbers;

-- Insert UNESCO heritage sites linked to multiple states in junction table.
INSERT IGNORE INTO movie_genres (movie_id, genre_id)
SELECT m.movie_id,
       g.genre_id
  FROM multi_movie_genres mmg
       LEFT JOIN movie m
              ON mmg.movie_title = m.movie_title
       LEFT JOIN genre g
              ON mmg.genre = g.genre
 ORDER BY mmg.id;

DROP TEMPORARY TABLE multi_movie_genres;

-- many to many with movies and keywords 
CREATE TABLE IF NOT EXISTS movie_keywords
  (
    movie_keywords_id INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
    movie_id INTEGER NOT NULL,
    keyword_id INTEGER NOT NULL,
    PRIMARY KEY (movie_keywords_id),
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (keyword_id) REFERENCES plot_keyword(keyword_id)
    ON DELETE CASCADE ON UPDATE CASCADE
  )
ENGINE=InnoDB
CHARACTER SET utf8mb4
COLLATE utf8mb4_0900_ai_ci;

-- Create temporary numbers table that will be used to split out comma-delimited lists of states.
CREATE TEMPORARY TABLE numbers
  (
    num INTEGER NOT NULL UNIQUE,
    PRIMARY KEY (num)
  )
ENGINE=InnoDB
CHARACTER SET utf8mb4
COLLATE utf8mb4_0900_ai_ci;

INSERT IGNORE INTO numbers (num) VALUES
  (1), (2), (3), (4), (5), (6), (7), (8), (9), (10), (11), (12), (13), (14), (15);

-- Create temporary table to store split out states.
CREATE TEMPORARY TABLE multi_movie_keywords
  (
    id INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
    movie_title VARCHAR(255) NOT NULL,
    keyword VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
  )
ENGINE=InnoDB
CHARACTER SET utf8mb4
COLLATE utf8mb4_0900_ai_ci;

-- This query splits the states and inserts them into the target temp table.
INSERT IGNORE INTO multi_movie_keywords (movie_title, keyword)
SELECT tm.movie_title,
       SUBSTRING_INDEX(SUBSTRING_INDEX(tm.keyword, '|', numbers.num), '|', -1)
       AS keyword
  FROM numbers
       INNER JOIN temp_movie tm
               ON CHAR_LENGTH(tm.keyword) -
                  CHAR_LENGTH(REPLACE(tm.keyword, '|', ''))
                  >= numbers.num - 1
 ORDER BY tm.id, numbers.num;

DROP TEMPORARY TABLE numbers;

-- Insert UNESCO heritage sites linked to multiple states in junction table.
INSERT IGNORE INTO movie_keywords (movie_id, keyword_id)
SELECT m.movie_id,
       pkd.keyword_id
  FROM multi_movie_keywords mmk
       LEFT JOIN movie m
              ON mmk.movie_title = m.movie_title
       LEFT JOIN plot_keyword pkd
              ON mmk.keyword = pkd.keyword
 ORDER BY mmk.id;

DROP TEMPORARY TABLE temp_movie,multi_movie_keywords;


