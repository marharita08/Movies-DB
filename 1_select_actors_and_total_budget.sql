SELECT p.first_name, p.last_name, SUM(unique_movies.budget) AS total_budget
FROM person p
JOIN (
    SELECT DISTINCT mac.actor_id, m.id, m.budget
    FROM movie_actor_character mac
    JOIN movie m ON mac.movie_id = m.id
) unique_movies ON p.id = unique_movies.actor_id
GROUP BY p.id;
