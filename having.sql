-- PARA QUE SERVE ##################################################################
-- Serve para filtrar linhas da seleção por uma coluna agrupada


-- EXEMPLOS ########################################################################

-- (Exemplo 1) seleção com filtro no HAVING 
-- Calcule o nº de clientes por estado filtrando apenas estados acima de 100 clientes
select 
    state, 
    count(*) as cont
from sales.customers
group by state
having count(*) > 100
order by cont desc

-- where funciona para colunas somente não agregadas, ja having funciona para as duas
select 
    state, 
    count(*) as cont
from sales.customers
where state <> 'MG'
group by state
having count(*) > 100
order by cont desc

-- RESUMO ##########################################################################
-- (1) Tem a mesma função do WHERE mas pode ser usado para filtrar os resultados 
-- das funções agregadas enquanto o WHERE possui essa limitação
-- (2) A função HAVING também pode filtrar colunas não agregadas








