DROP DATABASE IF EXISTS academia;
create database academia
	character set utf8mb4
    collate utf8mb4_unicode_ci
    
USE academia;

create table plano (
    id int auto_increment primary key,
    nome varchar(50) not null unique,
    valor decimal(10,2) not null,
    duracao_meses int not null
) engine InnoDB;

create table personal (
    id int auto_increment primary key,
    nome varchar(100) not null,
    cpf varchar(11) not null unique, 
    email varchar(100) not null unique,
    telefone varchar(20) null,
    data_contratacao date not null,
    salario decimal(8, 2) not null,
    especialidade enum('Musculação', 'Crossfit', 'Funcional', 'Pilates', 'Natação') not null,
    ativo boolean not null default true
) engine InnoDB;

create table aluno (
    id int auto_increment primary key,
    nome varchar(100) not null,
    cpf varchar(11) not null unique,
    email varchar(100) not null unique,
    telefone varchar(20) null,
    data_nascimento date not null,
    sexo enum('M', 'F') not null,
    data_matricula datetime not null default current_timestamp,
    ativo boolean not null default true,
    personal_id int null,

    constraint fk_aluno_personal
        foreign key (personal_id) references personal(id)
        on delete set null
        on update cascade
) engine = InnoDB;

create table aluno_plano (
    id int auto_increment primary key, 
    aluno_id int not null, 
    plano_id int not null,
    data_inicio date not null,
    data_fim date null,

    constraint fk_alunoplano_aluno
        foreign key (aluno_id) references aluno(id)
        on delete cascade
        on update cascade,

    constraint fk_alunoplano_plano
        foreign key (plano_id) references plano(id)
        on delete restrict
        on update cascade
) engine = InnoDB;

create table pagamento (
    id int auto_increment primary key,
    aluno_id int not null,
    plano_id int not null,
    valor decimal(10,2) not null check (valor > 0),
    data_pagamento datetime not null,
    forma_pagamento enum('dinheiro', 'cartao_debito', 'cartao_credito', 'pix', 'boleto') not null,
    status enum('pago', 'pendente', 'atrasado', 'estornado') not null default 'pendente',

    constraint fk_pagamento_aluno
        foreign key (aluno_id) references aluno(id)
        on delete restrict
        on update cascade,

    constraint fk_pagamento_plano
        foreign key (plano_id) references plano(id)
        on delete restrict
        on update cascade
) engine = InnoDB;