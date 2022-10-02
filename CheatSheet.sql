// Write an SQL query to fix the names so that only the first character is uppercase and the rest are lowercase.
SELECT user_id,CONCAT(UPPER(SUBSTR(name,1,1)),LOWER(SUBSTR(name,2,length(name)))) AS name
FROM Users ORDER BY user_id;
