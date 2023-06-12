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
    CONSTRAINT fk_professor FOREIGN KEY
    (idProfessor) references professores(id_professor)
);

INSERT INTO materias(id_materia, nome_materia, idProfessor)
     VALUES (1, 'Estrutura e Classificação de Dados', 3);
INSERT INTO materias(id_materia, nome_materia, idProfessor)
     VALUES (2, 'Programação Orientada a Objeto', 4);
INSERT INTO materias(id_materia, nome_materia, idProfessor)
     VALUES (3, 'Banco de Dados', 1);
INSERT INTO materias(id_materia, nome_materia, idProfessor)
     VALUES (6, 'Gestão de Projetos e Equipes', 2);

CREATE TABLE notas
(
    id int PRIMARY KEY NOT NULL,
    idAluno int,
    nota numeric(4,1) not null,
    idMateria int,
    idProfessor int,
	recuperacao_id int,
    CONSTRAINT fk_idAluno FOREIGN KEY
    (idAluno) references alunos(id_aluno),
    CONSTRAINT fk_materia FOREIGN KEY
    (idMateria) references materias(id_materia),
    CONSTRAINT fk_idProfessor FOREIGN KEY
    (idProfessor) references professores(id_professor)
);

drop table notas

INSERT INTO notas(id, idAluno, nota, idMateria, idProfessor)
     VALUES (1, 3, 7.6, 2, 4);
INSERT INTO notas(id, idAluno, nota, idMateria, idProfessor)
     VALUES (2, 4, 8.4, 3, 1);
INSERT INTO notas(id, idAluno, nota, idMateria, idProfessor, recuperacao_id, periodo_id)
     VALUES (3, 2, 4.3, 6, 2, 1);
INSERT INTO notas(id, idAluno, nota, idMateria, idProfessor)
     VALUES (4, 1, 3.9, 1, 3);
CREATE TABLE notas_audits(
    id int generated always as identity,
    nota_id int not null,
    nota numeric(4,1) not null,
    changed_on TIMESTAMP(6) not null
);
delete  from notas
CREATE TABLE disciplinas(
	id_disciplina int PRIMARY KEY NOT NULL,
	nome varchar(40) NOT NULL
);

CREATE TABLE periodos (
	id_periodo int PRIMARY KEY NOT NULL,
	periodo varchar(20)
);

CREATE TABLE recuperacao (
    recuperacao_id int PRIMARY KEY,
    idAlunoid INT,
    idMateria INT,
    periodo_id INT,
    FOREIGN KEY (idAluno) REFERENCES alunos (id_aluno),
    FOREIGN KEY (idMateria) REFERENCES disciplinas (id_disciplina),
    FOREIGN KEY (periodo_id) REFERENCES periodos (id_periodo)
);
drop table recuperacao

CREATE OR REPLACE FUNCTION checkNota()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.nota < 6 THEN
        INSERT INTO recuperacao (recuperacao_id, idAluno, idMateria, periodo_id)
        VALUES (NEW.recuperacao_id, NEW.idAluno, NEW.idMateria, NEW.periodo_id);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_nota_recuperacao
AFTER INSERT ON notas
FOR EACH ROW
EXECUTE FUNCTION checkNota();


select * from notas
select * from recuperacao