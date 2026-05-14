use academia;

-- Limpa dados existentes para evitar duplicações
set foreign_key_checks = 0; -- Desliga temporariamente a verificação de chave estrangeira
truncate table ficha_treino; -- Apaga todas as linhas e reseta o auto_increment
truncate table pagamento;
truncate table aluno_plano;
truncate table aluno;
truncate table personal;
truncate table plano;
set foreign_key_checks = 1; -- Reativa a verificação


insert into plano (nome, valor, duracao_meses) values
    ('Mensal', 130.00, 1),
    ('Semestral', 663.00, 6),
    ('Anual', 1170.00, 12);


insert into personal (nome, cpf, email, telefone, data_contratacao, salario, especialidade, ativo) values
    ('Luciano Souza', '15753436750', 'luciano@academia.com', '33968438125', '2025-09-05', 1899.00, 'Musculação', TRUE),
    ('Maria Oliveira', '35795985380', 'maria@academia.com', '33934543145', '2025-01-07', 2102.00, 'Crossfit', TRUE),
    ('Marcos Pereira', '23173215770', 'marcos@academia.com', '33965273015', '2025-09-06', 1830.00, 'Funcional', FALSE);


-- IDs de personal: 1=Luciano, 2=Maria, 3=Marcos
insert into aluno (nome, cpf, email, telefone, data_nascimento, sexo, data_matricula, ativo, personal_id) values
    ('Carlos Eduardo Santos', '10000000001', 'carlos.santos@email.com', '31987651001', '1998-01-01', 'M', '2025-01-15 10:00:00', TRUE, 1),
    ('Mariana Silva Costa',   '10000000002', 'mariana.costa@email.com', '31987651002', '1992-01-01', 'F', '2025-02-15 14:30:00', TRUE, 2),
    ('Roberto Costa Lima',    '10000000003', 'roberto.lima@email.com',  '31987651003', '1981-01-01', 'M', '2025-03-15 09:15:00', TRUE, 3),
    ('Fernanda Lima Souza',   '10000000004', 'fernanda.souza@email.com','31987651004', '2004-01-01', 'F', '2025-04-15 16:45:00', TRUE, 1),
    ('João Pedro Almeida',    '10000000005', 'joao.almeida@email.com',  '31987651005', '1996-01-01', 'M', '2025-05-15 11:00:00', TRUE, 2),
    ('Bruna Oliveira Pinto',  '10000000006', 'bruna.pinto@email.com',   '31987651006', '2000-01-01', 'F', '2025-06-15 18:20:00', TRUE, NULL),
    ('Ricardo Alves Moreira', '10000000007', 'ricardo.moreira@email.com','31987651007','1974-01-01', 'M', '2025-07-15 08:00:00', TRUE, 1),
    ('Patrícia Gomes Ferreira','10000000008','patricia.gomes@email.com','31987651008', '1988-01-01', 'F', '2025-08-15 15:00:00', TRUE, NULL),
    ('Lucas Mendes Carvalho', '10000000009', 'lucas.mendes@email.com',  '31987651009', '1985-01-01', 'M', '2025-09-15 19:30:00', FALSE, NULL),
    ('Amanda Rocha Dias',     '10000000010', 'amanda.rocha@email.com',  '31987651010', '2007-01-01', 'F', '2025-10-15 12:00:00', FALSE, 3);


