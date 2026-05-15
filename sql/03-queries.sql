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

-- Query 6: Distribuição de pagamentos por forma de pagamento (apenas confirmados)
select forma_pagamento, count(*) as qtde_pagamentos, sum(valor) as total_faturado
from pagamento
where status = 'pago'
group by forma_pagamento
order by total_faturado desc;

-- Query 7: Faturamento mensal de 2025 (apenas pagamentos confirmados)
select month(data_pagamento) as mes, sum(valor) as faturamento
from pagamento
where status = 'pago'
and year(data_pagamento) = 2025
group by month(data_pagamento)
order by mes asc;

-- Query 8: Planos com mais de 1 aluno em vínculo vigente
select p.nome, count(ap.aluno_id) as qtde_alunos
from aluno_plano ap
join plano p on ap.plano_id = p.id
where ap.data_fim is null
group by p.nome
having COUNT(ap.aluno_id) > 1
order by qtde_alunos desc;