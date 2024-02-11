/* Selects de Unidade_Gestora

//Selecionar tudo
SELECT * FROM Unidade_Gestora;

//Selecionar e contar todos registros
SELECT COUNT(*) FROM Unidade_Gestora;

//Selecionar todos registros que tenham pelo menos "Inst" no nome
SELECT * FROM Unidade_Gestora
WHERE Nome_Unidade_Gestora LIKE '%Inst%';

//Selecionar todos registro que tenham pelo menos "RJ" no nome
SELECT * FROM Unidade_Gestora
WHERE nome_ug LIKE '%RJ%';

// Selects Item e Item Licitação

SELECT * FROM Item;
SELECT * FROM Item_Licitacao;

// Selects Modalidade_Compra

SELECT * FROM Modalidade_Compra

// Selects Participantes_Licitacao

SELECT * FROM Participantes_Licitacao 

// Selects Participantes

SELECT * FROM Participantes

// Selects Empenhos_Relacionados

SELECT * FROM Empenhos_Relacionados

// Selects Licitacao

SELECT * FROM Licitacao

// Selects Orgao

SELECT * Orgao

// Consulta 1 - 
Selecionar informações sobre uma licitação, incluindo o nome da unidade gestora, do órgão superior e do órgão responsável

JOIN para selecionar as tabelas Licitacao, Unidade Gestora, Orgao e Orgao Superior 
com base nas FK 

ON para determinar quais linhas de uma tabela deve ser combinada com de outra tabela

CREATE VIEW vw_Licitacoes_Completo AS
SELECT Licitacao.Num_Licitacao, Licitacao.Num_Processo, Licitacao.Data_Resultado, 
       Unidade_Gestora.Nome_UG, Orgao_Superior.Nome_Orgao_Superior, Orgao.Nome_Orgao
FROM Licitacao
JOIN Unidade_Gestora ON Licitacao.Cod_UG = Unidade_Gestora.Cod_UG
JOIN Orgao ON Licitacao.Cod_Orgao = Orgao.Cod_Orgao
JOIN Orgao_Superior ON Orgao.Cod_Orgao_Superior = Orgao_Superior.Cod_Orgao_Superior;


SELECT * FROM vw_Licitacoes_Completo

// Consulta 2 - 
Select todas as licitações realizadas entre 01 de Janeiro e 31 de Dezembro de 2022, 
cujo o valor da licitação é superior a 500.000, e informações sobre a licitação 

Usamos Where para filtrar as linhas da tabela e Group by para agrupar as linhas

CREATE VIEW view_licitacoes_maior_500k AS
SELECT Licitacao.Num_Licitacao, Licitacao.Num_Processo, Licitacao.Data_Resultado, Unidade_Gestora.Nome_UG, Orgao_Superior.Nome_Orgao_Superior, Orgao.Nome_Orgao, Licitacao.valor_licitacao
FROM Licitacao
JOIN Unidade_Gestora ON Licitacao.Cod_UG = Unidade_Gestora.Cod_UG
JOIN Orgao ON Licitacao.Cod_Orgao = Orgao.Cod_Orgao
JOIN Orgao_Superior ON Orgao.Cod_Orgao_Superior = Orgao_Superior.Cod_Orgao_Superior
JOIN Item_Licitacao ON Licitacao.Num_Licitacao = Item_Licitacao.Num_Licitacao
WHERE Licitacao.Data_Resultado BETWEEN '2022-01-01' AND '2022-12-31' AND Licitacao.valor_licitacao > 500000
GROUP BY Licitacao.Num_Licitacao, Licitacao.Num_Processo, Licitacao.Data_Resultado, Unidade_Gestora.Nome_UG, Orgao_Superior.Nome_Orgao_Superior, Orgao.Nome_Orgao, Licitacao.valor_licitacao;

SELECT * FROM view_licitacoes_maior_500k;


//Consulta 3

SELECT todos participantes cujo flag_vencedor é true e agrupa pelo codigo do participante
Usamos o Having pra verificar se o número de flags_Vencedor é maior ou = a 1

CREATE VIEW Vencedores_Licitacao AS
SELECT 
  p.Nome_Participante AS Nome_Vencedor, 
  l.Num_Licitacao, 
  l.Num_Processo
FROM 
  Participantes_Licitacao pl
  JOIN Participantes p ON p.Cod_Participante = pl.Cod_Participante
  JOIN Licitacao l ON l.Num_Licitacao = pl.Num_Licitacao AND l.Num_Processo = pl.Num_Processo
WHERE 
  pl.Flag_Vencedor = TRUE;


SELECT * FROM Vencedores_Licitacao