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



































































