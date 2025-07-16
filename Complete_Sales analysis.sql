create database Sales_Analysis;
use Sales_Analysis;


-- 1. Sales Representatives Table --
CREATE TABLE sales_reps (
    rep_id INT PRIMARY KEY,
    rep_name VARCHAR(100) NOT NULL,
    region VARCHAR(50),
    hire_date DATE
);

-- 2. Customers Table
CREATE TABLE customers (
    cust_id INT PRIMARY KEY,
    cust_name VARCHAR(100) NOT NULL,
    city VARCHAR(100),
    industry VARCHAR(100)
);

-- 3. Sales Orders Table
CREATE TABLE sales_orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    amount DECIMAL(10,2),
    rep_id INT,
    cust_id INT,
    FOREIGN KEY (rep_id) REFERENCES sales_reps(rep_id),
    FOREIGN KEY (cust_id) REFERENCES customers(cust_id)
);

INSERT INTO sales_reps (rep_id, rep_name, region, hire_date) VALUES
(1, 'Ravan', 'North', '2021-01-10'),
(2, 'Givan', 'South', '2020-03-15'),
(3, 'Prateek', 'West', '2019-06-20'),
(4, 'Bhoomi', 'East', '2022-11-05'),
(5, 'Manav', 'North', '2023-02-12'),
(6, 'Sufiyan', 'Central', '2021-09-01'),
(7, 'Rehbar', 'South', '2020-12-25');

select * from sales_reps;

INSERT INTO customers (cust_id, cust_name, city, industry) VALUES
(1, 'Adiba', 'Delhi', 'Retail'),
(2, 'Satyam', 'Mumbai', 'Manufacturing'),
(3, 'Sakshi', 'Bangalore', 'Technology'),
(4, 'Sakhi', 'Hyderabad', 'Retail'),
(5, 'Seema', 'Chennai', 'Healthcare'),
(6, 'Zaid', 'Kolkata', 'Finance'),
(7, 'Aryan', 'Delhi', 'Manufacturing'),
(8, 'Fatima', 'Pune', 'Retail'),
(9, 'Nikhil', 'Mumbai', 'Technology'),
(10, 'Mehak', 'Ahmedabad', 'E-commerce'),
(11, 'Tanya', 'Noida', 'Education'),
(12, 'Anuj', 'Jaipur', 'Healthcare');

select * from customers;

INSERT INTO sales_orders (order_id, order_date, amount, rep_id, cust_id) VALUES
(1, '2024-01-15', 25000.00, 1, 1),
(2, '2024-01-17', 48000.00, 2, 2),
(3, '2024-01-20', 120000.00, 3, 3),
(4, '2024-02-05', 38000.00, 4, 4),
(5, '2024-02-10', 57000.00, 5, 5),
(6, '2024-02-15', 92000.00, 6, 6),
(7, '2024-03-01', 110000.00, 7, 7),
(8, '2024-03-03', 30000.00, 1, 8),
(9, '2024-03-08', 45000.00, 2, 9),
(10, '2024-03-15', 60000.00, 3, 10),
(11, '2024-04-01', 99000.00, 4, 11),
(12, '2024-04-07', 15000.00, 5, 12),
(13, '2024-04-10', 38000.00, 6, 1),
(14, '2024-04-15', 71000.00, 7, 2),
(15, '2024-04-20', 45000.00, 1, 3),
(16, '2024-04-25', 87000.00, 2, 4),
(17, '2024-05-01', 36000.00, 3, 5),
(18, '2024-05-05', 42000.00, 4, 6),
(19, '2024-05-10', 65000.00, 5, 7),
(20, '2024-05-12', 78000.00, 6, 8),
(21, '2024-05-15', 24000.00, 7, 9),
(22, '2024-05-17', 93000.00, 1, 10),
(23, '2024-05-20', 51000.00, 2, 11),
(24, '2024-05-22', 58000.00, 3, 12),
(25, '2024-05-25', 47000.00, 4, 1),
(26, '2025-06-22', 50000.00, 3, 2);


select * from sales_orders;

-- List all orders greater than ₹50,000.

select * from sales_orders
where amount >50000;

-- Show orders made after June 15, 2025.
select * from sales_orders
where order_date > '2025-06-15';

-- Find customers from the city “Delhi”

select * from customers
where city = 'Delhi';


-- Show reps working in the "South" region.
select * from sales_reps
where region = 'south';

-- List customers in the “Retail” industry.
 select * from customers
 where industry = 'Retail';
 
-- 6. Find orders where amount is between ₹30,000 and ₹60,000.
   select * from sales_orders
   where amount between 30000 and 60000;
   
