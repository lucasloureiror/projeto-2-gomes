set search_path to public;

------------------------------------------- GALAXIA -------------------------------------------
insert into galaxia(nome, tipo)
values('Via Láctea', 'ESPIRAL');

insert into galaxia(nome, tipo)
values('Pegasus', 'IRREGULAR');

--------------------------------------- SISTEMA_ESTELAR ---------------------------------------
insert into sistema_estelar(galaxia, nome, tipo)
values('Via Láctea', 'Sistema Solar', 'SOLITARIO');

insert into sistema_estelar(galaxia, nome, tipo)
values('Pegasus', 'Sistema Lantean', 'TRIPLO');

------------------------------------------- PLANETA -------------------------------------------
insert into planeta(id_planeta, galaxia, sistema, nome, tipo, habitabilidade, status_planeta)
values(nextval('seq_planeta'), 'Via Láctea', 'Sistema Solar', 'Terra', 'ROCHOSO', 'HABITAVEL', 'intacto');

insert into planeta(id_planeta, galaxia, sistema, nome, tipo, habitabilidade, status_planeta)
values(nextval('seq_planeta'), 'Via Láctea', 'Sistema Solar', 'Marte', 'ROCHOSO', 'INABITAVEL', 'intacto');

insert into planeta(id_planeta, galaxia, sistema, nome, tipo, habitabilidade, status_planeta)
values(nextval('seq_planeta'), 'Pegasus', 'Sistema Lantean', 'Lantea', 'ROCHOSO', 'HABITAVEL', 'abandonado');

------------------------------------------- RECURSO -------------------------------------------
insert into recurso(planeta, codigo, nome, abundancia, origem)
values(1, '1784', 'Arma de Fogo', 'ABUNDANTE', 'TECNOLOGICO');

insert into recurso(planeta, codigo, nome, abundancia, origem)
values(1, '3456', 'Bomba Nuclear', 'ESCASSO', 'TECNOLOGICO');

insert into recurso(planeta, codigo, nome, abundancia, origem)
values(1, '9876', 'Scanner Médico Avançado', 'MODERADO', 'TECNOLOGICO');

insert into recurso(planeta, codigo, nome, abundancia, origem)
values(1, '5432', 'Implante Biônico', 'ESCASSO', 'TECNOLOGICO');

insert into recurso(planeta, codigo, nome, abundancia, origem)
values(1, '2690', 'Dispositivo de Comunicação', 'ESCASSO', 'TECNOLOGICO');

insert into recurso(planeta, codigo, nome, abundancia, origem)
values(1, '1232', 'Circuito Integrado', 'ESCASSO', 'TECNOLOGICO');

insert into recurso(planeta, codigo, nome, abundancia, origem)
values(1, '301', 'Carvão Vegetal', 'ABUNDANTE', 'NATURAL');

insert into recurso(planeta, codigo, nome, abundancia, origem)
values(1, '789', 'Madeira', 'ABUNDANTE', 'NATURAL');

insert into recurso(planeta, codigo, nome, abundancia, origem)
values(1, '562', 'Diamante', 'ESCASSO', 'NATURAL');

insert into recurso(planeta, codigo, nome, abundancia, origem)
values(1, '651', 'Dióxido de Silício', 'MODERADO', 'NATURAL');

insert into recurso(planeta, codigo, nome, abundancia, origem)
values(1, '987', 'Água Potável', 'ABUNDANTE', 'NATURAL');

insert into recurso(planeta, codigo, nome, abundancia, origem)
values(1, '765', 'Pele de Criatura Exótica', 'MODERADO', 'NATURAL');

insert into recurso(planeta, codigo, nome, abundancia, origem)
values(1, '321', 'Veneno de Serpente Rara', 'ESCASSO', 'NATURAL');

------------------------------------------ STARGATE -------------------------------------------
insert into stargate(endereco, status_stargate, planeta)
values('32157860', 'ativo', 1);

insert into stargate(endereco, status_stargate, planeta)
values('57892141', 'ativo', 3);

insert into stargate(endereco, status_stargate, planeta)
values('45341350', 'ativo', 2);

insert into stargate(endereco, status_stargate)
values('15378528', 'danificado');

------------------------------------------- CONEXAO -------------------------------------------
insert into conexao(data_hora_ativacao, data_hora_desativacao, stargate_origem, stargate_destino)
values(
	TO_TIMESTAMP('10/12/2023 15:01', 'DD/MM/YYYY HH24:MI'),
	TO_TIMESTAMP('10/12/2023 15:30', 'DD/MM/YYYY HH24:MI'),
	'32157860', '57892141'
);

insert into conexao(data_hora_ativacao, data_hora_desativacao, stargate_origem, stargate_destino)
values(
	TO_TIMESTAMP('10/12/2023 17:23', 'DD/MM/YYYY HH24:MI'),
	TO_TIMESTAMP('10/12/2023 18:05', 'DD/MM/YYYY HH24:MI'),
	'32157860', '57892141'
);

