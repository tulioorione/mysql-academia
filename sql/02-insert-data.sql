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
    