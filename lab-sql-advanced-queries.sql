use sakila;

select film_id, count(actor_id) as 'num_actors' from film_actor
group by film_id;

select actor_id, count(film_id) as 'num_movies' from film_actor
group by actor_id
order by num_movies DESC;

select actor_id, film_id, count(film_id) as 'num_movies', rank() over (partition by film_id order by 'num_movies' DESC) as ranking from film_actor
group by actor_id;
#order by ranking;

select actor_id, film_id as 'num_movies', row_number() over (partition by film_id order by 'num_movies' DESC) as ranking from film_actor;
#group by actor_id
#order by ranking;

describe film_actor;

select f_a1.actor_id, f_a1.film_id, sub1.num_movies, row_number() over (partition by f_a1.film_id order by sub1.num_movies DESC) as ranking from film_actor as f_a1
join (select actor_id, count(film_id) as 'num_movies' from film_actor as f_a2
group by actor_id
order by num_movies DESC) 
as sub1 on sub1.actor_id = f_a1.actor_id;

select film_id, actor_id from (
select f_a1.actor_id, f_a1.film_id, sub1.num_movies, row_number() over (partition by f_a1.film_id order by sub1.num_movies DESC) as ranking from film_actor as f_a1
join (select actor_id, count(film_id) as 'num_movies' from film_actor as f_a2
group by actor_id
order by num_movies DESC) 
as sub1 on sub1.actor_id = f_a1.actor_id) as sub2
where ranking = 1;

