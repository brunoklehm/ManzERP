create database manzerp;
use manzerp;

create table usuario(
id int not null primary key auto_increment,
nome varchar(50) not null,
cpf char(11) not null,
tipo int not null,
login varchar(20) not null,
senha varchar(20) not null,
status int not null
);

create table chamado(
id int not null primary key auto_increment,
tipo int not null,
data_solicitacao varchar(10) not null,
descricao varchar(100) not null,
nome varchar(50) not null,
status int not null,
usuario_solicitante int not null,
usuario_atendente int,
foreign key (usuario_solicitante) references usuario(id) on update cascade,
foreign key (usuario_atendente) references usuario(id) on update cascade,
);
