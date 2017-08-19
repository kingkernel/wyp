create database if not exists wyp character set=utf8;

use wyp;

-- create table if not exists administracao()engine=innodb charset=utf8;

create table if not exists estados(
	sigla varchar(2),
	nomeestado varchar(35),
primary key(sigla))engine=innodb charset=utf8;

-- dados ###############################################################
insert into estados(sigla, nomeestado) values ("AP", "Amapá");
-- dados ###############################################################
create table cidades(
id int auto_increment,
nomecidade varchar(50),
sigla varchar(3),
estado varchar(2),
primary key(id),
foreign key(estado) references estados(sigla))engine=innodb charset=utf8;

insert into cidades (nomecidade, estado, sigla) values ("Santana", "AP", "STN"),
("Macapá", "AP", "MCP");
-- dados ###############################################################
delimiter //
	create procedure sp_sel_cidades(in arg_estado int(4) COLLATE utf8_unicode_ci)
	begin
		select id, nomecidade from cidades where estado=arg_estado;
	end //
delimiter ;
-- dados ###############################################################
create table bairros(
id int auto_increment,
nomebairro varchar(45),
cidade int,
primary key(id),
foreign key(cidade) references cidades(id))engine=innodb charset=utf8;

insert into bairros(nomebairro, cidade) values ("Paraíso", 1), ("Central", 1),
("Nova Brasília", 1), ("Vila Amazonas", 1), ("Daniel", 1),
("Área Portuária", 1), ("Fonte Nova", 1), ("Laranjeiras", 1),
("Fortaleza", 1), ("Elesbão", 1), ("Novo Horizonte", 1), ("Provedor", 1),
("Remédios", 1), ("Jardim de Deus", 1), ("Igarapé do Lago", 1),
("Distrito Industrial", 1), ("Hospitalidade", 1), ("Ilha de Santana", 1),
("Provedor I", 1);

insert into bairros(nomebairro, cidade) values ("Abacate da Pedreira", 2),
("Ambé", 2), ("Ariri", 2), ("Bailique", 2), ("Campina de São Benedito", 2),
("Campina Grande", 2), ("Cantanzal", 2), ("Carmo", 2), ("Carneiro", 2),
("Com. de São Benedito do rio Salvadorzinho", 2), ("Cominidade do Ariri", 2),
("Comunidade do Mel", 2), ("Comunidade do Sabino", 2), ("Conceição do Marauanum", 2),
("Corre Água", 2), ("Cubano", 2), ("Curiaú", 2), ("Curiaú de Dentro", 2),
("Curiaú de fora", 2), ("Curralinho", 2), ("Fazenda Gurijuba", 2),
("Fazendinha", 2), ("Foz do rio Gurijuba", 2), ("Franco Grande", 2), ("Franquinho", 2),
("Freguesia do Bailique", 2), ("Gaivota", 2), ("Garimpo", 2), ("Garimpo São Tomé", 2),
("Garimpo Vila Nova", 2), ("Guruporá", 2), ("Igarapé do Buritizal", 2),
("Igarapé do Meio", 2), ("Igarapé Grande da Terra Grande", 2),
("Igarapé Grando do Curua", 2), ("Ilha Redonda", 2), ("Inajá", 2), ("Itamatatuba", 2),
("Jaburuzinho", 2), ("Jaburuzinho do Bailique", 2), ("Jaranduba", 2),
("Lago do Papagaio", 2), ("Lagoa dos Índios", 2), ("Liberdade", 2),
("Lmão do Curua", 2), ("Livramento do Bailique", 2), ("Livramento do Pacuí", 2),
("Lontra da Pedreira", 2), ("Alvorada", 2), ("Araxá", 2), ("Beirol", 2), ("Boné Azul", 2),
("Brasil Novo", 2), ("Buritizal", 2), ("Cabralzinho", 2), ("Central", 2),
("Cidade Nova", 2), ("Congós", 2), ("Goiabal", 2), ("Infraero", 2), ("Jardim Equatorial", 2),
("Jardim Felicidade", 2), ("Jardim Marco Zero", 2), ("Jesus de Nazaré", 2),
("Julião Ramos", 2), ("Lagoa Azul", 2), ("Loteamento Açaí", 2), ("Marabaixo", 2),
("Muca", 2), ("Muruci", 2), ("Nova Esperança", 2), ("Novo Buritizal", 2),
("Novo Horizonte", 2), ("Pacoval", 2), ("Pantanal", 2), ("Pedrinhas", 2),
("Perpétuo Socorro", 2), ("Renascer", 2), ("Santan Inês", 2), ("Santa Rita", 2),
("São José", 2), ("São Lázaro", 2), ("Trem", 2), ("Universidade", 2), ("Zerão", 2),
("Maruanum", 2);
-- #####################################################################
delimiter //
	create procedure sp_sel_bairros(arg_cidade int(4))
	begin
		select id, nomebairro from bairros where cidade=arg_cidade;
	end //
