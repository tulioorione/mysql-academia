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

