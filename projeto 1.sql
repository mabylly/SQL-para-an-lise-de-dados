-- (Query 1) Receita, leads, conversão e ticket médio mês a mês
-- Colunas: mês, leads (#), vendas (#), receita (k, R$), conversão (%), ticket médio (k, R$)
-- ticket medio: é a receita dividida pelo numero de vendas
with 
	leads as (
		select 
			date_trunc('month',visit_page_date)::date as visit_page_month,
			count(*) as visit_page_count
		from sales.funnel
		group by visit_page_month
		order by visit_page_month
	),
	payments as (
		select
			date_trunc('month',f.paid_date)::date as paid_month,
			count(f.paid_date) as paid_count,
			sum(p.price * (1 + f.discount)) as receita
		from sales.funnel as f
		left join sales.products as p
			on f.product_id = p.product_id
		where f.paid_date is not null
		group by paid_month
		order by paid_month
	)
select 
	leads.visit_page_month as "mês",
	leads.visit_page_count as "leads (#)",
	payments.paid_count as "vendas (#)",
	(payments.receita/1000) as "receita (k, R$)",
	(payments.paid_count::float/leads.visit_page_count::float) as "conversão (%)",
	(payments.receita/payments.paid_count/1000) as "ticket médio (k, R$)"
	
from leads
left join payments
	on leads.visit_page_month = paid_month 
-- (Query 2) Estados que mais venderam
-- Colunas: país, estado, vendas (#)
select
	'Brazil' as país,
	c.state as estado,
	count(f.paid_date) as "vendas (#)"
	
from sales.funnel as f
left join sales.customers as c
	on f.customer_id = c.customer_id
where paid_date between '2021-08-01' and '2021-08-31'
group by país , estado
order by "vendas (#)" desc
limit 5
-- (Query 3) Marcas que mais venderam no mês
-- Colunas: marca, vendas (#)


-- (Query 4) Lojas que mais venderam
-- Colunas: loja, vendas (#)


-- (Query 5) Dias da semana com maior número de visitas ao site
-- Colunas: dia_semana, dia da semana, visitas (#)