delimiter ;

create table if not exists usuario(
	email varchar(50),
	nome varchar(35),
	senha varchar(64),
	whatsapp varchar(25),
	fone1 varchar(25),
	fone2 varchar(25),
	sexo enum("M", "F", "Hm", "Hf"),
	cidade varchar(50),
	estado varchar(35),
	bairro varchar(40),
	rua varchar(50),
	numero varchar(15),
	ativo boolean default false,
primary key(email))engine=innodb charset=utf8;

create table if not exists usuario_config(
	email varchar(50),
	foto varchar(300),
primary key(email))engine=innodb charset=utf8;


-- #####################################################################
--				procedure de usuarios
-- #####################################################################
delimiter //
	create procedure sp_add_usuarios(arg_email varchar(50), arg_senha varchar(64), arg_whatsapp varchar(25),
						arg_fone1 varchar(25),	arg_fone2 varchar(25), arg_cidade varchar(50),
						arg_estado varchar(35), arg_rua varchar(50), arg_numero varchar(15), arg_bairro varchar(40))
		begin
			insert into usuario(email, senha, whatsapp, fone1, fone2, cidade, 
						estado, rua, numero, bairro) values (arg_email, md5(arg_senha), 
						arg_whatsapp, arg_fone1, arg_fone2, arg_cidade, arg_estado,
						arg_rua, arg_numero, arg_bairro);
			insert into usuario_config (email) values (arg_email);
		end //
delimiter ;
-- #####################################################################
delimiter //
	create procedure sp_up_firstaccess(in arg_email varchar(50) COLLATE utf8_unicode_ci,
						in arg_nome varchar(35) COLLATE utf8_unicode_ci,
						in arg_senha varchar(64) COLLATE utf8_unicode_ci,
						in arg_whatsapp varchar(25) COLLATE utf8_unicode_ci,
						in arg_fone1 varchar(25) COLLATE utf8_unicode_ci,
						in arg_fone2 varchar(25) COLLATE utf8_unicode_ci,
						in arg_sexo varchar(2) COLLATE utf8_unicode_ci,
						in arg_estado varchar(35) COLLATE utf8_unicode_ci,
						in arg_cidade varchar(50) COLLATE utf8_unicode_ci,
						in arg_bairro varchar(40) COLLATE utf8_unicode_ci,
						in arg_rua varchar(50) COLLATE utf8_unicode_ci,
						in arg_numero varchar(15) COLLATE utf8_unicode_ci)
		begin
			update usuario set nome=arg_nome, senha=md5(arg_senha), whatsapp=arg_whatsapp,
							fone1=arg_fone1, fone2=arg_fone2, sexo=arg_sexo, estado=arg_estado,
							cidade=arg_cidade, bairro=arg_bairro, rua=arg_rua,
							numero=arg_numero, ativo=1
							where email=arg_email COLLATE utf8_unicode_ci;
		end //
delimiter ;

delimiter //
	create procedure sp_sel_hash(in arg_hash varchar(50) COLLATE utf8_unicode_ci)
		begin
			-- select count(senha) as existe, senha from usuario where ativo=0 and email=arg_hash;
			select count(senha) as existe, email from usuario where senha=arg_hash COLLATE utf8_unicode_ci;
		end //
delimiter ;
-- dados ###############################################################
-- call sp_add_usuarios("daniel.santos.ap@gmail.com", sha2("1234", 256), "96991635311", "96991635311", "", "Santana", "AP", "av 7 de setembro", "1937", "Paraíso");
					
					
create table categorias(
nomecategoria varchar(150) primary key)engine=innodb charset=utf8;

