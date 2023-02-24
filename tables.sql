DROP TABLE IF EXISTS albums CASCADE;
DROP TABLE IF EXISTS tracks CASCADE;
DROP TABLE IF EXISTS albums_tracks;

CREATE TABLE albums(
    album_id SERIAL PRIMARY KEY,
    title text NOT NULL,
    Created_at timestamp(0) with time zone NOT NULL DEFAULT NOW()

);

CREATE TABLE tracks(
    track_id SERIAL PRIMARY KEY,
    track_title text NOT NULL,
    length integer NOT NULL,
    Created_at timestamp(0) with time zone NOT NULL DEFAULT NOW()
);

CREATE TABLE albums_tracks(
    albums_tracks_id serial PRIMARY KEY,
    track_id integer references tracks(track_id),
    album_id integer references albums(album_id),
    Created_at timestamp(0) with time zone NOT NULL DEFAULT NOW()
);

INSERT INTO albums(title)
VALUES 
('album1'),
('album 2'),
('album 3'),
('album 4'),
('album 5'),
('album 6'),
('album 7'),
('album 8'),
('album 9'),
('album 10');

INSERT INTO tracks(track_title, length)
VALUES
('track 1',8),
('track 2', 3),
('track 3', 4),
('track 4', 5),
('track 6', 18),
('track 7', 10),
('track 8', 15),
('track 9', 12),
('track 10', 4);

INSERT INTO albums_tracks(album_id, track_id)
VALUES 
(1,1),
(1,2),
(2,2),
(2,3),
(3,3),
(3,4),
(4,5),
(5,5),
(5,6),
(6,7),
(7,7);

SELECT A.title, T.track_title , T.length
FROM albums AS A
INNER JOIN albums_tracks AS AT 
ON A.album_id = AT.album_id
INNER JOIN tracks AS T 
ON AT.track_id = T.track_id;

--the albums and tracks that belongs to each albums
SELECT A.title, T.track_title
FROM albums AS A 
INNER JOIN albums_tracks AS AT 
ON A.album_id = AT.album_id
INNER JOIN tracks AS T 
ON AT.track_id = T.track_id;

--the albums that each track belong to
SELECT A.title , T.track_title
FROM tracks AS T 
INNER JOIN albums_tracks AS AT 
ON T.track_id = AT.track_id
INNER JOIN albums AS A 
ON AT.album_id = A.album_id;

--see the number of songs an album has
SELECT A.title , COUNT(T.track_id)
FROM albums AS A
INNER JOIN albums_tracks AS AT 
ON A.album_id = AT.album_id
INNER JOIN tracks AS T 
ON AT.track_id = T.track_id
GROUP BY A.title;

--see hoe many albums a particular track is on
SELECT T.track_title, COUNT(A.album_id)
FROM tracks AS T 
INNER JOIN albums_tracks AS AT 
ON T.track_id = AT.track_id
INNER JOIN albums AS A 
ON AT.album_id = A.album_id
WHERE T.track_title ='track 3'
GROUP BY T.track_title;