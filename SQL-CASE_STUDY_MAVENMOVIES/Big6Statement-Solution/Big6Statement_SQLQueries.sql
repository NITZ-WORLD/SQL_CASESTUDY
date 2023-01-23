-- BIG 6 STATEMENT ASSIGNMENT SOLUTION

-- Question 1.
/* 
    We will need a list of all staff members, including their first and last names, email addresses, 
    and the store identification number where they work. 
*/

select
       First_Name,
       Last_Name,
       Email,
       Store_ID
from staff;

-- Question 2.
-- We will need separate counts of inventory items held at each of your two stores.

select
       Store_ID,
       count(inventory_id) as Inventory_Count
from inventory
group by store_id;

-- Question 3.
-- We will need a count of active customers for each of your stores. Separately,please.

select 
       active as Store1_Active_Status,
       count(customer_id) as Store1_Active_Customers_Count
from customer
where store_id = 1 and active = 1
group by active;

select 
       active as Store2_Active_Status,
       count(customer_id) as Store2_Active_Customers_Count
from customer
where store_id = 2 and active = 1
group by active;
      
-- Question 4.
/*  
   In order to assess the liability of a data breach, we will need you to provide a count of all customer
   email addresses stored in the database. 
*/

select
      count(email) as Count_Of_Customers_Email
from customer;

-- Question 5. 
/*  
   We are interested in how diverse your film offering is as a means of understanding how likely you are to keep customers
   engaged in the future. Please provide a count of unique film titles you have in inventory at each store and provide a 
   count of the unique categories of films you provide.  
*/

select 
       Store_ID,
       count(distinct title) as Count_Of_Unique_Film_Titles,
       count(distinct category.name) as Unique_Categories
from category,inventory
    left join film 
        on film.film_id = inventory.film_id
group by store_id;

-- Question 6.
/*
   We would like to understand the replacement cost of your films.Please provide the replacement cost for the film that is least
   expensive to replace, the most expensive to replace, and the average of all films you carry.
*/

select 
       min(replacement_cost) as Minimum_Replacement_Cost,
	   max(replacement_cost) as Maximum_Replacement_Cost,
	   avg(replacement_cost) as Average_Replacement_Cost
from film;

-- Question 7. 
/*
   We are interested in having you put payment monitoring systems and maximum payment processing restrictions in place in order to
   minimize the future risk of fraud by your staff. Please provide the average payment you process, as well as the maximum payment 
   you have processed.
*/

select 
       avg(amount) as Average_Payment,
       max(amount) as Maximum_Payment
from payment;

-- Question 8.
/*
   We would like to better understand what your customer base looks like. Please provide a list of all customer identification values,
   with a count of rentals they have made all-time, with your highest volume customers at the top of the list.
*/ 

select
       Customer_ID,
       count(rental_id) as Count_Of_Rentals
from rental
group by customer_id
order by  Count_Of_Rentals desc;



