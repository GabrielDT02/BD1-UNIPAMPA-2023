/*CREATE DATABASE IF NOT EXISTS DadosLicitacoes 
CREATE DATABASE "DadosLicitacoes"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Portuguese_Brazil.1252'
    LC_CTYPE = 'Portuguese_Brazil.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

*/

CREATE TABLE Unidade_Gestora (
  Cod_UG INT PRIMARY KEY,
  Nome_UG VARCHAR(50) NOT NULL
);

CREATE TABLE Orgao_Superior (
  Cod_Orgao_Superior INT PRIMARY KEY,
  Nome_Orgao_Superior VARCHAR(50) NOT NULL
);

CREATE TABLE Orgao (
  Cod_Orgao INT PRIMARY KEY,
  Nome_Orgao VARCHAR(50) NOT NULL,
  Cod_Orgao_Superior INT,
  FOREIGN KEY (Cod_Orgao_Superior) REFERENCES Orgao_Superior (Cod_Orgao_Superior)
);

CREATE TABLE Licitacao (
  Num_Licitacao INT,
  Num_Processo VARCHAR(200),
  Data_Resultado DATE NOT NULL,
  Data_Abertura DATE NOT NULL,
  Valor_Licitacao DECIMAL(10,2) NOT NULL,
  Cod_UG INT NOT NULL,
  Cod_Orgao INT NOT NULL,
  PRIMARY KEY (Num_Licitacao, Num_Processo),
  FOREIGN KEY (Cod_UG) REFERENCES Unidade_Gestora (Cod_UG),
  FOREIGN KEY (Cod_Orgao) REFERENCES Orgao (Cod_Orgao)
);

ALTER TABLE Licitacao
ADD Municipio VARCHAR(255),
ADD UF CHAR(2),
ADD Situacao VARCHAR(30);

CREATE TABLE Empenhos_Relacionados (
  Cod_Empenho INT PRIMARY KEY,
  Data_Emissao_Empenho DATE NOT NULL,
  Obs_Empenho VARCHAR(100),
  Valor_Empenho DECIMAL(10, 2) NOT NULL,
  Num_Licitacao INT,
  Num_Processo VARCHAR(200),
  FOREIGN KEY (Num_Licitacao, Num_Processo) REFERENCES Licitacao (Num_Licitacao, Num_Processo)
);

CREATE TABLE Participantes (
  Cod_Participante INT PRIMARY KEY,
  Nome_Participante VARCHAR(100) NOT NULL
);

CREATE TABLE Participantes_Licitacao (
  Cod_Participante INT,
  Num_Licitacao INT,
  Num_Processo VARCHAR(200),
  Flag_Vencedor BOOLEAN,
  PRIMARY KEY (Cod_Participante, Num_Licitacao, Num_Processo),
  FOREIGN KEY (Cod_Participante) REFERENCES Participantes (Cod_Participante),
  FOREIGN KEY (Num_Licitacao, Num_Processo) REFERENCES Licitacao (Num_Licitacao, Num_Processo)
);

CREATE TABLE Modalidade_Compra (
  Cod_Modalidade_Compra INT PRIMARY KEY,
  Modalidade_Compra VARCHAR(100) NOT NULL
);

CREATE TABLE Item (
  Cod_Item_Compra INT PRIMARY KEY,
  Objeto VARCHAR(100) NOT NULL,
  Descricao_Item VARCHAR(100) NOT NULL,
  Valor_Item DECIMAL(10,2) NOT NULL,
  Qtd_Item INT NOT NULL
);

CREATE TABLE Item_Licitacao (
  Cod_Item_Compra INT,
  Num_Processo VARCHAR(200),
  Num_Licitacao INT,
  Cod_Modalidade_Compra INT,
  PRIMARY KEY (Cod_Item_Compra, Num_Processo, Num_Licitacao),
  FOREIGN KEY (Cod_Item_Compra) REFERENCES Item(Cod_Item_Compra),
  FOREIGN KEY (Num_Processo, Num_Licitacao) REFERENCES Licitacao(Num_Processo, Num_Licitacao),
  FOREIGN KEY (Cod_Modalidade_Compra) REFERENCES Modalidade_Compra(Cod_Modalidade_Compra)
);





