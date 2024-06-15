set search_path to public;

------------------------------------------- GALAXIA -------------------------------------------
create table Galaxia(
	nome varchar(100) not null,
	tipo varchar(9),
	constraint PK_GALAXIA primary key(nome),
	constraint CK_TIPO check(upper(tipo) in ('ELIPTICA', 'ESPIRAL', 'IRREGULAR'))
);

--------------------------------------- SISTEMA_ESTELAR ---------------------------------------
create table Sistema_Estelar(
	galaxia varchar(100) not null,
	nome varchar(100) not null,
	tipo varchar(20),
	constraint PK_SISTEMA primary key(galaxia, nome),
	constraint FK_SISTEMA_GALAXIA foreign key(galaxia) references Galaxia(nome)
		on update cascade on delete cascade
);

------------------------------------------- PLANETA -------------------------------------------
create table Planeta(
	id_planeta int not null,
	galaxia varchar(100) not null,
	sistema varchar(100) not null,
	nome varchar(100) not null,
	tipo varchar(7),
	habitabilidade varchar(20),
	status_planeta varchar(20),
	constraint PK_PLANETA primary key(id_planeta),
	constraint UK_PLANETA_SISTEMA unique(galaxia, sistema, nome),
	constraint FK_PLANETA_SISTEMA foreign key(galaxia, sistema) references Sistema_Estelar(galaxia, nome)
		on update cascade on delete cascade,
	constraint CK_TIPO check(upper(tipo) in ('ROCHOSO', 'GASOSO'))
);

create sequence SEQ_PLANETA
    start with 1
    increment by 1;
   
------------------------------------------- RECURSO -------------------------------------------
create table Recurso(
    planeta int not null,
    codigo varchar(9) not null,
    nome varchar(150),
    abundancia varchar(20),
    origem varchar(11) not null,
    constraint PK_RECURSO primary key(planeta, codigo),
    constraint FK_RECURSO_PLANETA foreign key(planeta) references Planeta(id_planeta) 
    	on update cascade on delete cascade,
    constraint CK_ORIGEM check(upper(origem) in ('NATURAL', 'TECNOLOGICO'))
);

------------------------------------------ STARGATE -------------------------------------------
create table Stargate(
	endereco char(8) not null,
	status_stargate varchar(20),
	planeta int,
	constraint PK_STARGATE primary key(endereco),
	constraint UK_STARGATE_PLANETA unique(planeta),
	constraint FK_STARGATE_PLANETA foreign key(planeta) references Planeta(id_planeta)
		on update cascade on delete cascade,
	constraint CK_ENDERECO check (endereco ~ '^[0-9]+$')
);

------------------------------------------- CONEXAO -------------------------------------------
create table Conexao(
	data_hora_ativacao timestamp not null,
	data_hora_desativacao timestamp,
	stargate_origem char(8) not null,
	stargate_destino char(8) not null,
	constraint PK_CONEXAO primary key(data_hora_ativacao, stargate_origem),
	constraint UK_CONEXAO_STARGATE_DESTINO unique(data_hora_ativacao, stargate_destino),
	constraint FK_CONEXAO_STARGATE_ORIGEM foreign key(stargate_origem) references Stargate(endereco)
		on update cascade on delete cascade,
	constraint FK_CONEXAO_STARGATE_DESTINO foreign key(stargate_destino) references Stargate(endereco)
		on update cascade on delete cascade,
	constraint CK_ORIGEM_DESTINO check (stargate_origem <> stargate_destino),
	constraint CK_ATIVACAO_DESATIVACAO check (data_hora_desativacao > data_hora_ativacao)
);

------------------------------------------- REMESSA -------------------------------------------
create table Remessa(
	data_hora_envio timestamp not null,
	planeta int not null,
	recurso varchar(9) not null,
	data_hora_conexao timestamp not null,
	origem_conexao char(8) not null,
	quantidade int,
	valor_unitario numeric(8,2),
	valor_total numeric(8,2),
	constraint PK_REMESSA primary key(data_hora_envio, planeta, recurso, data_hora_conexao, origem_conexao),
	constraint FK_REMESSA_RECURSO foreign key(planeta, recurso) references Recurso(planeta, codigo)
		on update cascade on delete cascade,
	constraint FK_REMESSA_CONEXAO foreign key(data_hora_conexao, origem_conexao)
		references Conexao(data_hora_ativacao, stargate_origem)
		on update cascade on delete cascade,
	constraint CK_DATA_HORA_ENVIO check(data_hora_envio > data_hora_conexao),
	constraint CK_QUANTIDADE check(quantidade > 0),
	constraint CK_VALOR_UNITARIO check(valor_unitario > 0),
	constraint CK_VALOR_TOTAL check(valor_total > 0)
);

