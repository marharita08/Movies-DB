SELECT person.id, first_name || ' ' || last_name AS name, ROUND(AVG(budget), 2) AS avarage_budget
FROM person
JOIN movie ON person.id = movie.director_id
GROUP BY person.id, first_name, last_name