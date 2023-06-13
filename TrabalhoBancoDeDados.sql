CREATE TABLE alunos
(
	id_aluno int PRIMARY KEY NOT NULL,
    first_name varchar(40) not null,
    last_name varchar(40) not null
);

INSERT INTO alunos(id_aluno, first_name, last_name)
     VALUES (1, 'Beatriz', 'Giacomelli');
INSERT INTO alunos(id_aluno, first_name, last_name)
     VALUES (2, 'Jessica', 'Possenti');
INSERT INTO alunos(id_aluno, first_name, last_name)
     VALUES (3, 'Ana', 'Scheffer');
INSERT INTO alunos(id_aluno, first_name, last_name)
     VALUES (4, 'Leticia', 'Torres');
	 

CREATE TABLE professores
(
    id_professor int PRIMARY KEY NOT NULL,
    first_name varchar(40) not null,
    last_name varchar(40) not null
);

INSERT INTO professores(id_professor, first_name, last_name)
     VALUES (1, 'Ernanny', 'Figueiredo');
INSERT INTO professores(id_professor, first_name, last_name)
     VALUES (2, 'Joseane', 'Maria');
INSERT INTO professores(id_professor, first_name, last_name)
     VALUES (3, 'Paulo', 'Santos');
INSERT INTO professores(id_professor, first_name, last_name)
     VALUES (4, 'Carlos', 'Schroder');


CREATE TABLE materias
(
    id_materia int PRIMARY KEY NOT NULL,
    nome_materia varchar(150) not null,
    idProfessor int,
	
    CONSTRAINT fk_professor FOREIGN KEY (idProfessor) 
	references professores(id_professor)
);

INSERT INTO materias(id_materia, nome_materia, idProfessor)
     VALUES (1, 'Estrutura e Classificação de Dados', 3);
INSERT INTO materias(id_materia, nome_materia, idProfessor)
     VALUES (2, 'Programação Orientada a Objeto', 4);
INSERT INTO materias(id_materia, nome_materia, idProfessor)
     VALUES (3, 'Banco de Dados', 1);
INSERT INTO materias(id_materia, nome_materia, idProfessor)
     VALUES (4, 'Gestão de Projetos e Equipes', 2);


CREATE TABLE periodos (
	id_periodo int PRIMARY KEY NOT NULL,
	periodo varchar(20) not null,
	idMateria int,
	CONSTRAINT fk_materias FOREIGN KEY (idMateria) 
	REFERENCES materias (id_materia)
);

INSERT INTO periodos(id_periodo, periodo, idMateria)
     VALUES (1, '3º Semestre', 3);
INSERT INTO periodos(id_periodo, periodo, idMateria)
     VALUES (2, '3º Semestre', 2);


CREATE TABLE notas
(
    id_nota int PRIMARY KEY NOT NULL,
    idAluno int,
    nota float not null,
    idMateria int,
	idPeriodo int,
    CONSTRAINT fk_alunos FOREIGN KEY (idAluno) 
	references alunos(id_aluno),
    CONSTRAINT fk_materias FOREIGN KEY (idMateria) 
	references materias(id_materia),
	CONSTRAINT fk_periodos FOREIGN KEY (idPeriodo) 
	references periodos(id_periodo)
); 

INSERT INTO notas(id_nota, idAluno, nota, idMateria, idPeriodo)
     VALUES (1, 3, 7.6, 2, 1);
INSERT INTO notas(id_nota, idAluno, nota, idMateria, idPeriodo)
     VALUES (2, 4, 8.4, 3, 2);
INSERT INTO notas(id_nota, idAluno, nota, idMateria, idPeriodo)
     VALUES (3, 2, 4.3, 4, 1);
INSERT INTO notas(id_nota, idAluno, nota, idMateria, idPeriodo)
     VALUES (4, 1, 3.9, 1, 1);
	 

CREATE TABLE recuperacao (
    recuperacao_id INT GENERATED ALWAYS AS IDENTITY,
    idAluno int,
    idMateria int,
	idPeriodo int,
    CONSTRAINT fk_alunos FOREIGN KEY (idAluno) 
	REFERENCES alunos (id_aluno),
    CONSTRAINT fk_materias FOREIGN KEY (idMateria) 
	REFERENCES materias (id_materia),
	CONSTRAINT fk_periodos FOREIGN KEY (idPeriodo)
	REFERENCES periodos (id_periodo)
);


CREATE OR REPLACE FUNCTION checkNota()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.nota < 6 THEN
        INSERT INTO recuperacao (idAluno, idMateria, idperiodo)
		VALUES (NEW.idAluno, NEW.idMateria, NEW.idperiodo);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_nota_recuperacao
AFTER INSERT ON notas
FOR EACH ROW
EXECUTE FUNCTION checkNota();

SELECT * FROM recuperacao;