----------------------------------------- CIVILIZACAO -----------------------------------------
create table Civilizacao(
	nome varchar(100) not null,
	lingua varchar(20),
	nivel_tecnologico varchar(20),
	nivel_agressividade varchar(20),
	status_civilizacao varchar(20),
	constraint PK_CIVILIZACAO primary key(nome)
);

------------------------------------------- ESPECIE -------------------------------------------
create table Especie(
	nome varchar(100) not null,
	civilizacao varchar(100) not null,
	forma_locomocao varchar(20),
	simetria varchar(12),
	alimentacao varchar(9),
	constraint PK_ESPECIE primary key(nome),
	constraint UK_ESPECIE_CIVILIZACAO unique(civilizacao),
	constraint FK_ESPECIE_CIVILIZACAO foreign key(civilizacao) references Civilizacao(nome)
		on update cascade on delete cascade,
	constraint CK_SIMETRIA check(upper(simetria) in ('BILATERAL', 'RADIAL', 'SEM SIMETRIA')),
	constraint CK_ALIMENTACAO check(upper(alimentacao) in ('HERBIVORO', 'CARNIVORO', 'ONIVORO', 'OUTRO'))
);


---------------------------------- CIVILIZACAO_VIVE_PLANETA -----------------------------------
create table Civilizacao_vive_Planeta(
	civilizacao varchar(100) not null,
	planeta int not null,
	localizacao varchar(50),
	populacao varchar(20),
	constraint PK_CIVILIZACAO_VIVE_PLANETA primary key(civilizacao, planeta),
	constraint FK_CIVILIZACAO foreign key(civilizacao) references Civilizacao(nome)
		on update cascade on delete cascade,
	constraint FK_PLANETA foreign key(planeta) references Planeta(id_planeta)
		on update cascade on delete cascade
);

------------------------------------------- NATURAL -------------------------------------------
-- Essa tabela não foi nomeada somente de 'Natural', pois esta é uma palavra reservada
create table Recurso_Natural(
	planeta int not null,
	recurso varchar(9) not null,
	tipo varchar(20),
	constraint PK_NATURAL primary key(planeta, recurso),
	constraint FK_NATURAL_RECURSO foreign key(planeta, recurso) references Recurso(planeta, codigo)
		on update cascade on delete cascade
);

------------------------------------------- MINERAL -------------------------------------------
create table Mineral(
	planeta int not null,
	recurso varchar(9) not null,
	composicao varchar(255),
	pureza varchar(50),
	cor varchar(50),
	dureza varchar(50),
	constraint PK_MINERAL primary key(planeta, recurso),
	constraint FK_MINERAL_NATURAL foreign key(planeta, recurso) 
		references Recurso_Natural(planeta, recurso)
		on update cascade on delete cascade 
);

------------------------------------------- ANIMAL --------------------------------------------
create table Animal(
	planeta int not null,
	recurso varchar(9) not null,
	especie varchar(100),
	bioma varchar(100),
	dieta varchar(100),
	nivel_ameaca varchar(20),
	constraint PK_ANIMAL primary key(planeta, recurso),
	constraint FK_ANIMAL_NATURAL foreign key(planeta, recurso) 
		references Recurso_Natural(planeta, recurso)
		on update cascade on delete cascade 
);

------------------------------------------- VEGETAL -------------------------------------------
create table Vegetal(
	planeta int not null,
	recurso varchar(9) not null,
	toxicidade varchar(20),
	bioma varchar(100),
	utilizacao varchar(255),
	propriedades_medicinais varchar(255),
	constraint PK_VEGETAL primary key(planeta, recurso),
	constraint FK_VEGETAL_NATURAL foreign key(planeta, recurso) 
		references Recurso_Natural(planeta, recurso)
		on update cascade on delete cascade 
);

