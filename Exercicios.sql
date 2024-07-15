-- select: serve para selecionar colunas de tabelas

-- Liste os emails dos clientes da tabela sales.customers

select email
from sales.customers


-- Liste os emails e nomes dos clientes da tabela sales.customers (mais de uma coluna)

select email, first_name, last_name
from sales.customers

-- Selecionar todas as colunas da tabela sales.customers

select *
from sales.customers

----------------------------------------------------------------------------------


-- Distinct: serve para remover linhas duplicadas e mostrar apenas linhas distintas 
-- Muito usado na etapa de exploração das bases

-- Seleção de uma coluna sem o DISTINCT
-- Liste as marcas de carro que constam na tabela products

select brand
from sales.products

-- Seleção de uma coluna com DISTINCT
-- Liste as marcas de carro distintas que constam na tabela products

select distinct brand
from sales.products

-- Seleção de mais de uma coluna com DISTINCT
-- Liste as marcas e anos de modelo distintos que constam na tabela products

select distinct brand, model_year
from sales.products

-- Resumo:
-- 1 Comando usado para remover linhas duplicadas e mostrar apenas linhas distintas.
-- 2 Muito utilizado na etapa de exploração dos dados.
-- 3 Caso mais de uma colunas seja selecionada, o comando SELECT DISTINCT irá 
-- retornar todas as combinações distintas.
-------------------------------------------------------------------------------- 

-- where: serve paar filtrar as linhas da tabela de acordo com uma condição 

-- Filtro com condição única
-- Liste os emails dos clientes da nossa base que moram no estado de Santa Catarina

select email, state
from sales.customers
where state = 'SC'

-- Filtro com mais de uma condição 
-- Liste os emails dos clientes da nossa base que moram no estado de Santa Catarina
-- ou Mato Grosso do Sul

select email, state
from sales.customers
where state = 'SC' or state = 'MS'

-- Filtro de condição com data 
-- Liste os emails dos clientes da nossa base que moram no estado de Santa catarina
-- ou Mato Grosso do Sul e que tem mais de 30 anos

select email, state, birth_date
from sales.customers
where (state = 'SC' or state = 'MS') and birth_date < '1994-06-20'

-- datas pode usar sem traços também

-- Resumo: 
-- 1 Comando utilizado para filtrar linhas de acordo com uma condição 
-- 2 No PostegreSQL são utilizadas aspas simples para delimitar strings
-- 3 string = sequência de caracteres = texto
-- 4 Pode-se combinar mais de uma condição utilizando os operadores 
-- 5 No PostgreeSQl as datas são escritas no formato 'YYYY-MM-DD' ou 'YYYYMMDD'

-----------------------------------------------------------------------------------

-- order by: serve para ordenar a seleção de acordo com uma regra definida pelo usuário

-- Ordenação por valores numéricos
-- Liste produtos da tabela products na ordem crescente com base no preço

select *
from  sales.products
order by price desc

-- desc significa decrescente

-- Ordenação de texto
-- Liste os estados distintos da tabela customers na ordem crescente

select distinct state 
from sales.customers
order by state

-- Resumo:
-- 1 Comando utilizado para ordenar a seleção de acordo com uma regra definida
-- 2 Por padrão o comando ordena na ordem crescente. Para mudar a ordem 
-- decrescente usar  o comando DESC
-- 3 No caso de strings a ordenação será a ordem alfabética

-----------------------------------------------------------------------------------

-- limit: serve para limitar o n° de linhas da consulta
-- Muito utilizado na etapa de exploração dos dados

-- Seleção das N primeiras linhas usando LIMIT
-- Liste as 10 primeiras linhas da tabela funnel

select *
from sales.funnel
limit 10

-- Seleção das N primeiras linhas usando LIMIT e ORDER BY
-- Liste os 10 produtos mais caros da tabela products

select *
from sales.products
order by price desc
limit 10

-- Resumo:
-- 1 comando utilizado para limitar o n° de linhas da consulta
-- 2 muito utilizado na etapa de exploração de dados 
-- 3 muito utilizado em conjunto com o comando ORDER BY quando o que importa são
-- os TOP N. EX: "N pagamentos mais recentes", "N produtos mais caros"

------------------------------------------------------------------------------------

-- EXERCÍCIOS ######################################################################

-- (Exercício 1) Selecione os nomes de cidade distintas que existem no estado de
-- Minas Gerais em ordem alfabética (dados da tabela sales.customers)
select  distinct city
from sales.customers
where state = 'MG'
order by city


