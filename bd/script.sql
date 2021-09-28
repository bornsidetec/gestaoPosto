/*
CREATE DATABASE Posto;
USE Posto;

create via terminal:
$ Sqlite3 Posto.db .dump> script.sql
*/

CREATE TABLE Impostos (
	Id	INTEGER NOT NULL,
	Descricao	varchar(50) NOT NULL,
	Aliquota	REAL NOT NULL,
	PRIMARY KEY(Id)
);

CREATE TABLE Combustiveis (
	Id	INTEGER NOT NULL,
	Descricao	varchar(50) NOT NULL,
	Valor	REAL,
	Imposto	INTEGER,
	PRIMARY KEY(Id),
	FOREIGN KEY(Imposto) REFERENCES Impostos(Id)
);

CREATE TABLE Tanques (
	Id	INTEGER NOT NULL,
	Descricao	varchar(50),
	Combustivel	INTEGER,
	FOREIGN KEY(Combustivel) REFERENCES Combustiveis(Id),
	PRIMARY KEY(Id)
);

CREATE TABLE Bombas (
	Id	INTEGER NOT NULL,
	Descricao	varchar(50),
	Tanque	INTEGER,
	PRIMARY KEY(Id),
	FOREIGN KEY(Tanque) REFERENCES Tanques(Id)
);

CREATE TABLE Abastecimentos (
	Id	INTEGER NOT NULL,
	Bomba	INTEGER NOT NULL,
	Data	DateTime NOT NULL,
	Quantidade	REAL NOT NULL,
	Valor	REAL,
	ValorTotal	REAL,
	Aliquota	REAL,
	ValorImposto	REAL,
	TotalPagar	REAL,
	FOREIGN KEY(Bomba) REFERENCES Bombas(Id),
	PRIMARY KEY(Id)
);


