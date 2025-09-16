create database db_facilita;
use db_facilita;
SHOW tables;

-- USUARIO
create table tbl_usuario(
  id int primary key auto_increment not null,
  nome varchar(80) not null,
  senha_hash varchar(255) not null,
  email varchar(100) unique not null,
  telefone varchar(20) unique not null,
  tipo_conta enum('CONTRATANTE', 'PRESTADOR') not null,
  criado_em DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- LOCALIZAÇÃO
create table tbl_localizacao(
  id int primary key auto_increment not null,
  logradouro varchar(100) not null,
  numero varchar(10),
  bairro varchar(50) not null,
  cidade varchar(50) not null,
  cep varchar(15),
  latitude decimal(10, 8) not null,
  longitude decimal(11, 8) not null
);

-- CONTRATANTE
create table tbl_contratante(
  id int primary key auto_increment not null,
  necessidade ENUM('IDOSO', 'DEF_VISUAL', 'DEF_AUDITIVA', 'DEF_MOTORA', 'DEF_INTELECTUAL'),
  id_usuario int not null,
  id_localizacao int not null,
  foreign key (id_usuario) references tbl_usuario(id),
  foreign key (id_locaolizacao) references tbl_localizacao(id)
);

-- PRESTADOR
create table tbl_prestador(
  id int primary key auto_increment not null,
  id_usuario int not null,
  foreign key (id_usuario) references tbl_usuario(id)
);

-- RELACIONAMENTO NXN PRESTADOR E LOCALIZACAO
create table tbl_prestador_localizacao(
  id int primary key auto_increment not null,
  id_prestador int not null,
  id_localizacao int not null,
  foreign key (id_prestador) references tbl_prestador(id),
  foreign key (id_localizacao) references tbl_localizacao(id)
);

-- DOCUMENTOS
create table tbl_documento(
  id int primary key auto_increment not null,
  tipo_documento ENUM('RG', 'CPF', 'CNH_EAR', 'TIPO_VEICULO', 'MODELO_VEICULO', 'ANO_VEICULO') not null,
  valor varchar(100) not null,
  data_validade date,
  arquivo_url varchar(255),
  id_prestador int not null,
  foreign key (id_prestador) references tbl_prestador(id)
);