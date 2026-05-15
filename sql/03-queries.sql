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

-- Query 9: Alunos com nome do personal (inclui alunos sem personal)
select a.nome as aluno_nome, p.nome as personal_nome
from aluno a
left join personal p on a.personal_id = p.id
order by aluno_nome;

-- Query 10: Plano vigente de cada aluno ativo
select a.nome as aluno_nome, pl.nome as plano_nome, ap.data_inicio
from aluno a
join aluno_plano ap on a.id = ap.aluno_id
join plano pl on ap.plano_id = pl.id
where ap.data_fim is null
and a.ativo = true
order by aluno_nome;

-- Query 11: Alunos sem ficha de treino cadastrada (anti-join)
select a.nome as aluno_nome
from aluno a
left join ficha_treino f on a.id = f.aluno_id
where f.id is null;

-- Query 12: 10 últimos pagamentos confirmados (com aluno e plano)
SELECT p.data_pagamento, p.valor, p.status, a.nome AS aluno_nome, pl.nome AS plano_nome
FROM pagamento p
JOIN aluno a ON p.aluno_id = a.id
JOIN plano pl ON p.plano_id = pl.id
WHERE p.status = 'pago'
ORDER BY p.data_pagamento DESC
LIMIT 10;

-- Query 13: Pagamentos acima da média (subquery escalar)
select data_pagamento, valor, aluno_id
from pagamento
where valor > (select avg(valor) from pagamento where status = 'pago')
and status = 'pago'
order by valor desc;

-- Query 14: Alunos com mais pagamentos que a média (subquery aninhada)
select a.nome as aluno_nome, count(*) as qtde_pagamentos
from pagamento p
join aluno a on p.aluno_id = a.id
group by a.id, a.nome
having qtde_pagamentos > (select avg(contagem) from (select count(*) as contagem from pagamento group by aluno_id) as subquery)
order by qtde_pagamentos desc;


