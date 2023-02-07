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