## 1193. Monthly Transactions I
HERE IS A TABLE
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| country       | varchar |
| state         | enum    |
| amount        | int     |
| trans_date    | date    |
+---------------+---------+

Example:
+------+---------+----------+--------+------------+
| id   | country | state    | amount | trans_date |
+------+---------+----------+--------+------------+
| 121  | US      | approved | 1000   | 2018-12-18 |
| 122  | US      | declined | 2000   | 2018-12-19 |
| 123  | US      | approved | 2000   | 2019-01-01 |
| 124  | DE      | approved | 2000   | 2019-01-07 |
+------+---------+----------+--------+------------+

want a output like this:
+----------+---------+-------------+----------------+--------------------+-----------------------+
| month    | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
+----------+---------+-------------+----------------+--------------------+-----------------------+
| 2018-12  | US      | 2           | 1              | 3000               | 1000                  |
| 2019-01  | US      | 1           | 1              | 2000               | 2000                  |
| 2019-01  | DE      | 1           | 1              | 2000               | 2000                  |
+----------+---------+-------------+----------------+--------------------+-----------------------+

### how to get the month from the date?
#### substr(trans_date,1,7) as month
#### DATE_FORMAT(trans_date,'%Y-%m') AS month

### other things
SELECT
    DATE_FORMAT(trans_date,'%Y-%m') AS month,
    country,
    COUNT(id) AS trans_count,
    COUNT(
        CASE WHEN state = 'approved'
        THEN 1
        END
    ) AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(
        CASE WHEN state = 'approved'
        THEN amount
        ELSE 0
        END
    ) AS approved_total_amount
FROM Transactions
GROUP BY month,country

## 550. Game Play Analysis IV
(player_id, event_date) is the primary key (combination of columns with unique values) of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
 
Write a solution to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. In other words, you need to count the number of players that logged in for at least two consecutive days starting from their first login date, then divide that number by the total number of players.

### solution using DATE_SUB()
#### Notice that the FUNCTION DATE_SUB. The DATE_SUB() function subtracts a time/date interval from a date and then returns the date. And also we could use DATE_ADD() function.
SELECT
    ROUND(COUNT(DISTINCT player_id)/(SELECT COUNT(DISTINCT player_id) FROM Activity),2) AS fraction
FROM Activity
WHERE (player_id, DATE_SUB(event_date, INTERVAL 1 DAY)) IN(
    SELECT player_id, MIN(event_date) AS first_login
    FROM Activity
    GROUP BY player_id
)
### solution using DATE_ADD()
SELECT
    ROUND(COUNT(DISTINCT player_id)/(SELECT COUNT(DISTINCT player_id) FROM Activity), 2) AS fraction
FROM Activity
WHERE (player_id, DATE_ADD(event_date, INTERVAL -1 DAY)) IN(
    SELECT player_id, MIN(event_date)
    FROM Activity
    GROUP BY player_id
)