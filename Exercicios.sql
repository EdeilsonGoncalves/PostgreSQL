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


-- Distinct: serve para remover linhas duplicadas e mostrar apenas linhas distintas 
-- Muito usado na etapa de exploração das bases























