# ucad_database
# Mediashare Database Schema

Relational database of `mediashare`.

<!-- ![Database Schema](/media/db.png) -->

# Entity-Relationship Diagram

```mermaid
erDiagram
    USERS ||--o{ MEDIAITEMS : "uploads"
    USERS ||--o{ PLAYLISTS : "creates"
    USERS ||--o{ FOLLOWERS : "follows"
    MEDIAITEMS ||--o{ PLAYLISTITEMS : "included in"
    PLAYLISTS ||--o{ PLAYLISTITEMS : "contains"
    USERS ||--o{ FOLLOWERS : "followed by"

    USERS {
        user_id INT PK "Primary Key"
        username VARCHAR "Unique username"
        password VARCHAR "User password"
        email VARCHAR "Unique email"
        user_level_id INT "Level of user"
        created_at TIMESTAMP "User creation timestamp"
    }

    MEDIAITEMS {
        media_id INT PK "Primary Key"
        user_id INT FK "Foreign Key referencing USERS"
        filename VARCHAR "Name of the file"
        filesize INT "Size of file in bytes"
        media_type VARCHAR "Type of media<br />(e.g., image/jpeg)"
        title VARCHAR "Title of media"
        description VARCHAR "Description of media"
        created_at TIMESTAMP "Media upload timestamp"
    }

    PLAYLISTS {
        playlist_id INT PK "Primary Key"
        user_id INT FK "Foreign Key referencing USERS"
        playlist_name VARCHAR "Name of playlist"
        created_at TIMESTAMP "Playlist creation timestamp"
    }

    PLAYLISTITEMS {
        playlist_item_id INT PK "Primary Key"
        playlist_id INT FK "Foreign Key referencing PLAYLISTS"
        media_id INT FK "Foreign Key referencing MEDIAITEMS"
        added_at TIMESTAMP "Timestamp<br />media added to playlist"
    }

    FOLLOWERS {
        follower_id INT PK, FK "Foreign Key referencing USERS"
        followed_id INT PK, FK "Foreign Key referencing USERS"
        followed_at TIMESTAMP "Timestamp of<br />follow event"
    }
```

# SQL Queries and Operations

## Retrieve all items in a user's playlist

```sql
SELECT Playlists.playlist_name, MediaItems.title, MediaItems.filename
FROM Playlists
JOIN PlaylistItems ON Playlists.playlist_id = PlaylistItems.playlist_id
JOIN MediaItems ON PlaylistItems.media_id = MediaItems.media_id
WHERE Playlists.user_id = 260;
```

![Retrieve all items in a user's playlist](/media/retr.png)

## Rename a playlist

```sql
UPDATE Playlists
SET playlist_name = 'Updated Playlist Name'
WHERE playlist_id = 1 AND user_id = 260;
```

![Rename of a playlist](/media/rename.png)

## Remove a follower relationship

```sql
DELETE FROM Followers
WHERE follower_id = 260 AND followed_id = 305;
```

![Remove of a follower relationship](/media/remo.png)

-


