DROP DATABASE IF EXISTS mediashare;
CREATE DATABASE mediashare;
USE mediashare;

CREATE TABLE Users (
  user_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  user_level_id INT NOT NULL,
  created_at TIMESTAMP NOT NULL
);

CREATE TABLE MediaItems (
  media_id INT NOT NULL AUTO_INCREMENT,
  user_id INT NOT NULL,
  filename VARCHAR(255) NOT NULL,
  filesize INT NOT NULL,
  media_type VARCHAR(255) NOT NULL,
  title VARCHAR(255) NOT NULL,
  description VARCHAR(255),
  created_at TIMESTAMP NOT NULL,
  PRIMARY KEY (media_id),
  FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
CREATE TABLE Playlists (
  playlist_id INT NOT NULL AUTO_INCREMENT,
  user_id INT NOT NULL,
  playlist_name VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (playlist_id),
  FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE TABLE PlaylistItems (
  playlist_item_id INT NOT NULL AUTO_INCREMENT,
  playlist_id INT NOT NULL,
  media_id INT NOT NULL,
  added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (playlist_item_id),
  FOREIGN KEY (playlist_id) REFERENCES Playlists(playlist_id) ON DELETE CASCADE,
  FOREIGN KEY (media_id) REFERENCES MediaItems(media_id) ON DELETE CASCADE
);
CREATE TABLE Followers (
  follower_id INT NOT NULL,
  followed_id INT NOT NULL,
  followed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (follower_id, followed_id),
  FOREIGN KEY (follower_id) REFERENCES Users(user_id) ON DELETE CASCADE,
  FOREIGN KEY (followed_id) REFERENCES Users(user_id) ON DELETE CASCADE
);
INSERT INTO Users VALUES (260, 'VCHar', 'secret123', 'vchar@example.com', 1, null);
INSERT INTO Users VALUES (305, 'Donatello', 'secret234', 'dona@example.com', 1, null);

-- Inserting multiple records at once
INSERT INTO MediaItems (filename, filesize, title, description, user_id, media_type, created_at) 
  VALUES ('ffd8.jpg', 887574, 'Favorite drink', null, 305, 'image/jpeg', null),
         ('dbbd.jpg', 60703, 'Miika', 'My Photo', 305, 'image/jpeg', NULL),
         ('2f9b.jpg', 30635, 'Aksux and Jane', 'friends', 260, 'image/jpeg', null);

INSERT INTO Users VALUES (260, 'VCHar', 'secret123', 'vchar@example.com', 1, null);
INSERT INTO Users VALUES (305, 'Donatello', 'secret234', 'dona@example.com', 1, null);

-- FK constraint fails, user_id 1606 does not exist
INSERT INTO MediaItems (filename, filesize, title, description, user_id, media_type) 
  VALUES ('ffd8.jpg', 887574, 'Favorite drink', '', 1606, 'image/jpeg');

-- Inserting multiple records at once
INSERT INTO MediaItems (filename, filesize, title, description, user_id, media_type) 
  VALUES ('ffd8.jpg', 887574, 'Favorite drink', null, 305, 'image/jpeg'),
         ('dbbd.jpg', 60703, 'Miika', 'My Photo', 305, 'image/jpeg'),
         ('2f9b.jpg', 30635, 'Aksux and Jane', 'friends', 260, 'image/jpeg');


INSERT INTO Playlists (user_id, playlist_name) VALUES 
  (260, 'Summer Vacation Photos'),
  (305, 'Food Photography');

  INSERT INTO PlaylistItems (playlist_id, media_id) VALUES 
  (1, 1),
  (1, 2),
  (2, 3); 

  INSERT INTO Followers (follower_id, followed_id) VALUES
  (260, 305),
  (305, 260);
  

--   -- 1. Retrieve all items in a user’s playlist
-- SELECT Playlists.playlist_name, MediaItems.title, MediaItems.filename
-- FROM Playlists
-- JOIN PlaylistItems ON Playlists.playlist_id = PlaylistItems.playlist_id
-- JOIN MediaItems ON PlaylistItems.media_id = MediaItems.media_id
-- WHERE Playlists.user_id = 260;

-- -- 2. List all followers of a specific user
-- SELECT follower.username AS Follower, followed.username AS Followed
-- FROM Followers
-- JOIN Users AS follower ON Followers.follower_id = follower.user_id
-- JOIN Users AS followed ON Followers.followed_id = followed.user_id
-- WHERE Followers.followed_id = 305;

-- -- 3. Rename a playlist
-- UPDATE Playlists
-- SET playlist_name = 'Updated Playlist Name'
-- WHERE playlist_id = 1 AND user_id = 260;

-- -- 4. Remove a follower relationship
-- DELETE FROM Followers
-- WHERE follower_id = 260 AND followed_id = 305;

-- -- 5. Count the number of items in a specific playlist
-- SELECT COUNT(*) AS ItemCount
-- FROM PlaylistItems
-- WHERE playlist_id = 1;