insert into aluno_plano (aluno_id, plano_id, data_inicio, data_fim) values
    (1,  3, '2025-01-15', NULL),       -- Carlos, Anual
    (3,  1, '2025-03-15', NULL),       -- Roberto, Mensal
    (6,  1, '2025-06-15', NULL),       -- Bruna, Mensal
    (7,  2, '2025-07-15', NULL),       -- Ricardo, Semestral
    (8,  1, '2025-08-15', NULL),       -- Patrícia, Mensal
    
    -- Perfil B: histórico de troca (2 linhas por aluno)
    (2,  1, '2025-02-15', '2025-07-31'),  -- Mariana, Mensal (finalizado)
    (2,  2, '2025-08-01', NULL),          -- Mariana, Semestral (vigente)
    
    (4,  1, '2025-04-15', '2025-09-30'),  -- Fernanda, Mensal (finalizado)
    (4,  3, '2025-10-01', NULL),          -- Fernanda, Anual (vigente)
    
    (5,  1, '2025-05-15', '2025-10-31'),  -- João, Mensal (finalizado)
    (5,  1, '2025-11-01', NULL),          -- João, Mensal (renovou)
    
    -- Perfil C: alunos inativos com plano cancelado
    (9,  1, '2025-09-15', '2025-12-15'),  -- Lucas, Mensal (cancelado)
    (10, 1, '2025-10-15', '2026-01-15');  -- Amanda, Mensal (cancelado)


