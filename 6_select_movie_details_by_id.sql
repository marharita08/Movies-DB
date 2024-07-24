SELECT m.id, m.title, m.release_date, m.duration, m.description,
    json_build_object(
        'id', f.id,
        'file_name', f.file_name,
        'mime_type', f.mime_type,
        'key', f.key,
        'url', f.url
    ) AS poster,
    json_build_object(
        'id', d.id,
        'first_name', d.first_name,
        'last_name', d.last_name,
        'photo', (
            SELECT json_build_object(
                'id', dp.id,
                'file_name', dp.file_name,
                'mime_type', dp.mime_type,
                'key', dp.key,
                'url', dp.url
            )
            FROM file dp
            WHERE dp.id = d.avatar_id
        )
    ) AS director,
    json_agg(
        json_build_object(
            'id', a.id,
            'first_name', a.first_name,
            'last_name', a.last_name,
            'photo', (
                SELECT json_build_object(
                    'id', ap.id,
                    'file_name', ap.file_name,
                    'mime_type', ap.mime_type,
                    'key', ap.key,
                    'url', ap.url
                )
                FROM file ap
                WHERE ap.id = a.avatar_id
            )
        )
    ) AS actors,
    json_agg(
        json_build_object(
            'id', g.id,
            'name', g.name
        )
    ) AS genres
FROM movie m
LEFT JOIN file f ON f.id = m.poster_id
LEFT JOIN person d ON d.id = m.director_id 
LEFT JOIN movie_actor_character mac ON mac.movie_id = m.id
LEFT JOIN person a ON a.id = mac.actor_id
LEFT JOIN movie_genre mg ON mg.movie_id = m.id
JOIN genre g ON g.id = mg.genre_id
WHERE m.id = 1
GROUP BY m.id, f.id, d.id
