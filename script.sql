CREATE DATABASE magnes;
USE magnes;

CREATE TABLE redeHospital(
    idRedeHospital INT PRIMARY KEY AUTO_INCREMENT,
    razaoSocial VARCHAR(100) NOT NULL,
    cnpj CHAR(14) NOT NULL UNIQUE
);

CREATE TABLE enderecoHospital(
    idEnderecoHospital INT PRIMARY KEY AUTO_INCREMENT,
    bairro VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    numeroEstabelecimento CHAR(5) NOT NULL,
    cep VARCHAR(10) NOT NULL
);

CREATE TABLE componente(
    idComponente INT PRIMARY KEY AUTO_INCREMENT,
    nomeComponente VARCHAR(50) NOT NULL,
    tipoComponente VARCHAR(45) NOT NULL,
    unidadeMedida VARCHAR(45) NOT NULL,
    capacidadeMaxima FLOAT NOT NULL
);

CREATE TABLE maquina(
    macAddress VARCHAR(17) PRIMARY KEY,
    numeroSerie VARCHAR(45) NOT NULL UNIQUE,
    tipoModelo VARCHAR(45) NOT NULL,
    statusAtividade VARCHAR(10),
    fkEnderecoHospital INT NOT NULL,
        FOREIGN KEY (fkEnderecoHospital) 
		REFERENCES enderecoHospital(idEnderecoHospital),
    fkRedeHospital INT NOT NULL,
		FOREIGN KEY (fkRedeHospital) 
		REFERENCES redeHospital(idRedeHospital),
    valorMedioExame DECIMAL(10,2),
    examesPorHora INT,
    metaSLA FLOAT,
    custoCorretiva DECIMAL(10,2)
);

CREATE TABLE componente_maquina(
    PRIMARY KEY (fkComponente, fkMaquina),
    fkComponente INT NOT NULL,
        FOREIGN KEY (fkComponente) 
		REFERENCES componente(idComponente),
    fkMaquina VARCHAR(17) NOT NULL,
        FOREIGN KEY (fkMaquina) 
		REFERENCES maquina(macAddress),
    limite FLOAT NOT NULL
);

CREATE TABLE usuario(
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    telefone VARCHAR(20) UNIQUE,
    fkRedeHospital INT,
        FOREIGN KEY (fkRedeHospital) 
		REFERENCES redeHospital(idRedeHospital),
    fkSupervisor INT,
    FOREIGN KEY (fkSupervisor) 
		REFERENCES usuario(idUsuario)
);

INSERT INTO redeHospital (razaoSocial, cnpj) VALUES 
    ('Hospital Libanes', '12345678000199'),
    ('Hospital Santa Casa', '98765432000155');

INSERT INTO enderecoHospital (bairro, cidade, numeroEstabelecimento, cep) VALUES
    ('Centro', 'São Paulo', '100', '01000-000'),
    ('Vila Mariana', 'São Paulo', '250', '04000-000');

INSERT INTO componente (idComponente, nomeComponente, tipoComponente, unidadeMedida, capacidadeMaxima) VALUES
    (1, 'CPU', 'Processador', '%', 100),
    (2, 'RAM', 'Memoria', 'GB', 64),
    (3, 'Disco', 'Armazenamento', 'GB', 1000);

INSERT INTO usuario (nome, email, senha, cpf, telefone, fkRedeHospital, fkSupervisor) VALUES
    ('Cleber Dias', 'cleber@email.com', '12345678', '12345678901', '11999999999', 1, NULL);

INSERT INTO maquina (macAddress, numeroSerie, tipoModelo, statusAtividade, fkEnderecoHospital, fkRedeHospital, valorMedioExame, examesPorHora, metaSLA, custoCorretiva) VALUES
    ('80:e6:50:04:fd:58', 'COMPUTADOR_CLEBER', 'MacBook Pro', 'Ativo', 1, 1, 150.00, 4, 98.5, 2500.00);

INSERT INTO componente_maquina (fkComponente, fkMaquina, limite) VALUES 
    (1, '80:e6:50:04:fd:58', 5.0),
    (2, '80:e6:50:04:fd:58', 70.0),
    (3, '80:e6:50:04:fd:58', 90.0);

SELECT macAddress, numeroSerie, valorMedioExame, examesPorHora, metaSLA, custoCorretiva FROM maquina;
SELECT * FROM componente_maquina;