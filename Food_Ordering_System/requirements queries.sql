
---------------------------

--e) What was the list of meals that ordered by more than five times during last two months?

SELECT 
    m.meal_id,
    m.name AS meal_name,
    COUNT(oi.meal_id) AS order_count
FROM 
    Menu_items m
JOIN 
    Order_items oi ON m.meal_id = oi.meal_id
JOIN 
    Order_ o ON oi.order_id = o.order_id
WHERE 
    o.date >= DATEADD(MONTH, -2, GETDATE()) 
GROUP BY 
    m.meal_id, m.name
HAVING 
    COUNT(oi.meal_id) > 5
ORDER BY 
    order_count DESC;

	---------------------------------

--f) For each customer, retrieve all his/her information and the number of orders

SELECT 
    c.customer_id,
    c.customer_name,
    c.email,
    c.address,
    COUNT(o.order_id) AS number_of_orders
FROM 
    Customer c
INNER JOIN 
    Order_ o ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id, 
    c.customer_name, 
    c.email, 
    c.address
ORDER BY 
    number_of_orders DESC;


-------------------------

--select the most ordering meal

select top 1
m.meal_id, m.name as meal_name,
count(oi.order_id) as total_orders

from Menu_items m
join Order_items oi on m.meal_id = oi.meal_id
group by m.meal_id, m.name
order by total_orders DESC;


------------------------
--What was the order prices for each customer during last three months?


select c.customer_id,c.customer_name, c.email,
sum(o.total) as total_spent, count(o.order_id) as order_count,
string_agg(convert(varchar(20),o.total)+' ('+ convert(varchar(10),o.date,23)+' )',', ') as order_details
from customer c

join Order_ o on c.customer_id = o.customer_id
where o.date >= DATEADD(month,-3,getdate())

group by c.customer_id, c.customer_name, c.email
order by total_spent desc;


--------------------------------
--What was the list of meals that not ordered by any customer?


select m.meal_id, m.name as meal_name, m.price, m.category
from Menu_items m
where not exists(
		select 1 from Order_items oi
		where oi.meal_id = m.meal_id
)

order by 
m.meal_id;



-------------------------------------------

--Who was the customer that made the highest order price this month?

select top 1 with ties
c.customer_id, c.customer_name, o.order_id, o.total as order_ammount, o.date
from Customer c
join Order_ o on c.customer_id=o.customer_id
where o.date >= '2025-05-01' and o.date <= '2025-05-31' -- I did this with that date because of the sample data + you can it automaticlly generate the date but there will be no data in the tables
order by o.total desc;


-------------------------------------------