insert into pagamento (aluno_id, plano_id, valor, data_pagamento, forma_pagamento, status) values
    -- Carlos (id 1) — Anual, 2 pagamentos
    (1, 3, 1170.00, '2025-01-15 14:20:00', 'cartao_credito', 'pago'),
    (1, 3, 1170.00, '2026-01-14 09:45:00', 'pix',            'pago'),

    -- Mariana (id 2) — Mensal (fev–jul/2025) + Semestral (ago/2025 + fev/2026)
    (2, 1,  130.00, '2025-02-15 18:00:00', 'pix',            'pago'),
    (2, 1,  130.00, '2025-03-16 10:30:00', 'pix',            'pago'),
    (2, 1,  130.00, '2025-04-15 11:15:00', 'cartao_debito',  'pago'),
    (2, 1,  130.00, '2025-05-15 19:40:00', 'pix',            'pago'),
    (2, 1,  130.00, '2025-06-14 08:50:00', 'dinheiro',       'pago'),
    (2, 1,  130.00, '2025-07-15 17:25:00', 'pix',            'pago'),
    (2, 2,  663.00, '2025-08-01 14:00:00', 'cartao_credito', 'pago'),
    (2, 2,  663.00, '2026-02-02 16:30:00', 'pix',            'pago'),

    -- Roberto (id 3) — Mensal, 14 pagos + 1 ATRASADO (mai/2026)
    (3, 1,  130.00, '2025-03-15 09:00:00', 'dinheiro',       'pago'),
    (3, 1,  130.00, '2025-04-15 10:00:00', 'dinheiro',       'pago'),
    (3, 1,  130.00, '2025-05-16 11:00:00', 'dinheiro',       'pago'),
    (3, 1,  130.00, '2025-06-15 09:30:00', 'pix',            'pago'),
    (3, 1,  130.00, '2025-07-14 14:20:00', 'pix',            'pago'),
    (3, 1,  130.00, '2025-08-15 15:10:00', 'pix',            'pago'),
    (3, 1,  130.00, '2025-09-15 16:40:00', 'cartao_debito',  'pago'),
    (3, 1,  130.00, '2025-10-15 08:55:00', 'pix',            'pago'),
    (3, 1,  130.00, '2025-11-15 12:00:00', 'pix',            'pago'),
    (3, 1,  130.00, '2025-12-15 13:30:00', 'cartao_credito', 'pago'),
    (3, 1,  130.00, '2026-01-15 10:25:00', 'pix',            'pago'),
    (3, 1,  130.00, '2026-02-16 17:00:00', 'pix',            'pago'),
    (3, 1,  130.00, '2026-03-15 18:30:00', 'cartao_debito',  'pago'),
    (3, 1,  130.00, '2026-04-15 09:10:00', 'pix',            'pago'),
    (3, 1,  130.00, '2026-05-15 00:00:00', 'boleto',         'atrasado'),

    -- Fernanda (id 4) — Mensal (abr–set/2025) + Anual (out/2025)
    (4, 1,  130.00, '2025-04-15 19:00:00', 'pix',            'pago'),
    (4, 1,  130.00, '2025-05-14 18:30:00', 'pix',            'pago'),
    (4, 1,  130.00, '2025-06-15 20:15:00', 'cartao_credito', 'pago'),
    (4, 1,  130.00, '2025-07-15 11:00:00', 'pix',            'pago'),
    (4, 1,  130.00, '2025-08-15 09:45:00', 'cartao_debito',  'pago'),
    (4, 1,  130.00, '2025-09-15 14:30:00', 'pix',            'pago'),
    (4, 3, 1170.00, '2025-10-01 10:00:00', 'cartao_credito', 'pago'),

    -- João (id 5) — Mensal renovado, 13 pagamentos
    (5, 1,  130.00, '2025-05-15 11:00:00', 'cartao_debito',  'pago'),
    (5, 1,  130.00, '2025-06-15 12:30:00', 'cartao_debito',  'pago'),
    (5, 1,  130.00, '2025-07-15 09:00:00', 'pix',            'pago'),
    (5, 1,  130.00, '2025-08-16 10:45:00', 'pix',            'pago'),
    (5, 1,  130.00, '2025-09-15 16:00:00', 'pix',            'pago'),
    (5, 1,  130.00, '2025-10-15 17:20:00', 'dinheiro',       'pago'),
    (5, 1,  130.00, '2025-11-01 13:10:00', 'pix',            'pago'),
    (5, 1,  130.00, '2025-12-01 14:25:00', 'pix',            'pago'),
    (5, 1,  130.00, '2026-01-02 10:00:00', 'pix',            'pago'),
    (5, 1,  130.00, '2026-02-01 11:30:00', 'pix',            'pago'),
    (5, 1,  130.00, '2026-03-01 12:15:00', 'cartao_credito', 'pago'),
    (5, 1,  130.00, '2026-04-01 08:40:00', 'pix',            'pago'),
    (5, 1,  130.00, '2026-05-02 09:55:00', 'pix',            'pago'),

    -- Bruna (id 6) — Mensal, 12 pagamentos; 1 ESTORNADO antigo
    (6, 1,  130.00, '2025-06-15 15:00:00', 'pix',            'pago'),
    (6, 1,  130.00, '2025-07-15 16:30:00', 'pix',            'estornado'),
    (6, 1,  130.00, '2025-08-14 17:00:00', 'pix',            'pago'),
    (6, 1,  130.00, '2025-09-15 18:00:00', 'cartao_debito',  'pago'),
    (6, 1,  130.00, '2025-10-15 19:20:00', 'pix',            'pago'),
    (6, 1,  130.00, '2025-11-15 14:50:00', 'cartao_credito', 'pago'),
    (6, 1,  130.00, '2025-12-15 10:10:00', 'pix',            'pago'),
    (6, 1,  130.00, '2026-01-15 11:30:00', 'pix',            'pago'),
    (6, 1,  130.00, '2026-02-15 12:00:00', 'pix',            'pago'),
    (6, 1,  130.00, '2026-03-15 13:15:00', 'cartao_debito',  'pago'),
    (6, 1,  130.00, '2026-04-15 14:40:00', 'pix',            'pago'),
    (6, 1,  130.00, '2026-05-13 09:20:00', 'pix',            'pago'),

    -- Ricardo (id 7) — Semestral, 2 pagamentos
    (7, 2,  663.00, '2025-07-15 08:00:00', 'cartao_credito', 'pago'),
    (7, 2,  663.00, '2026-01-16 09:30:00', 'pix',            'pago'),

    -- Patrícia (id 8) — Mensal, 9 pagos + 1 ATRASADO (mai/2026)
    (8, 1,  130.00, '2025-08-15 15:00:00', 'dinheiro',       'pago'),
    (8, 1,  130.00, '2025-09-15 14:30:00', 'pix',            'pago'),
    (8, 1,  130.00, '2025-10-16 16:20:00', 'pix',            'pago'),
    (8, 1,  130.00, '2025-11-15 11:00:00', 'pix',            'pago'),
    (8, 1,  130.00, '2025-12-14 12:45:00', 'cartao_credito', 'pago'),
    (8, 1,  130.00, '2026-01-15 10:30:00', 'pix',            'pago'),
    (8, 1,  130.00, '2026-02-15 13:00:00', 'pix',            'pago'),
    (8, 1,  130.00, '2026-03-15 17:10:00', 'cartao_debito',  'pago'),
    (8, 1,  130.00, '2026-04-15 18:25:00', 'pix',            'pago'),
    (8, 1,  130.00, '2026-05-15 00:00:00', 'boleto',         'atrasado'),

    -- Lucas (id 9) — Mensal, 3 pagamentos (cancelou)
    (9, 1,  130.00, '2025-09-15 19:00:00', 'cartao_debito',  'pago'),
    (9, 1,  130.00, '2025-10-15 20:30:00', 'pix',            'pago'),
    (9, 1,  130.00, '2025-11-15 18:45:00', 'pix',            'pago'),

    -- Amanda (id 10) — Mensal, 4 pagamentos (cancelou)
    (10, 1, 130.00, '2025-10-15 12:00:00', 'pix',            'pago'),
    (10, 1, 130.00, '2025-11-15 13:20:00', 'cartao_debito',  'pago'),
    (10, 1, 130.00, '2025-12-15 14:30:00', 'pix',            'pago'),
    (10, 1, 130.00, '2026-01-15 15:45:00', 'pix',            'pago');