-- List reps hired after 2022.
select * from sales_reps
where hire_date > '2022-12-31';

-- Show customers not from “Mumbai”.
select * from customers
where not city =  'mumbai';

select * from customers
where city <>  'mumbai';



--  Find orders made by rep_id = 3.
 select * from sales_orders
 where rep_id =3;
 
 -- Display orders where customer name starts with ‘A’.
  select so.* , c.cust_name
 from sales_orders so 
 join customers  c ON so.cust_id = c.cust_id
 where c.cust_name LIKE 'A%';
 
 -- B. JOIN Queries (10)
 
-- 11. Show all orders with rep and customer names.
 
 select  o.order_id,
         o.order_date,
	     o.amount,
         c.cust_name,
         (r.rep_name)
 from sales_orders o
 join customers c ON o.cust_id = c.cust_id
 Join sales_reps r ON o.rep_id = r.rep_id;
 

--  Display order_id, customer city, and rep region.
    select so.order_id,
           c.city As Customer_city,
           sr.region As Representative_City
    from sales_orders So 
    join customers c on So.cust_id= c.cust_id
    join sales_reps sr on so.rep_id = sr.rep_id;


-- 13. List orders where reps and customers are from the same region (simulated).
select so.order_id,
    c.cust_name,
    c.city,
    sr.rep_name,
    sr.region
FROM sales_orders so
JOIN customers c ON so.cust_id = c.cust_id
JOIN sales_reps sr ON so.rep_id = sr.rep_id
WHERE 
    (sr.region = 'North' AND c.city IN ('Delhi', 'Chandigarh')) OR
    (sr.region = 'South' AND c.city IN ('Bengaluru', 'Chennai')) OR
    (sr.region = 'East'  AND c.city IN ('Kolkata')) OR
    (sr.region = 'West'  AND c.city IN ('Mumbai', 'Ahmedabad'));  
	

-- 14. Show total order amount per rep (grouped).
SELECT 
    sr.rep_id,
    sr.rep_name,
    sum(so.amount) AS total_sales
FROM sales_orders so
JOIN sales_reps sr ON so.rep_id = sr.rep_id
GROUP by sr.rep_id , sr.rep_name;


-- 15. Show industry-wise total sales.
select c.industry , sum(so.amount) as Total_Amount
from sales_orders so
join customers c on so.cust_id = c.cust_id
group by c.industry;

-- 16. Get number of orders per customer.
select c.cust_name,count(so.order_id) As No_of_Orders
from sales_orders so
join customers c ON c.cust_id= so.Cust_id
group by c.cust_name;



-- 17. Show orders along with days since rep hire date.

SELECT 
    so.order_id,
    sr.rep_name,
    so.order_date,
   datediff( sr.hire_date , so.order_date) AS Days_since_hired
FROM sales_orders so
JOIN sales_reps sr ON so.rep_id = sr.rep_id;


-- 18. List top 5 customers with the highest total order value.

SELECT 
    c.cust_id,
    c.cust_name,
    SUM(so.amount) AS total_spent
FROM sales_orders so
JOIN customers c ON so.cust_id = c.cust_id
GROUP BY c.cust_id, c.cust_name
ORDER BY total_spent desc
LIMIT 5;
-- 19. Show orders made in cities where the rep is NOT based (cross check).
SELECT 
    so.order_id,
    c.city AS customer_city,
    sr.region AS rep_region
FROM sales_orders so
JOIN customers c ON so.cust_id = c.cust_id
JOIN sales_reps sr ON so.rep_id = sr.rep_id
WHERE 
    (sr.region = 'North' AND c.city NOT IN ('Delhi', 'Chandigarh')) OR
    (sr.region = 'South' AND c.city NOT IN ('Bengaluru', 'Chennai')) OR
    (sr.region = 'East' AND c.city NOT IN ('Kolkata')) OR
    (sr.region = 'West' AND c.city NOT IN ('Mumbai', 'Ahmedabad'));

-- 20. Combine sales data and customer industry into a report
 SELECT 
    so.order_id,
    so.order_date,
    so.amount,
    c.cust_name,
    c.industry
FROM sales_orders so
JOIN customers c ON so.cust_id = c.cust_id;


-- C. HAVING Clause (10)
-- 21. Show reps having total sales > ₹100,000.
select r.rep_id,r.rep_name , sum(so.amount) As total_Sales
from sales_orders so
join sales_reps r on so.rep_id= r.rep_id
group by r.rep_name,r.rep_id

having total_sales> 100000
order by total_sales asc;



-- 22. List industries with more than 3 customers.
select industry, 
count(cust_name) AS Customer_name
from customers
group by industry
having count(cust_name) > 2;



