-- ASSIGNMENT ON JOINS

-- Question 1.
/*
   My partner and I want to come by each of the stores in person and meet the managers.
   Please send over the managers' name at each store, with the full address of each 
   property (street address, district, city and country please)
*/

select
      st.Store_ID,
      s.First_Name,
      s.Last_Name,
      a.Address,
      a.District,
      c.City,
      co.Country
from staff as s
left join store as st
   on s.staff_id = st.manager_staff_id
left join address as a
   on st.address_id = a.address_id
left  join city as c
   on a.city_id = c.city_id
left join country as co
   on c.country_id = co.country_id;

-- Question 2.
/*
   I would like to get a better understanding of all of the inventory that would come along with the business.
   Please pull together a list of each inventory item you have stocked , including the store_id number,
   the inventory id, the name of the film , the film's rating , its rental rate and replacement cost.
*/

select
	  i.Inventory_ID,
      i.Store_ID,
      f.title as Name_of_the_Film,
      f.Rating,
      f.Rental_Rate,
      f.Replacement_Cost
from inventory as i
left join film as f
    on i.film_id = f.film_id;

-- Question 3.
/*
   From the same list of films you just pulled, please roll that data up and provide a summary level overview
   of your inventory. We would like to know how many inventory items you have with each rating with each store.
*/

select
	  i.Store_ID,
	  f.Rating,
      count(i.Inventory_ID) as Count_of_Inventories
from inventory as i
left join film as f
    on i.film_id = f.film_id
group by  i.Store_ID, f.Rating;

-- Question 4.
/*
   Similarly we want to understand how diversified the inventory is in terms of replacement cost. We want to see
   how big of a hit it would be if a certain category film became unpopular at a certain store. We would like to 
   see the number of films, as well as the average replacement cost, and total replacement cost, sliced by store 
   and film category.
*/

select
      i.Store_ID,
      c.Category_ID,
      name as Category_Name,
      count(f.film_id) as Count_of_Films,
      avg(replacement_cost) as Average_Replacement_Cost,
	  sum(replacement_cost) as Total_Replacement_Cost
from category as c 
    left join film_category as fc
        on fc.category_id = c.category_id
	left join film as f
       on fc.film_id = f.film_id
	left join inventory as i     
        on f.film_id = i.film_id
group by store_id , c.category_ID,Category_Name;
  
-- Question 5.
/*
   We want to make sure you folks have a good handle on who your customers are. Please provide a list of all
   customer names, which store they go to , whether or not they are currently active and their full addresses -
   street address, city and country.
*/

select 
     c.Customer_ID,
     c.First_Name,
     c.Last_Name,
     c.Store_ID,
	 c.Active,
     a.Address,
     ci.City, 
     co.Country
from customer as c
left join address as a
    on c.address_id = a.address_id
left join city as ci
    on a.city_id = ci.city_id
left join country as co
    on ci.country_id = co.country_id;

-- Question 6.
/*
   We would like to understand how much your customers are spending with you, and also to know who your most valuable customers are.
   Please pull together a list of customer names, their total lifetime rentals, and the sum of all payments you have collected from
   them. It would be great to see this ordered on total lifetime value, with the most valuable customers at the top of the list.
*/
  
  select 
         c.Customer_ID,
         c.First_Name,
         c.Last_Name,
         count(p.rental_id) as Total_Lifetime_Rentals,
         sum(amount) as Sum_of_Payments
from customer as c
   left join payment as p
       on c.customer_id = p.customer_id
group by  c.Customer_ID, c.First_Name, c.Last_Name
order by sum_of_payments desc;

-- Question 7.
/*
   My partner and I would like to get to know your board of advisors and any current investors. Could you please
   provide  a list of advisor and investor names in one table? Could you please note whether they are an investor 
   or an advisor, and for the investors, it would be good to include which company they work with.
*/

select 
     advisor_id as Stakeholder_ID,
     first_name,
     last_name,
     "advisor" as Stakeholder,
     "Maven movies" as Company_Name
 from advisor
 union
 select 
     investor_id as Stakeholder_ID,
     first_name,
     last_name,
	 "investor" as Stakeholder,
     Company_Name
 from investor;
 
-- Question 8.
/*
   We're interested in how well you have covered the most-awarded actors. Of all the actors with three types of awards,
   for what % of them do we carry a film? And how about for actors with two types of awards? Same questions. Finally
   how about actors with just one award?
*/

with AwardsCount as(
						select 
								awards,
							   count(actor_award_id) as TotalAwards,
							   count(case when awards in ( "Emmy" , "Oscar" , "Tony") then actor_award_id  
									else null end) as Actors_With_One_Award,
							   count(case when awards in ("Emmy, Oscar" , "Oscar, Tony" , "Emmy, Tony" ) then actor_award_id 
									else null end) as Actors_With_Two_Awards,
							   count(case when awards = "Emmy, Oscar, Tony" then actor_award_id  
									else null end) as Actors_With_Three_Awards
						from actor_award
						group by awards
                  )

select 
      (sum(Actors_With_One_Award) /  (sum(totalawards) * 1.0) ) +
      (sum(Actors_With_Two_Awards ) /  (sum(totalawards) * 2.0) ) +
      (sum(Actors_With_Three_Awards) / ( sum(totalawards) * 3.0 )) as Result
from AwardsCount;


  


