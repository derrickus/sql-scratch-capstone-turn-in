/*Question 1*/
SELECT *
FROM survey
LIMIT 10;

/*Task 2*/
SELECT question,
   COUNT(DISTINCT user_id)
FROM survey
GROUP BY question;

/*Task 4*/
SELECT *
FROM quiz
LIMIT 5;

SELECT *
FROM home_try_on
LIMIT 5;

SELECT *
FROM purchase
LIMIT 5;

quiz – user_id, style, fit, shape, color
home_try_on – user_id, number_of_pairs, address
purchase – user_id, product_id, style, model_name, color, price


/*Task 5*/
SELECT DISTINCT q.user_id,
   h.user_id IS NOT NULL AS 'is_home_try_on',
   h.number_of_pairs,
   p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz AS 'q'
LEFT JOIN home_try_on 'h'
   ON q.user_id = h.user_id
LEFT JOIN purchase 'p'
   ON p.user_id = q.user_id
LIMIT 20;




/*Task 6 */
--Attempt at capturing the amount of home purchase versus standard purchases
WITH funnels AS (
	SELECT q.user_id,
   h.user_id IS NOT NULL AS 'is_home_try_on',
   h.number_of_pairs,
   p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz AS 'q'
LEFT JOIN home_try_on 'h'
   ON q.user_id = h.user_id 
LEFT JOIN purchase 'p'
   ON p.user_id = q.user_id) 
SELECT COUNT (*) AS 'num_browse',
	COUNT(
     CASE
       WHEN is_home_try_on = 0 THEN user_id
       ELSE NULL
     END) AS 'home_num_checkout',
     COUNT(
     CASE
       WHEN is_purchase = 0 THEN user_id
       ELSE NULL
     END) AS 'num_purchase' 
FROM funnels;
