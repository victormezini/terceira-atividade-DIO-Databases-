-- criação do banco de dados para o cenário do E-commerce 
create database oficina;
use oficina;

-- criar tabela cliente

create table clients(
		idClient int auto_increment primary key,
        Cname varchar(15),
        CPF char(11) not null,
        Address varchar(30),
        constraint unique_cpf_cliente unique (CPF)
);

alter table clients auto_increment=1;

-- criar tabela Serviço solicitado

create table service(
		Ssolicitado int auto_increment primary key,
        Sname varchar(15) not null,
        category enum('Revisão', 'Troca de fluidos', 'Limpeza', 'Concerto', 'Avaliação') default 'Revisão',
        avaliação float default 0,
        size varchar(10)
);

-- tabela de pagamento 

create table payments(
	idclient int,
    idpayment int,
    typePayment enum('Boleto', 'Cartão', 'Dinheiro'),
    limitAvalible float,
    CreditDate date,
    primary key(idClient, id_payment)
);

-- criar tabela OS

create table OS(
	idOS int auto_increment primary key,
    idOSClient int,
    OSStatus enum('Cancelado', 'Confirmado', 'Em processamento para a equeipe') default 'Em processamento',
    oderdescription varchar(255),
    sendValue float default 10,
    paymentCash bool default false,
    constraint fk_oders_client foreign key (idOrderClient) references Clients (idClient)
			on update cascade
);


-- criar tabela estoque 

create table productStorage(
	idProductStorage int auto_increment primary key,
	StorageLocation varchar(255),
    quantity int default 0
);

-- criar tabela estoque 

create table supplier(
	idSupplier int auto_increment primary key
);


-- criar tabela de pedido de peças

create table pecasOrder(
	idPOpecas int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponível', 'Sem estoque') default 'Disponível',
    primary key (idPOproduct, idPOorder),
    constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
    constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
);

-- tabela de equipe

create table equipe (
	idEquipe int,
    Omecanicos varchar(45)
    constraint fk_equipe_mecanico foreign key (idMechanics) references mechanics(MEspecialidade)
);

-- tabela de mecânicos

create table mechanics (
	idMechanics int,
    Mnome varchar(255),
    Cint int,
    Mendereço varchar(45),
    MEspecialidade varchar(255)
    constraint fk_mecanico_equipe foreign key (idEquipe) references Oequipe(idOequipe)
);


-- criando tabela product supplier

create table productSupplier(
	idPsSupplier int, 
    idPsProduct int,
    quantity int not null,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);


-- comandos de consulta de tabela

show databases;
show tables;
desc productSupplier;
select *  from referential_constraints;
select *  from referential_constraints where constraint_schema = oficina;