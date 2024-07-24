SELECT users.id, username, STRING_AGG(fm.movie_id::text, ',') AS favorite_movie_ids
FROM users
JOIN favorite_movies fm ON fm.user_id = users.id
GROUP BY users.id, username