-- 23. Get customers who made more than 2 orders.

SELECT 
    c.cust_id,
    c.cust_name,
    COUNT(so.order_id) AS order_count
FROM sales_orders so
JOIN customers c ON so.cust_id = c.cust_id
GROUP BY c.cust_id, c.cust_name
HAVING order_count > 2;

-- 24. Show cities with total sales above ₹1,50,000.
SELECT 
    c.city,
    SUM(so.amount) AS total_sales
FROM sales_orders so
JOIN customers c ON so.cust_id = c.cust_id
GROUP BY c.city
HAVING total_sales > 150000;


-- 25. Reps whose average order amount is above ₹40,000.
SELECT 
    sr.rep_id,
    sr.rep_name,
    AVG(so.amount) AS avg_order
FROM sales_orders so
JOIN sales_reps sr ON so.rep_id = sr.rep_id
GROUP BY sr.rep_id, sr.rep_name
HAVING avg_order > 40000;

-- 26. Customers who contributed more than 10% of total revenue.
SELECT 
    c.cust_id,
    c.cust_name,
    SUM(so.amount) AS customer_total,
    (SUM(so.amount) / (SELECT SUM(amount) FROM sales_orders)) * 100 AS percent_contribution
FROM sales_orders so
JOIN customers c ON so.cust_id = c.cust_id
GROUP BY c.cust_id, c.cust_name
HAVING percent_contribution > 10;

-- 27. Industries where average sales order > ₹35,000.
SELECT 
    c.industry,
    AVG(so.amount) AS avg_sales
FROM sales_orders so
JOIN customers c ON so.cust_id = c.cust_id
GROUP BY c.industry
HAVING avg_sales > 35000;

-- 28. Reps with orders totaling over ₹2L in a region.
SELECT 
    sr.region,
    sr.rep_id,
    sr.rep_name,
    SUM(so.amount) AS total_sales
FROM sales_orders so
JOIN sales_reps sr ON so.rep_id = sr.rep_id
GROUP BY sr.region, sr.rep_id, sr.rep_name
HAVING total_sales > 200000;

-- 29. List cities with more than 3 different customers.

SELECT 
    city,
    COUNT(DISTINCT cust_id) AS customer_count
FROM customers
GROUP BY city
HAVING customer_count > 1;

-- 30. Customers with maximum order > ₹80,000.

SELECT 
    c.cust_id,
    c.cust_name,
    MAX(so.amount) AS max_order
FROM sales_orders so
JOIN customers c ON so.cust_id = c.cust_id
GROUP BY c.cust_id, c.cust_name
HAVING max_order > 80000;


-- ️ E. UNION (10)
-- 41. List all names (reps and customers) in one list.
SELECT rep_name AS name FROM sales_reps
UNION
SELECT cust_name FROM customers;

-- 42. List all cities (from customers and reps' regions).
SELECT city AS location FROM customers
UNION
SELECT region FROM sales_reps;

-- 43. Show combined list of all unique industry names and rep regions.

SELECT industry AS category FROM customers
UNION
SELECT region FROM sales_reps;

-- 44. Get a list of all people (rep_name, cust_name) who ordered or handled sales.
SELECT DISTINCT sr.rep_name AS person
FROM sales_orders so
JOIN sales_reps sr ON so.rep_id = sr.rep_id
UNION
SELECT DISTINCT c.cust_name
FROM sales_orders so
JOIN customers c ON so.cust_id = c.cust_id;

-- 45. Union of all order dates and hire dates (for timeline).
SELECT order_date AS event_date FROM sales_orders
UNION
SELECT hire_date FROM sales_reps;

-- 46. Union of customer names and reps in South region.
SELECT cust_name FROM customers
UNION
SELECT rep_name FROM sales_reps WHERE region = 'South';

-- 47. Union of customer IDs and rep IDs.
SELECT cust_id AS id FROM customers
UNION
SELECT rep_id FROM sales_reps;

-- 48. Combine sales over ₹50,000 and customers from “Retail”.
SELECT cust_id FROM sales_orders WHERE amount > 50000
UNION
SELECT cust_id FROM customers WHERE industry = 'Retail';

-- 49. List names from both customers and reps starting with ‘R’.
SELECT rep_name AS name FROM sales_reps WHERE rep_name LIKE 'R%'
UNION
SELECT cust_name FROM customers WHERE cust_name LIKE 'R%';

-- 50. Combine all orders and create a flat report using UNION ALL
SELECT order_id, order_date, amount, rep_id, cust_id FROM sales_orders
UNION ALL
SELECT NULL, hire_date, NULL, rep_id, NULL FROM sales_reps;



 

