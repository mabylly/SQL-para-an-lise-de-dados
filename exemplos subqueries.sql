-- EXEMPLOS ########################################################################

-- (Exemplo 1) Análise de recorrência dos leads
-- Calcule o volume de visitas por dia ao site separado por 1ª visita e demais visitas
with primeira_visita as(

	select customer_id, min(visit_page_date) as visita_1
	from sales.funnel
	group by customer_id
)
select
	f.visit_page_date,
	(f.visit_page_date <> primeira_visita.visita_1) as lead_recorrente,
	count(*)
from sales.funnel as f
left join primeira_visita
	on f.customer_id = primeira_visita.customer_id
group by f.visit_page_date , lead_recorrente
order by f.visit_page_date desc, lead_recorrente

-- (Exemplo 2) Análise do preço versus o preço médio
-- Calcule, para cada visita ao site, quanto o preço do um veículo visitado pelo cliente
-- estava acima ou abaixo do preço médio dos veículos daquela marca 
-- (levar em consideração o desconto dado no veículo)
with preco_medio as (

	select brand, avg(price) as preco_medio_marca
	from sales.products
	group by brand
)
select
	f.visit_id,
	f.visit_page_date,
	p.brand,
	(p.price * (1 + f.discount)) as preco_final,
	preco_medio.preco_medio_marca,
	((p.price * (1 + f.discount)) - preco_medio.preco_medio_marca) as preco_vs_media
from sales.funnel as f
left join sales.products as p
	on  f.product_id = p.product_id
left join preco_medio
	on p.brand = preco_medio.brand
	
