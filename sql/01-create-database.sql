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