----------------------------------------- TECNOLOGICO -----------------------------------------
-- Essa tabela foi nomeada como 'Recurso_Tecnologico' para manter o padrão da tabela 'Recurso_Natural'
create table Recurso_Tecnologico(
	planeta int not null,
	recurso varchar(9) not null,
	constraint PK_TECNOLOGICO primary key(planeta, recurso),
	constraint FK_TECNOLOGICO_RECURSO foreign key(planeta, recurso) references Recurso(planeta, codigo)
		on update cascade on delete cascade
);

-------------------------------------- TIPO_TECNOLOGICO ---------------------------------------
create table Tipo_Tecnologico(
	planeta int not null,
	recurso varchar(9) not null,
	tipo varchar(20) not null,
	constraint PK_TIPO_TECNOLOGICO primary key(planeta, recurso, tipo),
	constraint FK_RECURSO_TECNOLOGICO foreign key(planeta, recurso) 
		references Recurso_Tecnologico(planeta, recurso)
		on update cascade on delete cascade
);

------------------------------------------- MILITAR -------------------------------------------
create table Militar(
	planeta int not null,
	recurso varchar(9) not null,
	capacidade_dano varchar(20),
	fonte_energia varchar(50),
	alcance varchar(50),
	modo_operacao varchar(22),
	constraint PK_MILITAR primary key(planeta, recurso),
	constraint FK_MILITAR_TECNOLOGICO foreign key(planeta, recurso)
		references Recurso_Tecnologico(planeta, recurso)
		on update cascade on delete cascade,
	constraint CK_MODO_OPERACAO check(upper(modo_operacao) in ('AUTOMATICO', 'MANUAL', 'CONTROLADO REMOTAMENTE'))
);

------------------------------------------- MEDICA --------------------------------------------
create table Medica(
	planeta int not null,
	recurso varchar(9) not null,
	finalidade varchar(255),
	funcionamento varchar(255),
	compatibilidade_fisiologica varchar(255),
	efeitos_colaterais varchar(255),
	constraint PK_MEDICA primary key(planeta, recurso),
	constraint FK_MEDICA_TECNOLOGICO foreign key(planeta, recurso)
		references Recurso_Tecnologico(planeta, recurso)
		on update cascade on delete cascade
);

---------------------------------------- COMPUTACIONAL ----------------------------------------
create table Computacional(
	planeta int not null,
	recurso varchar(9) not null,
	capacidade_processamento varchar(20),
	consumo_energetico varchar(20),
	sistema_operacional varchar(100),
	aplicacoes_principais varchar(255),
	constraint PK_COMPUTACIONAL primary key(planeta, recurso),
	constraint FK_COMPUTACIONAL_TECNOLOGICO foreign key(planeta, recurso)
		references Recurso_Tecnologico(planeta, recurso)
		on update cascade on delete cascade
);

------------------------------------- TECNOLOGICO_NATURAL -------------------------------------
create table Tecnologico_Natural(
	planeta_tec int not null,
	recurso_tec varchar(9) not null,
	planeta_nat int not null,
	recurso_nat varchar(9) not null,
	constraint PK_TECNOLOGICO_NATURAL primary key(planeta_tec, recurso_tec, planeta_nat, recurso_nat),
	constraint FK_RECURSO_TECNOLOGICO foreign key(planeta_tec, recurso_tec)
		references Recurso_Tecnologico(planeta, recurso)
		on update cascade on delete cascade,
	constraint FK_RECURSO_NATURAL foreign key(planeta_nat, recurso_nat)
		references Recurso_Natural(planeta, recurso)
		on update cascade on delete cascade
);

---------------------------------------- PROCESSAMENTO ----------------------------------------
create table Processamento(
	civilizacao varchar(100) not null,
	planeta int not null,
	recurso_tecnologico varchar(9) not null,
	constraint PK_PROCESSAMENTO primary key(civilizacao, planeta, recurso_tecnologico),
	constraint FK_PROCESSAMENTO_CIVILIZACAO foreign key(civilizacao) references Civilizacao(nome)
		on update cascade on delete cascade,
	constraint FK_PROCESSAMENTO_TECNOLOGICO foreign key(planeta, recurso_tecnologico)
		references Recurso_Tecnologico(planeta, recurso)
		on update cascade on delete cascade
);