insert into conexao(data_hora_ativacao, stargate_origem, stargate_destino)
values(
	TO_TIMESTAMP('10/12/2023 18:30', 'DD/MM/YYYY HH24:MI'),
	'57892141', '15378528'
);

------------------------------------------- REMESSA -------------------------------------------
insert into remessa(data_hora_envio, planeta, recurso, data_hora_conexao, origem_conexao, 
					quantidade, valor_unitario, valor_total)
values(
	TO_TIMESTAMP('10/12/2023 15:08', 'DD/MM/YYYY HH24:MI'),
	1, '2690',
	TO_TIMESTAMP('10/12/2023 15:01', 'DD/MM/YYYY HH24:MI'), '32157860',
	5, 1522.90, 7614.50
);

insert into remessa(data_hora_envio, planeta, recurso, data_hora_conexao, origem_conexao, 
					quantidade, valor_unitario, valor_total)
values(
	TO_TIMESTAMP('10/12/2023 17:35', 'DD/MM/YYYY HH24:MI'),
	1, '301',
	TO_TIMESTAMP('10/12/2023 17:23', 'DD/MM/YYYY HH24:MI'), '32157860',
	500, 5, 2500
);

insert into remessa(data_hora_envio, planeta, recurso, data_hora_conexao, origem_conexao, 
					quantidade, valor_unitario, valor_total)
values(
	TO_TIMESTAMP('10/12/2023 17:35', 'DD/MM/YYYY HH24:MI'),
	1, '562',
	TO_TIMESTAMP('10/12/2023 17:23', 'DD/MM/YYYY HH24:MI'), '32157860',
	3, 60000, 180000
);

----------------------------------------- CIVILIZACAO -----------------------------------------
insert into civilizacao(nome, lingua, nivel_tecnologico, nivel_agressividade, status_civilizacao)
values('Humanos', 'inglês', 'MEDIANO', 'MEDIANO', 'existente');

insert into civilizacao(nome, lingua, nivel_tecnologico, nivel_agressividade, status_civilizacao)
values('Lantianos', 'ancient', 'AVANÇADO', 'BAIXO', 'destruída');

------------------------------------------- ESPECIE -------------------------------------------
insert into especie(nome, civilizacao, forma_locomocao, simetria, alimentacao)
values('Humana', 'Humanos', 'BIPEDE TERRESTRE', 'BILATERAL', 'ONIVORO');

insert into especie(nome, civilizacao, forma_locomocao, simetria, alimentacao)
values('Ancients', 'Lantianos', 'BIPEDE TERRESTRE', 'BILATERAL', 'ONIVORO');

---------------------------------- CIVILIZACAO_VIVE_PLANETA -----------------------------------
insert into civilizacao_vive_planeta(civilizacao, planeta, localizacao, populacao)
values('Humanos', 1, 'Estados Unidos', '331.9 milhões');

insert into civilizacao_vive_planeta(civilizacao, planeta, localizacao, populacao)
values('Humanos', 3, 'Atlantis', '423');

------------------------------------------- NATURAL -------------------------------------------
insert into recurso_natural(planeta, recurso, tipo)
values(1, '562', 'MINERAL');

insert into recurso_natural(planeta, recurso, tipo)
values(1, '651', 'MINERAL');

insert into recurso_natural(planeta, recurso, tipo)
values(1, '987', 'MINERAL');

insert into recurso_natural(planeta, recurso, tipo)
values(1, '765', 'ANIMAL');

insert into recurso_natural(planeta, recurso, tipo)
values(1, '321', 'ANIMAL');

insert into recurso_natural(planeta, recurso, tipo)
values(1, '301', 'VEGETAL');

insert into recurso_natural(planeta, recurso, tipo)
values(1, '789', 'VEGETAL');

------------------------------------------- MINERAL -------------------------------------------
insert into mineral(planeta, recurso, composicao, pureza, cor, dureza)
values(1, '562', 'Carbono puro cristalizado', 'ALTA', 'Incolor', '10 Mohs');

insert into mineral(planeta, recurso, composicao, pureza, cor, dureza)
values(1, '651', 'Silício e oxigênio', 'MODERADA', 'Branca ou incolor', '7 Mohs');

insert into mineral(planeta, recurso, composicao, pureza, cor, dureza)
values(1, '987', 'Hidrogênio, oxigênio e minerais variados', 'ALTA', 'Incolor', 'N/A'); -- Água não tem dureza em Mohs

------------------------------------------- ANIMAL --------------------------------------------
insert into animal(planeta, recurso, especie, bioma, dieta, nivel_ameaca)
values(1, '765', 'Criatura Exótica', 'Floresta Tropical', 'Herbívora', 'BAIXO');

insert into Animal(planeta, recurso, especie, bioma, dieta, nivel_ameaca)
values(1, '321', 'Serpente Rara', 'Deserto', 'Carnívora', 'MEDIO');

