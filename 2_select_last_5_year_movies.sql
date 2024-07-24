SELECT m.id, m.title, COUNT(DISTINCT mac.actor_id) AS actors_count
FROM movie m
JOIN movie_actor_character mac ON m.id = mac.movie_id
WHERE m.release_date >= CURRENT_DATE - INTERVAL '5 years'
GROUP BY m.id, m.title;