insert into ficha_treino (aluno_id, personal_id, tipo_treino, data_inicio, data_fim, observacoes) values
    (1, 1, 'Musculação', '2025-01-20', '2025-04-30',
        'Treino inicial focado em adaptação. Ênfase em técnica antes de carga.'),
    (1, 1, 'Musculação', '2025-05-01', NULL,
        'Progressão para hipertrofia. Divisão ABC, 4x na semana.'),
    
    -- Mariana (2) — histórico: ficha 1 finalizada + ficha 2 vigente
    (2, 2, 'Crossfit',   '2025-02-20', '2025-05-31',
        'Adaptação aos movimentos básicos do CrossFit. Foco em mobilidade.'),
    (2, 2, 'Crossfit',   '2025-06-01', NULL,
        'WODs de intensidade moderada. Trabalhar resistência muscular.'),
    
    -- Roberto (3) — histórico: ficha 1 finalizada + ficha 2 vigente
    (3, 3, 'Funcional',  '2025-03-20', '2025-06-30',
        'Avaliação física inicial. Aluno com perfil sedentário. Atenção a lombar.'),
    (3, 3, 'Funcional',  '2025-07-01', NULL,
        'Treino funcional com progressão de carga. Sem dores reportadas.'),
    
    -- Fernanda (4) — apenas ficha vigente
    (4, 1, 'Musculação', '2025-04-20', NULL,
        'Foco em membros inferiores. Trabalhar glúteos e posterior de coxa.'),
    
    -- João (5) — apenas ficha vigente
    (5, 2, 'Crossfit',   '2025-05-20', NULL,
        'Atleta intermediário. Treinos de alta intensidade 3x na semana.'),
    
    -- Bruna (6) — ficha vigente SEM PERSONAL (ficha padrão)
    (6, NULL, 'Musculação', '2025-06-20', NULL,
        'Ficha padrão da academia. Aluna treina sem acompanhamento.'),
    
    -- Ricardo (7) — apenas ficha vigente
    (7, 1, 'Musculação', '2025-07-20', NULL,
        'Aluno 52 anos, sem histórico de lesão. Treino moderado, atenção a articulações.'),
    
    -- Patrícia (8) — ficha vigente SEM PERSONAL (ficha padrão)
    (8, NULL, 'Musculação', '2025-08-20', NULL,
        'Ficha padrão. Foco em condicionamento geral.'),
    
    -- Lucas (9) — INATIVO, ficha finalizada quando cancelou
    (9, NULL, 'Musculação', '2025-09-20', '2025-12-15',
        'Ficha padrão. Aluno cancelou matrícula em dezembro.');