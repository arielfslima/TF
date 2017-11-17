/*
INTEGRANTES
Ariel Fernandes 1700760
Thiago Rold�o 1520133
Gabriel Chaves 1700727
Vitor Freitas 1700741
Maria Cecilia 1700785
*/

CREATE DATABASE ImpactaDB
GO
USE ImpactaDB
GO
CREATE TABLE Curso(
		SIGLA VARCHAR(5) not null,
		NOME VARCHAR(50) not null,
        CONSTRAINT pkCurso PRIMARY KEY (SIGLA),
        CONSTRAINT uqCurso UNIQUE (NOME)
		);

CREATE TABLE Aluno(
		RA INT not null PRIMARY KEY,
		NOME VARCHAR(120) not null,
		EMAIL VARCHAR(80) not null,
		CELULAR CHAR(11) not null,
		SIGLA_CURSO CHAR(2) not null,
		);

CREATE TABLE Disciplina(
		NOME VARCHAR(240) not null,
		CARGA_HORARIA TINYINT not null,
		TEORIA DECIMAL(3) not null,
		PRATICA DECIMAL(3) not null,
		EMENTA TEXT not null,
		COMPETENCIAS TEXT not null,
		HABILIDADES TEXT not null,
		CONTEUDO TEXT not null,
		BIBLIOGRAFIA_BASICA TEXT not null,
		BIBLIOGRAFIA_COMPLEMENTAR TEXT not null,
        CONSTRAINT pkDisciplina PRIMARY KEY (NOME)
		);

CREATE TABLE Professor(
		RA INT not null,
		APELIDO VARCHAR(30) not null UNIQUE,
		NOME VARCHAR(120) not null,
		EMAIL VARCHAR(80) not null,
		CELULAR CHAR(11) not null,
        CONSTRAINT pkProfessor PRIMARY KEY (RA),
        CONSTRAINT uqProfessor UNIQUE (APELIDO)
		);

CREATE TABLE GradeCurricular(
		SIGLA_CURSO VARCHAR(5) not null,
		ANO SMALLINT not null,
		SEMESTRE CHAR(1) not null,
        CONSTRAINT pkGradeCurricular PRIMARY KEY (ANO, SEMESTRE),
        FOREIGN KEY(SIGLA_CURSO) REFERENCES Curso(SIGLA)
		);

CREATE TABLE Periodo(
		SIGLA_CURSO VARCHAR(5) not null,
		ANO_GRADE SMALLINT not null,
		SEMESTRE_GRADE CHAR(1) not null,
		NUMERO TINYINT not null,
        CONSTRAINT pkPeriodo PRIMARY KEY (NUMERO),
        FOREIGN KEY(SIGLA_CURSO) REFERENCES Curso(SIGLA),
        FOREIGN KEY(ANO_GRADE, SEMESTRE_GRADE) REFERENCES GradeCurricular(ANO, SEMESTRE),
		);

CREATE TABLE PeriodoDisciplina(
		SIGLA_CURSO VARCHAR(5) not null,
		ANO_GRADE SMALLINT not null,
		SEMESTRE_GRADE CHAR(1) not null,
		NUMERO_PERIODO TINYINT not null,
		NOME_DISCIPLINA VARCHAR(240) not null,
        FOREIGN KEY(SIGLA_CURSO) REFERENCES Curso(SIGLA),
        FOREIGN KEY(ANO_GRADE, SEMESTRE_GRADE) REFERENCES GradeCurricular(ANO, SEMESTRE),
        FOREIGN KEY(NUMERO_PERIODO) REFERENCES Periodo(NUMERO),
        FOREIGN KEY(NOME_DISCIPLINA) REFERENCES Disciplina(NOME)
		);

CREATE TABLE DisciplinaOfertada(
		NOME_DISCIPLINA VARCHAR(240) not null,
		ANO SMALLINT not null,
		SEMESTRE CHAR(1) not null,
		CONSTRAINT pkDisciplinaOfertada PRIMARY KEY (ANO, SEMESTRE),
        FOREIGN KEY(NOME_DISCIPLINA) REFERENCES Disciplina(NOME)
		);
        
CREATE TABLE Turma(
		NOME_DISCIPLINA VARCHAR(240) not null,
		ANO_OFERTADO SMALLINT not null,
		SEMESTRE_OFERTADO CHAR(1) not null,
		ID CHAR(1) not null PRIMARY KEY,
		TURNO VARCHAR(15) not null,
		RA_PROFESSOR INT not null,
        FOREIGN KEY(NOME_DISCIPLINA) REFERENCES Disciplina(NOME),
        FOREIGN KEY(ANO_OFERTADO, SEMESTRE_OFERTADO) REFERENCES DisciplinaOfertada(ANO, SEMESTRE),
        FOREIGN KEY(RA_PROFESSOR) REFERENCES Professor(RA)
		);

