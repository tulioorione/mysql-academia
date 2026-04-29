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