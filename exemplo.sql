CREATE TABLE ALUNOS
(
	id_aluno int PRIMARY KEY NOT NULL,
	first_name varchar(40) not null,
	last_name varchar(40) not null
);

INSERT INTO ALUNOS(id_aluno, first_name, last_name)
	 VALUES (1, 'Beatriz', 'Giacomelli');
INSERT INTO ALUNOS(id_aluno, first_name, last_name)
	 VALUES (2, 'Jessica', 'Possenti');
INSERT INTO ALUNOS(id_aluno, first_name, last_name)
	 VALUES (3, 'Ana', 'Scheffer');
INSERT INTO ALUNOS(id_aluno, first_name, last_name)
	 VALUES (4, 'Leticia', 'Torres');

CREATE TABLE PROFESSORES
(
	id_professor int PRIMARY KEY NOT NULL,
	first_name varchar(40) not null,
	last_name varchar(40) not null
);

INSERT INTO PROFESSORES(id_professor, first_name, last_name)
	 VALUES (1, 'Ernanny', 'Figueiredo');
INSERT INTO PROFESSORES(id_professor, first_name, last_name)
	 VALUES (2, 'Joseane', 'Maria');
INSERT INTO PROFESSORES(id_professor, first_name, last_name)
	 VALUES (3, 'Paulo', 'Santos');
INSERT INTO PROFESSORES(id_professor, first_name, last_name)
	 VALUES (4, 'Carlos', 'Schroder');

CREATE TABLE MATERIAS
(
	id_materia int PRIMARY KEY NOT NULL,
	nome_materia varchar(150) not null,
	idProfessor int,
	CONSTRAINT fk_professor FOREIGN KEY
	(idProfessor) references PROFESSORES(id_professor)
);

INSERT INTO MATERIAS(id_materia, nome_materia, idProfessor)
	 VALUES (1, 'Estrutura e Classificação de Dados', 3);
INSERT INTO MATERIAS(id_materia, nome_materia, idProfessor)
	 VALUES (2, 'Programação Orientada a Objeto', 4);
INSERT INTO MATERIAS(id_materia, nome_materia, idProfessor)
	 VALUES (3, 'Banco de Dados', 1);
INSERT INTO MATERIAS(id_materia, nome_materia, idProfessor)
	 VALUES (4, 'Gestão de Projetos e Equipes', 2);

CREATE TABLE NOTAS
(
	id int PRIMARY KEY NOT NULL,
	idAluno int,
	nota numeric(4,1) not null,
	idMateria int,
	idProfessor int,
	CONSTRAINT fk_idAluno FOREIGN KEY
	(idAluno) references ALUNOS(id_aluno),
	CONSTRAINT fk_materia FOREIGN KEY
	(idMateria) references MATERIAS(id_materia),
	CONSTRAINT fk_idProfessor FOREIGN KEY
	(idProfessor) references PROFESSORES(id_professor)
);

INSERT INTO NOTAS(id, idAluno, nota, idMateria, idProfessor)
	 VALUES (1, 3, 7.6, 2, 4);
INSERT INTO NOTAS(id, idAluno, nota, idMateria, idProfessor)
	 VALUES (2, 4, 8.4, 3, 1);

CREATE TABLE notas_audits(
	
	id int generated always as identity,
	nota_id int not null,
	nota numeric(4,1) not null,
	changed_on TIMESTAMP(6) not null
);

CREATE OR REPLACE FUNCTION log_nota_changes()
 RETURNS TRIGGER
 LANGUAGE PLPGSQL
AS
$$
BEGIN
	IF NEW.nota<>OLD.nota THEN
		INSERT INTO notas_audits(nota_id, nota, changed_on)
		VALUES (OLD.id, OLD.nota, now());
	END IF;
	RETURN NEW;
END;
$$

CREATE TRIGGER nota_changes
 BEFORE UPDATE
 ON NOTAS
 FOR EACH ROW
 EXECUTE PROCEDURE log_nota_changes();

Select *
	from ALUNOS;

Select *
	from PROFESSORES;

Select *
	from MATERIAS;
	
Select *
	from NOTAS;

UPDATE NOTAS
	SET NOTA = 6.6
	WHERE id = 2;
	
Select *
	from notas_audits;