CREATE TABLE CursoTurma(
		SIGLA_CURSO VARCHAR(5) not null,
		NOME_DISCIPLINA VARCHAR(240) not null,
		ANO_OFERTADO SMALLINT not null,
		SEMESTRE_OFERTADO CHAR(1) not null,
		ID_TURMA CHAR(1) not null,
        FOREIGN KEY(SIGLA_CURSO) REFERENCES Curso(SIGLA),
        FOREIGN KEY(NOME_DISCIPLINA) REFERENCES Disciplina(NOME),
        FOREIGN KEY(ANO_OFERTADO, SEMESTRE_OFERTADO) REFERENCES DisciplinaOfertada(ANO, SEMESTRE),
        FOREIGN KEY(ID_TURMA) REFERENCES Turma(ID)
		);

CREATE TABLE Questao(
		NOME_DISCIPLINA VARCHAR(240) not null,
		ANO_OFERTADO SMALLINT not null,
		SEMESTRE_OFERTADO CHAR(1) not null,
		ID_TURMA CHAR(1) not null,
		NUMERO INT not null PRIMARY KEY,
		DATA_LIMITE_ENTREGA DATE not null,
		DESCRICAO TEXT not null,
		DATA DATE not null,
        FOREIGN KEY(NOME_DISCIPLINA) REFERENCES Disciplina(NOME),
        FOREIGN KEY(ANO_OFERTADO, SEMESTRE_OFERTADO) REFERENCES DisciplinaOfertada(ANO, SEMESTRE),
        FOREIGN KEY(ID_TURMA) REFERENCES Turma(ID)
		);

CREATE TABLE ArquivosQuestao(
		NOME_DISCIPLINA VARCHAR(240) not null,
		ANO_OFERTADO SMALLINT not null,
		SEMESTRE_OFERTADO CHAR(1) not null,
		ID_TURMA CHAR(1) not null,
		NUMERO_QUESTAO INT not null,
		ARQUIVO VARCHAR(500) not null PRIMARY KEY,
        FOREIGN KEY(NOME_DISCIPLINA) REFERENCES Disciplina(NOME),
        FOREIGN KEY(ANO_OFERTADO, SEMESTRE_OFERTADO) REFERENCES DisciplinaOfertada(ANO, SEMESTRE),
        FOREIGN KEY(ID_TURMA) REFERENCES Turma(ID),
        FOREIGN KEY(NUMERO_QUESTAO) REFERENCES Questao(NUMERO)
		);

		CREATE TABLE Matricula(
		RA_ALUNO INT not null,
		NOME_DISCIPLINA VARCHAR(240) not null,
		ANO_OFERTADO SMALLINT not null,
		SEMESTRE_OFERTADO CHAR(1) not null ,
		ID_TURMA CHAR(1) not null,
        FOREIGN KEY(RA_ALUNO) REFERENCES Aluno(RA),
        FOREIGN KEY(NOME_DISCIPLINA) REFERENCES Disciplina(NOME),
        FOREIGN KEY(ANO_OFERTADO, SEMESTRE_OFERTADO) REFERENCES DisciplinaOfertada(ANO, SEMESTRE),
        FOREIGN KEY(ID_TURMA) REFERENCES Turma(ID)
		);

CREATE TABLE Resposta(
		NOME_DISCIPLINA VARCHAR(240) not null,
		ANO_OFERTADO SMALLINT not null,
		SEMESTRE_OFERTADO CHAR(1) not null,
		ID_TURMA CHAR(1) not null,
		NUMERO_QUESTAO INT not null,
		RA_ALUNO INT not null PRIMARY KEY,
		DATA_AVALIACAO DATE not null,
		NOTA DECIMAL(4,2) not null,
		AVALIACAO TEXT not null,
		DESCRICAO TEXT not null,
		DATA_DE_ENVIO DATE not null,
        FOREIGN KEY(NOME_DISCIPLINA) REFERENCES Disciplina(NOME),
        FOREIGN KEY(ANO_OFERTADO, SEMESTRE_OFERTADO) REFERENCES DisciplinaOfertada(ANO, SEMESTRE),
        FOREIGN KEY(ID_TURMA) REFERENCES Turma(ID),
        FOREIGN KEY(NUMERO_QUESTAO) REFERENCES Questao(NUMERO)
		);

CREATE TABLE ArquivosResposta(
		NOME_DISCIPLINA VARCHAR(240) not null,
		ANO_OFERTADO SMALLINT not null,
		SEMESTRE_OFERTADO CHAR(1) not null,
		ID_TURMA CHAR(1) not null,
		NUMERO_QUESTAO INT not null,
		RA_ALUNO INT not null,
		ARQUIVO VARCHAR(500) not null PRIMARY KEY,
        FOREIGN KEY(NOME_DISCIPLINA) REFERENCES Disciplina(NOME),
        FOREIGN KEY(ANO_OFERTADO, SEMESTRE_OFERTADO) REFERENCES DisciplinaOfertada(ANO, SEMESTRE),
        FOREIGN KEY(ID_TURMA) REFERENCES Turma(ID),
        FOREIGN KEY(NUMERO_QUESTAO) REFERENCES Questao(NUMERO),
        FOREIGN KEY(RA_ALUNO) REFERENCES Resposta(RA_ALUNO)
		);