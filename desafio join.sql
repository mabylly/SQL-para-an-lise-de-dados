-- EXERCÍCIOS ########################################################################

-- (Exercício 1) Identifique quais as marcas de veículo mais visitada na tabela sales.funnel

select p.brand, count(f.visit_page_date) as visitas 
from sales.funnel as f  
left join sales.products as p
on f.product_id = p.product_id
group by p.brand
order by visitas desc
-- select * from sales.products
-- select * from sales.funnel


-- (Exercício 2) Identifique quais as lojas de veículo mais visitadas na tabela sales.funnel
select * from sales.funnel
select * from sales.stores
select * from sales.customers

select s.store_name, count(f.visit_page_date) as visitas 
from sales.funnel as f 
left join sales.stores as s
on f.store_id = s.store_id
group by s.store_name
order by visitas desc

-- (Exercício 3) Identifique quantos clientes moram em cada tamanho de cidade (o porte da cidade
-- consta na coluna "size" da tabela temp_tables.regions)
select * from sales.customers limit 10
select * from temp_tables.regions limit 10


select reg.size, count(c.customer_id) as clientes
from  sales.customers as c 
left join temp_tables.regions as reg
on lower(c.city) = lower(reg.city)
and lower(c.state) = lower(reg.state)
group by reg.size
order by clientes desc