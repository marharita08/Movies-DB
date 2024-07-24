SELECT DISTINCT ON (m.id) m.id, m.title, m.release_date, m.duration, m.description,
    json_build_object(
        'id', f.id,
        'file_name', f.file_name,
        'mime_type', f.mime_type,
        'key', f.key,
        'url', f.url
    ) AS poster,
    json_build_object(
        'id', p.id,
        'first_name', p.first_name,
        'last_name', p.last_name
    ) AS director
FROM movie m
LEFT JOIN file f ON f.id = m.poster_id
LEFT JOIN person p ON p.id = m.director_id
JOIN movie_genre mg ON mg.movie_id = m.id
JOIN genre g ON g.id = mg.genre_id
WHERE m.country_id=1 
  AND m.release_date > '2022-01-01'
  AND m.duration > '02:15:00'
  AND g.name in ('Action', 'Drama');