------------------------------------------- VEGETAL -------------------------------------------
insert into vegetal(planeta, recurso, toxicidade, bioma, utilizacao, propriedades_medicinais)
values(1, '301', 'BAIXA', 'Floresta Tropical', 'Combustível', 'Usado na produção de medicamentos para problemas digestivos.');

insert into vegetal(planeta, recurso, toxicidade, bioma, utilizacao, propriedades_medicinais)
values(1, '789', 'BAIXA', 'Floresta Temperada', 'Construção e fabricação de móveis', 'Algumas espécies têm propriedades antimicrobianas.');

----------------------------------------- TECNOLOGICO -----------------------------------------
insert into recurso_tecnologico(planeta, recurso)
values(1, '1784');

insert into recurso_tecnologico(planeta, recurso)
values(1, '3456');

insert into recurso_tecnologico(planeta, recurso)
values(1, '9876');

insert into recurso_tecnologico(planeta, recurso)
values(1, '5432');

insert into recurso_tecnologico(planeta, recurso)
values(1, '2690');

insert into recurso_tecnologico(planeta, recurso)
values(1, '1232');

-------------------------------------- TIPO_TECNOLOGICO ---------------------------------------
insert into tipo_tecnologico(planeta, recurso, tipo)
values(1, '1784', 'MILITAR');

insert into tipo_tecnologico(planeta, recurso, tipo)
values(1, '3456', 'MILITAR');

insert into tipo_tecnologico(planeta, recurso, tipo)
values(1, '9876', 'MEDICA');

insert into tipo_tecnologico(planeta, recurso, tipo)
values(1, '5432', 'MEDICA');

insert into tipo_tecnologico(planeta, recurso, tipo)
values(1, '2690', 'COMPUTACIONAL');

insert into tipo_tecnologico(planeta, recurso, tipo)
values(1, '1232', 'COMPUTACIONAL');

------------------------------------------- MILITAR -------------------------------------------
insert into militar(planeta, recurso, capacidade_dano, fonte_energia, alcance, modo_operacao)
values(1, '1784', 'MEDIA', 'Pólvora', 'Média e longa distância', 'AUTOMATICO');

insert into militar(planeta, recurso, capacidade_dano, fonte_energia, alcance, modo_operacao)
values(1, '3456', 'EXTREMA', 'Reação nuclear', 'Global', 'CONTROLADO REMOTAMENTE');

------------------------------------------- MEDICA --------------------------------------------
insert into medica(planeta, recurso, finalidade, funcionamento, compatibilidade_fisiologica, efeitos_colaterais)
values(
	1, '9876', 
	'Diagnóstico Avançado', 
	'Utiliza tecnologia de imagem para diagnósticos precisos.', 
	'Compatível com a fisiologia humana.',
	'Baixo risco de efeitos colaterais.'
);

insert into medica(planeta, recurso, finalidade, funcionamento, compatibilidade_fisiologica, efeitos_colaterais)
values(
	1, '5432', 
	'Melhoria de Capacidades Fisiológicas', 
	'Integração de componentes biônicos para aprimorar habilidades físicas.', 
	'Adaptado para ser compatível com o corpo humano.', 
	'Efeitos colaterais mínimos, sujeito a adaptação individual.'
);

---------------------------------------- COMPUTACIONAL ----------------------------------------
insert into Computacional(planeta, recurso, capacidade_processamento, consumo_energetico, sistema_operacional, aplicacoes_principais)
values(1, '2690', 'ALTA', 'MODERADO', 'Sistema proprietário', 'Comunicação de longa distância, processamento de dados em tempo real.');

insert into Computacional(planeta, recurso, capacidade_processamento, consumo_energetico, sistema_operacional, aplicacoes_principais)
values(1, '1232', 'MUITO ALTA', 'BAIXO', 'Sistema embarcado', 'Integração em dispositivos eletrônicos, automação de processos industriais.');

------------------------------------- TECNOLOGICO_NATURAL -------------------------------------
insert into tecnologico_natural(planeta_tec, recurso_tec, planeta_nat, recurso_nat)
values(1, '1232', 1, '651');

insert into tecnologico_natural(planeta_tec, recurso_tec, planeta_nat, recurso_nat)
values(1, '9876', 1, '651');

---------------------------------------- PROCESSAMENTO ----------------------------------------
insert into processamento(civilizacao, planeta, recurso_tecnologico)
values('Humanos', 1, '1784');

insert into processamento(civilizacao, planeta, recurso_tecnologico)
values('Humanos', 1, '3456');

insert into processamento(civilizacao, planeta, recurso_tecnologico)
values('Humanos', 1, '9876');

insert into processamento(civilizacao, planeta, recurso_tecnologico)
values('Humanos', 1, '5432');

insert into processamento(civilizacao, planeta, recurso_tecnologico)
values('Humanos', 1, '2690');

insert into processamento(civilizacao, planeta, recurso_tecnologico)
values('Humanos', 1, '1232');
