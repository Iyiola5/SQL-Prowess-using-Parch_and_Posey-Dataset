
(1) Companies without sales rep and sales rep without accounts
 SELECT accounts.id,accounts.name,sales_reps.id, sales_reps.name
FROM accounts
FULL OUTER JOIN sales_reps ON accounts.sales_rep_id = sales_reps.id
WHERE accounts.sales_rep_id IS NULL OR sales_reps.id IS NULL
 
(2) Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event?
SELECT w.occurred_at date, w.channel via, a.name account
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
ORDER BY w.occurred_at DESC
LIMIT 1

3) For each account, determine the average amount of each type of paper they purchased across their orders.
SELECT accounts.name as account_name,
       AVG(standard_qty) as avg_standard,
       AVG(gloss_qty) as avg_gloss,
       AVG(poster_qty) as avg_poster
FROM accounts
JOIN orders on accounts.id = orders.account_id
GROUP BY account_name

(4)What paper type generated the highest revenue

SELECT SUM(gloss_amt_usd) as Gloss_Paper_revenue,
  SUM(poster_amt_usd) as Poster_Paper_revenue, 
  SUM(standard_amt_usd) as Standard_Paper_revenue
FROM orders

(5) Which 10 companies had the highest order
SELECT accounts.name AS company_name, COUNT(*) AS total_number_of_orders
FROM accounts
JOIN orders ON accounts.id = orders.account_id
GROUP BY accounts.name
ORDER BY total_number_of_orders DESC
limit 10

(6) From what region was the highest sales generated from
SELECT r.name as region_name, sum (o.total_amt_usd) as total_sales
from region r
join sales_reps sr on r.id = sr.region_id
join accounts a on sr.id = a.sales_rep_id
join orders o on a.id = o.account_id
group by r.name
order by total_sales desc

(7)Which month and year did Parch and posey have the highest sales in terms of total orders
SELECT DATE_PART('month',occurred_at) AS sales_month , COUNT(*) AS total_number_of_orders
FROM orders
GROUP BY 1
ORDER BY 2 DESC

SELECT DATE_PART('year',occurred_at) AS sales_year , COUNT(*) AS total_number_of_orders
FROM orders
GROUP BY 1
ORDER BY 2 DESC

(8)Which of the parch and posey papers  had the highest sales in the Northeast region 
SELECT r.name as region_name, sum (o.standard_amt_usd) as standard_total_sales, sum(o.gloss_amt_usd) as gloss_total_sales, sum(o.poster_amt_usd) as poster_total_sales
from region r
join sales_reps sr on r.id = sr.region_id
join accounts a on sr.id = a.sales_rep_id
join orders o on a.id = o.account_id
group by r.name
order by standard_total_sales desc

(9) region and the total qty of paper types sold
SELECT r.name as region_name, sum (o.standard_amt_usd) as standard_total_sales, sum(o.gloss_amt_usd) as gloss_total_sales, sum(o.poster_amt_usd) as poster_total_sales
from region r
join sales_reps sr on r.id = sr.region_id
join accounts a on sr.id = a.sales_rep_id
join orders o on a.id = o.account_id
group by r.name
order by gloss_total_sales desc

(10)List the name of the companies that bought over 7000 gloss paper qty

SELECT accounts.name AS account_name, SUM(gloss_qty) AS gloss_paper_qty
FROM accounts
JOIN orders ON accounts.id = orders.account_id
GROUP BY accounts.name
HAVING SUM(gloss_qty) > 7000
ORDER BY gloss_paper_qty asc



