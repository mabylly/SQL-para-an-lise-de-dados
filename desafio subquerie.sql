-- EXERCÍCIOS ########################################################################

-- (Exercício 1) Crie uma coluna calculada com o número de visitas realizadas por cada
-- cliente da tabela sales.customers
with n_visitas as(
	select customer_id,
	count(*) as num
	from sales.funnel
	group by customer_id
)
select 
	c.customer_id,
	n_visitas.num
from sales.customers as c
left join n_visitas 
	on c.customer_id = n_visitas.customer_id



