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
INSERT INTO aluno (nome, cpf, email, telefone, data_nascimento, sexo, data_matricula, ativo, personal_id) VALUES
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

INSERT INTO aluno_plano (aluno_id, plano_id, data_inicio, data_fim) VALUES
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