-- (Exercício 2) Selecione o visit_id das 10 compras mais recentes efetuadas
-- (dados da tabela sales.funnel)
select visit_id
from sales.funnel
where paid_date is not null
order by paid_date desc
limit 10

-- (Exercício 3) Selecione todos os dados dos 10 clientes com maior score nascidos
-- após 01/01/2000 (dados da tabela sales.customers)
select *
from sales.customers
where birth_date >= '2000-01-01'
order by score desc
limit 10

--------------------------------------------------------------------------------------

-- Funções de agregação
-- Serve para executar operações aritméticas nos registros de uma coluna

-- Tipos:
-- COUNT()
-- SUM()
-- MIN()
-- MAX()
-- AVG()

-- Exemplos:

-- COUNT()

-- Exemplo 1 - Contagem de todas as linhas de uma tabela
-- Conte todas as visitas realizadas ao site da empresa fictícia

select count(*)
from sales.funnel

-- Exemplo 2 - Contagem das linhas de uma coluna
-- Conte todos os pagamentos registrados na tabela sales.funnel

select count(paid_date)
from sales.funnel

-- Exemplo 3 - Contagem distinta de uma coluna
-- Conte todos os produtos distintos visitados em jan/21

select count(distinct product_id)
from sales.funnel
where visit_page_date between '2021-01-01' and '2021-01-31'

-- Exemplo 4 - Calcule o preço mínimo, máximo e médio dos produtos da tabela products

select min(price), max(price), avg(price)
from sales.products

-- Exemplo 5 - Informe qual é o veículo mais caro da tabela products

select *
from sales.products
where price = (select max(price) from sales.products)

-- Resumo de funções agregadas:
-- Servem para executar operações aritméticas nos registros de uma coluna 
-- Funções agregadas não computam células vazias (NULL) como zero
-- Na função COUNT() pode-se utilizar o asterisco (*) para contar os registros
-- COUNT(DISTINCT) irá contar apenas os valores exclusivos

--------------------------------------------------------------------------------------

-- GROUP BY: serve para agrupar registros semelhantes de uma coluna 
-- Normalmente utilizado em conjunto com as funções de agregação

-- Exemplo 1 - contagem agrupada de uma coluna
-- Calcule o nº de clientes da tabela customers por estado

select state, count(*) as contagem
from sales.customers
group by state
order by contagem desc

-- Exemplo 2 - Contagem agrupada de várias colunas 
-- Calcule o nº de clientes por estado e status profissional

select state, professional_status, count(*) as contagem
from sales.customers
group by state, professional_status
order by state, contagem desc

-- Exemplo 3 - Seleção de valores distintos 
-- Selecione os estados distintos na tabela customers utilizando o group by

select distinct state
from sales.customers

select state 
from sales.customers
group by state

-- Resumo:
-- Serve para agrupar registros semelhantes de uma coluna,
-- Normalmente utilizado em conjunto com as funções de agregação
-- Pode-se referenciar a coluna a ser agrupada pela sua posição ordinal
-- ex: GROUP BY 1,2,3 irá agrupar pelas 3 primeiras colunas da tabela 
-- O group by sozinho funciona como um DISTINCT, eliminando linhas duplicadas

-------------------------------------------------------------------------------------

-- HAVING
-- Serve para filtrar linhas da seleção por uma coluna agrupada
-- Exemplo 1 - Seleção de filtros no HAVING
-- Calcule o nº de clientes por estado filtrando apenas estados acima de 100 clientes

select
	state,
	count(*)
from sales.customers
group by state
having count(*) > 100

-- Resumo:
-- Tem a mesma função do WHERE mas pode ser usado para filtrar os resultados
-- das funções agregadas enquanto o WHERE possui essa limitação
-- A função HAVING também pode filtrar colunas não agregadas 

-- EXERCÍCIOS ########################################################################

-- (Exercício 1) Conte quantos clientes da tabela sales.customers tem menos de 30 anos
select count (*)
from sales.customers
where ((current_date - birth_date) / 365 ) < 30

-- (Exercício 2) Informe a idade do cliente mais velho e mais novo da tabela sales.customers
select 
	max((current_date - birth_date) / 365 ),
	min((current_date - birth_date) / 365 )
from sales.customers

-- (Exercício 3) Selecione todas as informações do cliente mais rico da tabela sales.customers
-- (possívelmente a resposta contém mais de um cliente)
select *
from sales.customers
where income = (select max(income) from sales.customers)

