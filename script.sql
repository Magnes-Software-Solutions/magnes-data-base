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
macAddress VARCHAR(12) PRIMARY KEY,
numeroSerie VARCHAR(45) NOT NULL UNIQUE,
tipoModelo VARCHAR(45) NOT NULL,
statusAtividade VARCHAR(10),
fkEnderecoHospital INT NOT NULL,
FOREIGN KEY (fkEnderecoHospital) 
    REFERENCES enderecoHospital(idEnderecoHospital),
fkRedeHospital INT NOT NULL,
FOREIGN KEY (fkRedeHospital) 
    REFERENCES redeHospital(idRedeHospital)
);

CREATE TABLE componente_maquina(
PRIMARY KEY (fkComponente, fkMaquina),
fkComponente INT NOT NULL,
FOREIGN KEY (fkComponente) 
    REFERENCES componente(idComponente),
fkMaquina VARCHAR(12) NOT NULL,
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

INSERT INTO redeHospital (razaoSocial, cnpj)
VALUES 
('Hospital Libanes', '12345678000199'),
('Hospital Santa Casa', '98765432000155');

INSERT INTO enderecoHospital (bairro, cidade, numeroEstabelecimento, cep)
VALUES
('Centro', 'São Paulo', '100', '01000-000'),
('Vila Mariana', 'São Paulo', '250', '04000-000');

INSERT INTO componente (nomeComponente, tipoComponente, unidadeMedida, capacidadeMaxima)
VALUES
('CPU', 'Processador', '%', 100),
('RAM', 'Memoria', 'GB', 64),
('Disco', 'Armazenamento', 'GB', 1000);

INSERT INTO maquina 
(macAddress, numeroSerie, tipoModelo, statusAtividade, fkEnderecoHospital, fkRedeHospital)
VALUES
('A1B2C3D4E5F6', 'SN123456', 'Dell Optiplex', 'Ativo', 1, 1),
('F6E5D4C3B2A1', 'SN654321', 'HP EliteDesk', 'Ativo', 2, 2),
('ABCDEF123456', 'SN999999', 'Lenovo ThinkCentre', 'Ativo', 1, 1);

INSERT INTO usuario (nome, email, senha, cpf, telefone, fkRedeHospital, fkSupervisor)
VALUES
('João Silva', 'joao@email.com', '12345678', '12345678901', '11999999999', 1, NULL),
('Maria Souza', 'maria@email.com', '12345678', '98765432100', '11888888888', 2, NULL);