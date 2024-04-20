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