set search_path to public;

-- Consulta 1: Listar Civilizações com Todos os Tipos de Recursos Naturais
-- Esta consulta irá empregar a operação de divisão relacional para encontrar civilizações que possuem 
-- acesso a todos os tipos de recursos naturais disponíveis.
select C.nome
from Civilizacao C
where not exists(
    select R.codigo
    from Recurso R
    where R.origem = 'NATURAL'
    and not exists(
        select CVP.planeta
        from Civilizacao_vive_Planeta CVP
        where CVP.civilizacao = C.nome
        and exists(
            select RN.planeta
            from Recurso_Natural RN
            where RN.planeta = CVP.planeta and RN.recurso = R.codigo
        )
    )
);


-- Consulta 2: Relatório de Espécies e Recursos em Sistemas Estelares Específicos
-- Esta consulta utiliza inner joins e subqueries para listar espécies e os recursos disponíveis
-- nos seus planetas, restringindo a sistemas estelares de um tipo específico.
select E.nome as Especie, P.nome as Planeta, SE.nome as Sistema_Estelar, R.nome as Recurso
from Especie E
inner join Civilizacao_vive_Planeta CP on E.civilizacao = CP.civilizacao
inner join Planeta P on CP.planeta = P.id_planeta
inner join Sistema_Estelar SE on P.sistema = SE.nome
inner join Recurso R on P.id_planeta = R.planeta
where SE.tipo = 'SOLITARIO'; -- Substituir 'SOLITARIO' pelo tipo de sistema estelar desejado


-- Consulta 3: Valor Total de Remessas por Civilização
-- Esta consulta agrega dados para calcular o valor total de remessas enviadas por cada civilização, 
-- utilizando inner joins e funções de agregação.
select C.nome, SUM(R.valor_total) as Valor_Total
from Civilizacao C
inner join Civilizacao_vive_Planeta CP on C.nome = CP.civilizacao
inner join Remessa R on CP.planeta = R.planeta
group by C.nome;


-- Consulta 4: Estatísticas de Habitabilidade de Planetas por Tipo de Galáxia
-- Aqui, usamos inner joins e funções de agregação para analisar a habitabilidade dos planetas 
-- em diferentes tipos de galáxias.
select G.tipo, count(*) as total_planetas, AVG(CASE WHEN P.habitabilidade = 'HABITAVEL' THEN 1 ELSE 0 END) as percentual_habitaveis
from Galaxia G
inner join Sistema_Estelar SE on G.nome = SE.galaxia
inner join Planeta P on SE.nome = P.sistema
group by G.tipo;


-- Consulta 5: Civilizações com Acesso a Recursos Tecnológicos Avançados
-- Esta consulta mostra quais civilizações têm acesso a recursos tecnológicos de um certo tipo,
-- utilizando subqueries e inner joins.
select C.nome
from Civilizacao C
where exists(
    select *
    from Processamento P
    inner join Recurso_Tecnologico RT on P.planeta = RT.planeta and P.recurso_tecnologico = RT.recurso
    inner join Tipo_Tecnologico TT on RT.planeta = TT.planeta and RT.recurso = TT.recurso
    where P.civilizacao = C.nome and TT.tipo = 'MEDICA' -- Substituir 'MEDICA' pelo tipo desejado
);


-- Consulta 6: Tipos dos Recursos Naturais e Tecnológicos
-- Esta consulta utiliza left joins para mostrar qual o tipo de de cada recurso, tecnológico ou natural,
-- ordenados por ordem crescente de origem.
select Rec.planeta, Rec.codigo, Rec.nome, Rec.origem, nat.tipo, ttec.tipo
from Recurso Rec
left join Recurso_Natural Nat 
	on Rec.planeta = Nat.planeta and Rec.codigo = Nat.recurso
left join Recurso_Tecnologico Tec
	on Rec.planeta = Tec.planeta and Rec.codigo = Tec.recurso
left join Tipo_Tecnologico Ttec 
	on Tec.planeta = Ttec.planeta and Tec.recurso = Ttec.recurso
order by Rec.origem asc;