-- (Exercício 4) Conte quantos veículos de cada marca tem registrado na tabela sales.products
-- Ordene o resultado pelo nome da marca
select brand, count(*)
from sales.products
group by brand
order by brand 

-- (Exercício 5) Conte quantos veículos existem registrados na tabela sales.products
-- por marca e ano do modelo. Ordene pela nome da marca e pelo ano do veículo
select brand, model_year, count(*)
from sales.products
group by brand, model_year
order by brand , model_year

-- (Exercício 6) Conte quantos veículos de cada marca tem registrado na tabela sales.products
-- e mostre apenas as marcas que contém mais de 10 veículos registrados
select brand, count(*)
from sales.products
group by brand
having count(*) > 10 

----------------------------------------------------------------------------------------------
-- JOIN

-- Exemplo 1 - Utilize o LEFT JOIN para fazer join entre as tabelas
-- 	temp_tables.tabela_1 e temp_tables.tabela_2
select * from temp_tables.tabela_1
select * from temp_tables.tabela_2

select t1.cpf, t1.name, t2.state
from temp_tables.tabela_1 as t1
left join temp_tables.tabela_2 as t2
on t1.cpf = t2.cpf

-- Exemplo 2 - Utilize o INNER JOIN para fazer join entre as tabelas
-- 	temp_tables.tabela_1 e temp_tables.tabela_2	

select t1.cpf, t1.name, t2.state
from temp_tables.tabela_1 as t1
inner join temp_tables.tabela_2 as t2
on t1.cpf = t2.cpf

-- Exemplo 3 - Utilize o RIGHT JOIN para fazer join entre as tabelas
-- 	temp_tables.tabela_1 e temp_tables.tabela_2	

select t2.cpf, t1.name, t2.state
from temp_tables.tabela_1 as t1
right join temp_tables.tabela_2 as t2
on t1.cpf = t2.cpf

-- Exemplo 4 - Utilize o RIGHT JOIN para fazer join entre as tabelas
-- 	temp_tables.tabela_1 e temp_tables.tabela_2	

select t2.cpf, t1.name, t2.state
from temp_tables.tabela_1 as t1
full join temp_tables.tabela_2 as t2
on t1.cpf = t2.cpf

-- Exercícios

-- Exemplo 1 - Identifique qual é o status profissional mais frequente nos clientes 
-- que compraram automóveis no site
select 
	cus.professional_status,
	count(fun.paid_date) as pagamentos
	
from sales.funnel as fun
left join sales.customers as cus
	on fun.customer_id = cus.customer_id
group by cus.professional_status
order by pagamentos desc

-- Exemplo 2 - Identifique qual é o gênero mais frequente nos clientes que compraram 
-- automóveis no site. Obs: utilizar a tabela temp_tables.ibge_genders

select * from temp_tables.ibge_genders limit 10


select 
	ibge.gender,
	count(fun.paid_date)
from sales.funnel as fun
left join sales.customers as cus
	on fun.customer_id = cus.customer_id
left join temp_tables.ibge_genders as ibge
	on lower(cus.first_name) = ibge.first_name
group by ibge.gender

-- (Exemplo 3) Identifique de quais regiões são os clientes que mais visitam o site
-- Obs: Utilizar a tabela temp_tables.regions

select * from sales.customers limit 10
select * from temp_tables.regions limit 10

select
	reg.region,
	count(fun.visit_page_date) as visitas
from sales.funnel as fun
left join sales.customers as cus
	on fun.customer_id = cus.customer_id
left join temp_tables.regions as reg
	on lower(cus.city) = lower(reg.city)
	and lower(cus.state) = lower(reg.state)
group by reg.region
order by visitas desc

-- EXERCÍCIOS ########################################################################

-- (Exercício 1) Identifique quais as marcas de veículo mais visitada na tabela sales.funnel

select 
	pro.brand,
	count(*) as visitas

from sales.funnel as fun
left join sales.products as pro
	on fun.product_id = pro.product_id
group by pro.brand
order by visitas desc


-- (Exercício 2) Identifique quais as lojas de veículo mais visitadas na tabela sales.funnel

select 
	sto.store_name,
	count(*) as visitas

from sales.funnel as fun
left join sales.stores as sto
	on fun.store_id = sto.store_id
group by sto.store_name
order by visitas desc



-- (Exercício 3) Identifique quantos clientes moram em cada tamanho de cidade (o porte da cidade
-- consta na coluna "size" da tabela temp_tables.regions)

