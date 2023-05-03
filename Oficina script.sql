-- criação do banco de dados para o cenário do E-commerce
CREATE DATABASE oficina;
USE oficina;

-- criar tabela cliente
CREATE TABLE clients (
idClient INT AUTO_INCREMENT PRIMARY KEY,
Cname VARCHAR(15),
CPF CHAR(11) NOT NULL,
Address VARCHAR(30),
UNIQUE (CPF)
);

ALTER TABLE clients AUTO_INCREMENT=1;

-- criar tabela Serviço solicitado
CREATE TABLE services (
idService INT AUTO_INCREMENT PRIMARY KEY,
Sname VARCHAR(15) NOT NULL,
category ENUM('Revisão', 'Troca de fluidos', 'Limpeza', 'Concerto', 'Avaliação') DEFAULT 'Revisão',
avaliacao FLOAT DEFAULT 0,
size VARCHAR(10)
);

-- tabela de pagamento
CREATE TABLE payments (
idPayment INT AUTO_INCREMENT PRIMARY KEY,
idClient INT,
typePayment ENUM('Boleto', 'Cartão', 'Dinheiro'),
limitAvailable FLOAT,
CreditDate DATE,
FOREIGN KEY (idClient) REFERENCES clients(idClient) ON UPDATE CASCADE
);

-- criar tabela OS
CREATE TABLE orders (
idOrder INT AUTO_INCREMENT PRIMARY KEY,
idClient INT,
orderStatus ENUM('Cancelado', 'Confirmado', 'Em processamento para a equipe') DEFAULT 'Em processamento',
orderDescription VARCHAR(255),
sendValue FLOAT DEFAULT 10,
paymentCash BOOLEAN DEFAULT FALSE,
FOREIGN KEY (idClient) REFERENCES clients(idClient) ON UPDATE CASCADE
);

-- criar tabela estoque
CREATE TABLE productStorage (
idProduct INT AUTO_INCREMENT PRIMARY KEY,
StorageLocation VARCHAR(255),
quantity INT DEFAULT 0
);

-- criar tabela fornecedor
CREATE TABLE suppliers (
idSupplier INT AUTO_INCREMENT PRIMARY KEY
);

-- criar tabela de pedido de peças
CREATE TABLE productOrder (
idPOProduct INT,
idPOOrder INT,
poQuantity INT DEFAULT 1,
poStatus ENUM('Disponível', 'Sem estoque') DEFAULT 'Disponível',
PRIMARY KEY (idPOProduct, idPOOrder),
FOREIGN KEY (idPOProduct) REFERENCES productStorage(idProduct),
FOREIGN KEY (idPOOrder) REFERENCES orders(idOrder)
);

-- tabela de equipe
CREATE TABLE teams (
idTeam INT AUTO_INCREMENT PRIMARY KEY,
mechanics VARCHAR(45)
);

-- tabela de mecânicos
CREATE TABLE mechanics (
idMechanic INT AUTO_INCREMENT PRIMARY KEY,
Mname VARCHAR(255),
Cint INT,
Mendereco VARCHAR(45),
MEspecialidade VARCHAR(255),
idTeam INT,
FOREIGN KEY (idTeam) REFERENCES teams(idTeam)
);

-- criando tabela product supplier
CREATE TABLE productSupplier (
idPSSupplier INT,
idPSProduct INT,
quantity INT NOT NULL,
PRIMARY KEY (idPSSupplier, idPSProduct),
FOREIGN KEY (idPSSupplier) REFERENCES suppliers(idSupplier),
FOREIGN KEY (idPSProduct) REFERENCES productStorage(idProduct)
);

-- comandos de consulta de tabela
SHOW DATABASES;
SHOW TABLES;
DESCRIBE productSupplier;
SELECT * FROM information_schema.REFERENTIAL_CONSTRAINTS;
SELECT * FROM information_schema.REFERENTIAL_CONSTRAINTS WHERE constraint_schema = 'oficina';
