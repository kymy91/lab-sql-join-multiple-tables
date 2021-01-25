/*Lab | SQL Joins on multiple tables
In this lab, you will be using the Sakila database of movie rentals.

Instructions
####1. Write a query to display for each store its store ID, city, and country.*/
USE sakila;
#tables: store, address, city
#feature: store_id, address_id

SELECT s.store_id, c.city, co.country
FROM sakila.store AS s
JOIN sakila.address AS a
ON s.address_id = a.address_id
JOIN sakila.city AS c
ON a.city_id = c.city_id
JOIN sakila.country AS co
ON c.country_id = co.country_id;


####2. Write a query to display how much business, in dollars, each store brought in.
#Table Payment (amount) > Customer (customer_id) > Store (store_id 
SELECT s.store_id, sum(p.amount)
FROM sakila.payment AS p
JOIN sakila.customer AS c
ON p.customer_id = c.customer_id
JOIN sakila.store AS s
ON s.store_id = c.store_id
GROUP BY s.store_id;

####3. What is the average running time of films by category?
select  c.name, round(avg(length),2) AS avgRunningtime
from sakila.category as c
join sakila.film_category as f -- default type of join is INNER JOIN. 
on c.category_id = f.category_id
join sakila.film as fl
on fl.film_id = f.film_id
group by c.name;

####4. Which film categories are longest?
select  c.name, round(avg(length),2) AS avgRunningtime
from sakila.category as c
join sakila.film_category as f -- default type of join is INNER JOIN. 
on c.category_id = f.category_id
join sakila.film as fl
on fl.film_id = f.film_id
group by c.name
ORDER BY avgRunningtime DESC
LIMIT 5;

####5. Display the most frequently rented movies in descending order.
#Tables: Rental (inventory_id)> Inventory (inventory_id) > film (film_id)

SELECT f.title, count(r.rental_date)
from sakila.rental as r
	join sakila.inventory as i
		on r.inventory_id = i.inventory_id
	join sakila.film as f
		on f.film_id = i.film_id
group by f.title
ORDER BY count(r.rental_id) DESC;


####6. List the top five genres in gross revenue in descending order.
#Table cat film_id > invent(inv_id) > rental (rental_id) > Payment(rental_id)

select c.name, sum(p.amount) AS total_amount
from sakila.category AS c
	join sakila.film_category AS f 
		on c.category_id = f.category_id
	join sakila.inventory AS i
		on f.film_id = i.film_id
	join sakila.rental AS r
		on i.inventory_id = r.inventory_id
	join sakila.payment as p
		on r.rental_id = p.rental_id
group by c.category_id
ORDER BY total_amount desc
LIMIT 5;

####7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT f.title, r.rental_date, r.return_date, store_id
from sakila.rental as r
	join sakila.inventory as i
		on r.inventory_id = i.inventory_id
	join sakila.film as f
		on f.film_id = i.film_id
WHERE f.title = "Academy Dinosaur" and return_date is NULL and store_id = 1;
#No "Academy Dinosaur" is not available in Store 1 (it is only available in store 2)