select
	reg.size,
	count(*) as contagem
from sales.customers as cus
left join temp_tables.regions as reg
	on lower(cus.city) = lower(reg.city)
	and lower(cus.state) = lower(reg.state)
group by reg.size
order by contagem

-----------------------------------------------------------------------------------------

-- UNIONS

-- Exemplo 1 - União simples de duas tabelas
-- Una a tabela sales.products com a tabela temp_tables.products_2

select * from sales.products
union all
select * from temp_tables.products_2

----------------------------------------------------------------------------------------

-- Tipos de Subquery

-- Serve para consultar dados de outras consultas

-- tipos
-- subquery no where
-- subquery com with
-- subquery no from 
-- subquery no select

-- Exemplo 1 - Subquery no WHERE
-- Informe qual é o veículo mais barato da tabela products
select *
from sales.products
where price = (select min(price) from sales.products)

-- Exemplo 2 - Subquery com WITH
-- Calcule a idade média dos clientes por status profissional 
with alguma_tabela as (
select 
	professional_status,
	(current_date - birth_date)/ 365 as idade 
from sales.customers
)

select
	professional_status,
	avg(idade) as idade_media
from alguma_tabela
group by professional_status

-- (Exemplo 3) Subquery no FROM
-- Calcule a média de idades dos clientes por status profissional
select
	professional_status,
	avg(idade) as idade_media
from (
		select
			professional_status,
			(current_date - birth_date)/365 as idade
		from sales.customers
	 ) as alguma_tabela
group by professional_status


-- (Exemplo 4) Subquery no SELECT
-- Na tabela sales.funnel crie uma coluna que informe o nº de visitas acumuladas 
-- que a loja visitada recebeu até o momento

select
	fun.visit_id,
	fun.visit_page_date,
	sto.store_name,
	(
		select count(*)
		from sales.funnel as fun2
		where fun2.visit_page_date <= fun.visit_page_date
			and fun2.store_id = fun.store_id
	) as visitas_acumuladas
from sales.funnel as fun
left join sales.stores as sto
	on fun.store_id = sto.store_id
order by sto.store_name, fun.visit_page_date


-- RESUMO ##########################################################################
-- (1) Servem para consultar dados de outras consultas.
-- (2) Para que as subqueries no WHERE e no SELECT funcionem, elas devem retornar 
-- apenas um único valor
-- (3) Não é recomendado utilizar subqueries diretamente dentro do FROM pois isso 
-- dificulta a legibilidade da query. 

-- EXEMPLOS ########################################################################

-- (Exemplo 1) Análise de recorrência dos leads
-- Calcule o volume de visitas por dia ao site separado por 1ª visita e demais visitas

with primeira_visita as (

	select customer_id, min(visit_page_date) as visita_1
	from sales.funnel
	group by customer_id

)

select
	fun.visit_page_date,
	(fun.visit_page_date <> primeira_visita.visita_1) as lead_recorrente,
	count(*)

from sales.funnel as fun
left join primeira_visita
	on fun.customer_id = primeira_visita.customer_id
group by fun.visit_page_date, lead_recorrente
order by fun.visit_page_date desc, lead_recorrente




-- (Exemplo 2) Análise do preço versus o preço médio
-- Calcule, para cada visita ao site, quanto o preço do um veículo visitado pelo cliente
-- estava acima ou abaixo do preço médio dos veículos daquela marca 
-- (levar em consideração o desconto dado no veículo)

with preco_medio as (

	select brand, avg(price) as preco_medio_da_marca
	from sales.products
	group by brand

)

select
	fun.visit_id,
	fun.visit_page_date,
	pro.brand,
	(pro.price * (1+fun.discount)) as preco_final,
	preco_medio.preco_medio_da_marca,
	((pro.price * (1+fun.discount)) - preco_medio.preco_medio_da_marca) as preco_vs_media

from sales.funnel as fun
left join sales.products as pro
	on fun.product_id = pro.product_id
left join preco_medio
	on pro.brand = preco_medio.brand
	
-- EXERCÍCIOS ########################################################################

-- (Exercício 1) Crie uma coluna calculada com o número de visitas realizadas por cada
-- cliente da tabela sales.customers

with numero_de_visitas as (

	select customer_id, count(*) as n_visitas
	from sales.funnel
	group by customer_id

)

select
	cus.*,
	n_visitas

from sales.customers as cus
left join numero_de_visitas as ndv
	on cus.customer_id = ndv.customer_id













































































