-- delimiter //
--	create procedure sp_add_categorias()
--		begin
--			insert into () values ();
--		end //
-- delimiter ;
-- dados ###############################################################
insert into categorias(nomecategoria) values ("Manutenção"), ("Encomenda"),
("Informática"), ("Serviços Manuais"), ("Serviços Domésticos"), ("Diarista"),
("Entregas"), ("Consertos"), ("Pedreiro"), ("Carpinteiro"), ("Pintor"),
("Manutenção de Celulares"), ("Mecânico"), ("Aluguel de Objetos"), 
("Aulas de Reforço"), ("Caronas"), ("Serviços Sexuais"), 
("Manutenção de Computadores"), ("Manutenção de Notebooks"), ("Capina"),
("Taxista"), ("Moto-Taxista");

create table if not exists servicos(
	idservico bigint auto_increment,
	chamada varchar(100),
	descricao varchar(500),
	postador varchar(50),
	fechada boolean,
	categoria varchar(150),
foreign key (postador) references usuario(email),
foreign key(categoria) references categorias(nomecategoria),
primary key(idservico))engine=innodb charset=utf8;

-- #####################################################################
--				procedure de servicos
-- #####################################################################

delimiter //
	create procedure sp_add_servicos(arg_chamada varchar(100), 
						arg_descricao varchar(500), arg_postador varchar(50), 
						arg_fechada boolean, arg_categoria varchar(150))
		begin
			insert into servicos(chamada, descricao, postador, fechada, 
						categoria) values (arg_chamada, arg_descricao, 
						arg_postador, arg_fechada, arg_categoria);
		end //
delimiter ;

create table propostas(
	idproposta bigint auto_increment,
	autor varchar(50),
	servico bigint,
	textoproposta text,
	aceita boolean default false,
primary key(idproposta),
foreign key(autor) references usuario(email),
foreign key(servico) references servicos(idservico))engine=innodb charset=utf8;

-- #####################################################################
--				procedure de propostas
-- #####################################################################
delimiter //
	create procedure sp_add_proposta(arg_autor varchar(50), arg_servico bigint,
						arg_textoproposta text, arg_aceita boolean)
		begin
			insert into propostas (autor, servico, textoproposta, aceita)
					values (arg_autor, arg_servico, arg_textoproposta, arg_aceita);
		end //
delimiter ;

create table confianca(
	votante varchar(50),
	votado varchar(50),
	classificacao enum("positivo", "negativo"),
primary key(votante, votado))engine=innodb charset=utf8;

delimiter //
	create procedure sp_add_confianca(arg_votante varchar(50), 
						arg_votado varchar(50), 
						arg_classificacao enum("positivo", "negativo"))
		begin
			insert into confianca(votante, votado, classificacao) values (arg_votante, arg_votado, arg_classificacao);
		end //
delimiter ;

create table notificacoes(
idnotify bigint auto_increment,
usuario varchar(50),
dequem varchar(50),
mensagem varchar(250),
entregue boolean default false,
dianota datetime default CURRENT_TIMESTAMP,
primary key(idnotify),
foreign key(usuario) references usuario(email),
foreign key(dequem) references usuario(email))engine=innodb charset=utf8;

-- ##############  ##################### ###############################
delimiter //
	create procedure sp_add_notification(arg_usuario varchar(50), arg_mensagem varchar(250))
		begin
			insert into notificacoes (usuario, mensagem) values (arg_usuario, arg_mensagem);
		end //
delimiter ;
-- ##############  ##################### ###############################
delimiter //
	create procedure sel_notify(arg_email varchar(50))
		begin
			select * from notificacoes where usuario=arg_email and entregue=false order by idnotify, dianota desc limit 1;
		end //
delimiter ;
-- ##############  ##################### ###############################
delimiter //
	create procedure up_notify(arg_id bigint)
		begin
			update notificacoes set entregue=true where idnotify=arg_id;
		end //
delimiter ;


call sp_add_notification("daniel.santos.ap@gmail.com", "Meu Titulo||Minha Mensagem||2.png");
call sp_add_notification("daniel.santos.ap@gmail.com", "Meu Titulo2||Minha Mensagem2||4.png");
call sp_add_notification("daniel.santos.ap@gmail.com", "Meu Titulo3||Minha Mensagem3||3.png");
call sp_add_notification("daniel.santos.ap@gmail.com", "Meu Titulo3||Minha Mensagem3||1.png");
call sp_add_notification("daniel.santos.ap@gmail.com", "Meu Titulo3||Minha Mensagem3||3.png");


