CREATE TABLE alunos
(
	id_aluno int PRIMARY KEY NOT NULL,
    nome varchar(40) not null,
    sobrenome varchar(40) not null,
	data_nascimento varchar(10) not null,
	cpf varchar(15) not null,
	telefone varchar(15) not null,
	email varchar(50)not null
);
SELECT * FROM alunos
select nome from alunos where id_aluno = 4

INSERT INTO alunos(id_aluno, nome, sobrenome, data_nascimento, cpf, telefone, email)
	 VALUES (1, 'João', 'Silva', '15/05/1990', '123.456.789-00', '(45) 1234-5678', 'joao.silva@edu.unipar.br');

INSERT INTO alunos(id_aluno, nome, sobrenome, data_nascimento, cpf, telefone, email)
 	 VALUES (2, 'Maria', 'Santos', '30/09/1992', '987.654.321-00', '(45) 9876-5432', 'maria.santos@edu.unipar.br');

INSERT INTO alunos(id_aluno, nome, sobrenome, data_nascimento, cpf, telefone, email)
	 VALUES (3, 'Pedro', 'Ferreira', '10/03/1995', '456.789.123-00', '(45) 5555-5555', 'pedro.ferreira@edu.unipar.br');

INSERT INTO alunos(id_aluno, nome, sobrenome, data_nascimento, cpf, telefone, email)
	 VALUES (4, 'Ana', 'Oliveira', '25/07/1988', '789.123.456-00', '(45) 9999-9999', 'ana.oliveira@edu.unipar.br');

INSERT INTO alunos(id_aluno, nome, sobrenome, data_nascimento, cpf, telefone, email)
	 VALUES (5, 'Lucas', 'Rodrigues', '05/12/1989', '321.654.987-00', '(45) 4444-4444', 'lucas.rodrigues@edu.unipar.br');

INSERT INTO alunos(id_aluno, nome, sobrenome, data_nascimento, cpf, telefone, email)
	 VALUES (6, 'Juliana', 'Lima', '20/08/1991', '654.321.987-00', '(45) 7777-7777', 'juliana.lima@edu.unipar.br');

INSERT INTO alunos(id_aluno, nome, sobrenome, data_nascimento, cpf, telefone, email)
	 VALUES (7, 'Rafael', 'Costa', '12/02/1993', '987.123.456-00', '(45) 2222-2222', 'rafael.costa@edu.unipar.br');

INSERT INTO alunos(id_aluno, nome, sobrenome, data_nascimento, cpf, telefone, email)
	 VALUES (8, 'Carolina', 'Pereira', '28/06/1987', '456.789.123-00', '(45) 3333-3333', 'carolina.pereira@edu.unipar.br');

INSERT INTO alunos(id_aluno, nome, sobrenome, data_nascimento, cpf, telefone, email)
	 VALUES (9, 'Marcelo', 'Gomes', '08/11/1990', '789.123.456-00', '(45) 6666-6666', 'marcelo.gomes@edu.unipar.br');

INSERT INTO alunos(id_aluno, nome, sobrenome, data_nascimento, cpf, telefone, email)
	 VALUES (10, 'Fernanda', 'Martins', '18/04/1985', '321.654.987-00', '(45) 8888-8888', 'fernanda.martins@edu.unipar.br');

	 

CREATE TABLE professores
(
    id_professor int PRIMARY KEY NOT NULL,
    nome varchar(40) not null,
    sobrenome varchar(40) not null,
	data_nascimento varchar(15) not null,
	cpf varchar(15) not null,
	telefone varchar(15) not null,
	email varchar(50) not null
);

SELECT * FROM professores

INSERT INTO professores (id_professor, nome, sobrenome, data_nascimento, cpf, telefone, email)
	 VALUES (1, 'Luciana', 'Ferreira', '20/11/1982', '456.789.123-00', '(45) 5555-5555', 'luciana.ferreira@prof.unipar.br');

INSERT INTO professores (id_professor, nome, sobrenome, data_nascimento, cpf, telefone, email)
	 VALUES (2, 'Rafael', 'Oliveira', '05/02/1978', '789.123.456-00', '(45) 9999-9999', 'rafael.oliveira@prof.unipar.br');

INSERT INTO professores (id_professor, nome, sobrenome, data_nascimento, cpf, telefone, email)
	 VALUES (3, 'Mariana', 'Rodrigues', '12/09/1985', '321.654.987-00', '(45) 4444-4444', 'mariana.rodrigues@prof.unipar.br');

INSERT INTO professores (id_professor, nome, sobrenome, data_nascimento, cpf, telefone, email)
	 VALUES (4, 'Pedro', 'Lima', '25/03/1979', '654.321.987-00', '(45) 7777-7777', 'pedro.lima@prof.unipar.br');

CREATE TABLE materias
(
    id_materia int PRIMARY KEY NOT NULL,
    nome_materia varchar(150) not null,
    idProfessor int,
    CONSTRAINT fk_professor FOREIGN KEY (idProfessor) 
	references professores(id_professor)
);

SELECT * FROM materias

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

SELECT * FROM periodos

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
delete from notas
INSERT INTO notas(id_nota, idAluno, nota, idMateria, idPeriodo)
     VALUES (1, 3, 7.6, 2, 1);
INSERT INTO notas(id_nota, idAluno, nota, idMateria, idPeriodo)
     VALUES (2, 4, 8.4, 3, 2);
INSERT INTO notas(id_nota, idAluno, nota, idMateria, idPeriodo)
     VALUES (3, 2, 4.3, 4, 1);
INSERT INTO notas(id_nota, idAluno, nota, idMateria, idPeriodo)
     VALUES (4, 1, 3.9, 1, 1);
INSERT INTO notas(id_nota, idAluno, nota, idMateria, idPeriodo)
     VALUES (5, 6, 8.0, 2, 1);
INSERT INTO notas(id_nota, idAluno, nota, idMateria, idPeriodo)
     VALUES (6, 5, 1.5, 3, 2);
INSERT INTO notas(id_nota, idAluno, nota, idMateria, idPeriodo)
     VALUES (7, 9, 9.4, 4, 1);
INSERT INTO notas(id_nota, idAluno, nota, idMateria, idPeriodo)
     VALUES (8, 8, 6.0, 1, 1);
INSERT INTO notas(id_nota, idAluno, nota, idMateria, idPeriodo)
     VALUES (9, 10, 10.0, 4, 1);
INSERT INTO notas(id_nota, idAluno, nota, idMateria, idPeriodo)
     VALUES (10, 7, 3.3, 1, 1);

select * from notas
	 

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
drop table recuperacao

CREATE OR REPLACE FUNCTION checkNota()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.nota < 6 THEN
        INSERT INTO recuperacao (idAluno, idMateria, idPeriodo)
        VALUES (NEW.idAluno, NEW.idMateria, NEW.idPeriodo);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_nota_recuperacao
AFTER INSERT ON notas
FOR EACH ROW
EXECUTE FUNCTION checkNota();

SELECT * FROM recuperacao;
SELECT * FROM alunos;
SELECT * FROM periodos;


SELECT DISTINCT a.nome, a.sobrenome, n.nota
FROM alunos a
INNER JOIN recuperacao r ON a.id_aluno = r.idAluno
INNER JOIN notas n ON r.idAluno = n.idAluno
                    AND r.idMateria = n.idMateria
                    AND r.idPeriodo = n.idPeriodo;