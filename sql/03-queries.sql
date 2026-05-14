-- =====================================================
-- 03-queries.sql
-- Queries de negócio para o sistema de gestão da academia
-- =====================================================

use academia;

-- Query 1: Alunos ativos ordenados por data de matrícula
select nome, sexo, data_matricula 
from aluno
where ativo = TRUE
order by data_matricula asc;

-- Query 2: Planos acima de R$ 500
select nome, valor, duracao_meses from plano
where valor > 500.00
order by valor;

-- Query 3: Alunos com sobrenome Silva ou Lima
select nome, email from aluno
where nome like '%silva%' or nome like '%lima%';

-- Query 4: Faturamento total da academia (apenas pagamentos confirmados)
select sum(valor) as faturamento_total
from pagamento
where status = 'pago';

-- Query 5: Estatísticas de salário dos personais ativos
select count(id) as qtde_personal, max(salario) as maior_salario, min(salario) as menor_salario, avg(salario) as salario_medio
from personal
where ativo = true;