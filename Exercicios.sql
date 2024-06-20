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



















