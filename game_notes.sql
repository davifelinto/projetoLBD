drop database if exists game_notes;

create database if not exists game_notes
default character set utf8
default collate utf8_general_ci;

use game_notes;

CREATE TABLE IF NOT EXISTS jogador (
	id int not null,
	nome varchar(50) not null,
	idade int not null,
	email varchar(50),
	ativo boolean,
	primary key (id)
);

CREATE TABLE IF NOT EXISTS raca (
	id int not null,
	nome varchar(50) not null,
	descricao varchar(300),
	habilidades varchar(100) not null,
	primary key (id)
);

CREATE TABLE IF NOT EXISTS classe (
	id int not null,
	nome varchar(100) not null,
	habilidades varchar(310) not null,
	primary key (id)
);

CREATE TABLE IF NOT EXISTS item (
	id int not null,
	nome varchar(100) not null,
	tipo varchar(15) not null,
	raridade varchar(20) not null,
	preco double,
	primary key (id)
);

CREATE TABLE IF NOT EXISTS npc (
	id int not null,
	nome varchar(100) not null,
	funcao varchar(50),
	localizacao varchar(100),
	primary key (id)
);

CREATE TABLE IF NOT EXISTS quest (
	id int not null,
	descricao varchar(300) not null,
	recompensa varchar(100),
	id_npc int not null,
	primary key (id),
	foreign key (id_npc)
        	references npc (id)
);

CREATE TABLE IF NOT EXISTS personagem (
	id int not null,
	nome varchar(40),
	nivel int not null,
	id_jogador int not null,
	id_raca int not null,
	id_classe int not null,
	data_criacao date,
	primary key (id),
	foreign key (id_jogador)
        	references jogador (id),
	foreign key (id_raca)
		references raca (id),
	foreign key (id_classe)
        	references classe (id)
);

CREATE TABLE IF NOT EXISTS itens_personagem (
	id_personagem int not null,
	id_item int not null,
	quantidade int,
	primary key (id_personagem, id_item),
	foreign key (id_personagem)
        	references personagem (id),
	foreign key (id_item)
        	references item (id)
);

CREATE TABLE IF NOT EXISTS quests_personagem (
	id_personagem int not null,
	id_quest int not null,
	completa boolean,
	primary key (id_personagem, id_quest),
	foreign key (id_personagem)
		references personagem (id),
	foreign key (id_quest)
		references quest (id)
);

CREATE TABLE IF NOT EXISTS lojas (
	id int not null,
	nome varchar(40),
	tipo varchar(20),
	localizacao varchar(100),
	primary key (id)
);

CREATE TABLE IF NOT EXISTS transacao (
	id int not null,
	id_personagem int not null,
	id_loja int not null,
	dia_da_transacao date,
	primary key (id),
	foreign key (id_personagem)
		references personagem (id),
	foreign key (id_loja)
		references lojas (id)
);

CREATE INDEX preco_item
ON item (preco);
CREATE TABLE IF NOT EXISTS itens_transacao (
	id_item int not null,
	id_transacao int not null,
	preco_item double,
	quantidade int,
	valor_total double,
	primary key (id_item, id_transacao),
	foreign key (id_item)
		references item (id),
	foreign key (id_transacao)
		references transacao (id),
	foreign key (preco_item)
		references item (preco)
);

CREATE INDEX idx_nomePersonagem
ON personagem(nome);

use game_notes;

-- (id int not null, nome varchar(100) not null, idade int not null, email varchar(50))
INSERT INTO jogador VALUES 
(1, "Ana" , 19, "ana123@gmail.com", false),
(2, "Flavio" , 21, "flavio123@gmail.com", false),
(3, "Jorge" , 25, "jorge123@gmail.com", true),
(4, "Lucia" , 18, "lucia123@gmail.com", true),
(5, "Mauricio" , 29, "mauricio123@gmail.com", false),
(6, "Edmar" , 16, "edmar123@gmail.com", true),
(7, "Rodolfo" , 23, "rodolfo123@gmail.com", false),
(8, "Beth" , 17, "beth123@gmail.com", false),
(9, "Paulo" , 35, "paulo123@gmail.com", false),
(10, "Marvin", 42, "marv1n42@gmail.com", true);

-- (id int not null, nome varchar(100) not null, descricao varchar(200), habilidades varchar(200) not null)
INSERT INTO raca VALUES
(1, "An??o", "Reinos ricos em grandiosidade, sal??es cravejados nas ra??zes das montanhas, o eco de picaretas e martelos nas minas e nas forjas, dedica????o a cl?? e tradi????o, e um ??dio por orcs e goblins - s??o essas as heran??as de todo an??o.", "Constitui????o +2"),
(2, "Elfo", "Elfos s??o um povo m??gico com gra??a sobrenatural, vivendo no mundo mas n??o inteiramente parte dele.", "Destreza +2"),
(3, "Halfling", "Os confortos do lar s??o o objetivo da maioria dos halflings: Se acomodar em paz e sil??ncio, longe de monstros e ex??rcitos, com uma boa refei????o, bebida e companhia.", "Destreza +2"),
(4, "Humano", "Humanos s??o a mais nova das ra??as, com raz??es e culturas diversas, inovadores, desbravadores e pioneiros.", "+1 em todas as habilidades OU +2 em 2 habilidades e + 1 talento"),
(5, "Draconato", "Nascido de drag??es como diz seu nome, os draconatos andam orgulhosamente por um mundo que os recebe como medo e incompreens??o.", "For??a +2, Carisma +1"),
(6, "Gnomo", "Gnomos aproveitam a vida com dedica????o, aproveitando cada momento de inven????o, explora????o, investiga????o, cria????o ou brincadeira.", "Intelig??ncia +2"),
(7, "Meio-Elfo", "Andando em dois mundos mas n??o pertencendo a nenhum, meios-elfos combinam algumas das melhores qualidades de humanos e elfos: Curiosidade, inventividade e ambi????o humanas temperadas pelos sentidos afiados, amor pela natureza e gostos art??sticos dos elfos", "Carisma +2, outra habilidade +1"),
(8, "Meio-Orc", "Meios-orcs s??o filhos da fronteira, em terras onde orcs e humanos guerreiam ou comerciam. A maioria deles anda pelo mundo fazendo o que ?? necess??rio para sobreviver em um mundo que os ignora.", "For??a +2, Constitui????o +1"),
(9, "Tiefling", "Ser recebido com encaradas e sussurros, sofrer viol??ncia e insulto na rua, ver desconfian??a e medo em cada olhar: Essa ?? a vida dos tieflings, um povo amaldi??oado por um pacto feito gera????es atr??s com diabos.", "Carisma +2, Intelig??ncia +1"),
(10, "Aasimar", "Descendentes de criaturas celestiais, Aasimares parecem humanos gloriosos e heroicos. Aasimares costumam tentar disfar??ar sua linhagem para enfrentar o mal sem chamar aten????o.", "Carisma +2, Sabedoria +1");

-- (id int not null, nome varchar(100) not null, habilidades varchar(200) not null)
INSERT INTO classe VALUES
(1, "B??rbaro", "F??ria, Defesa sem Armadura, Ataque Descuidado, Sentido de Perigo, Caminho Primitivo, Ataque Extra, Instinto Selvagem, Cr??tico Brutal, F??ria Implac??vel, F??ria Persistente, For??a Indom??vel, Campe??o Primitivo"),
(2, "Bardo", "Conjura????o, Inspira????o de Bardo, Versatilidade, Can????o do Descanso, Col??gio de Bardo, Aptid??o, Fonte de Inspira????o, Can????o de Prote????o, Segredos M??gicos, Inspira????o Superior"),
(3, "Bruxo", "Patrono Transcendental, Magia de Pacto, Invoca????es M??sticas, D??diva do Pacto, Arcana M??stica(6 - 9), Mestre M??stico"),
(4, "Cl??rigo", "Conjura????o, Dom??nio Divino, Canalizar Divindade, Destruir Mortos-Vivos, Interven????o Divina, Aprimoramento de Interven????o Divina"),
(5, "Druida", "Dru??dico, Conjura????o, C??rculo Dru??dico, Forma Selvagem, Aprimoramento de Forma Selvagem, Corpo Atemporal, Magias da Besta, Arquidruida"),
(6, "Feiticeiro", "Conjura????o, Origem de Feiti??aria, Fonte de Magia, Metam??gica, Restaura????o M??stica"),
(7, "Guerreiro", "Estilo de Luta, Retomar o F??lego, Surto de A????o, Arqu??tipo Marcial, Ataque Extra(5??/11??/20??), Indom??vel (9??/13??/17??)"),
(8, "Ladino", "Especializa????o(1??/6??), Ataque Furtivo, G??ria de Ladr??o, A????o Ardilosa, Arqu??tipo de Ladino, Esquiva Sobrenatural, Evas??o, Talento Confi??vel, Sentido Cego, Mente Escorregadia, Elusivo, Golpe de Sorte"),
(9, "Mago", "Conjura????o, Recupera????o Arcana, Tradi????o Arcana, Dominar Magia, Assinatura M??gica"),
(10, "Monge", "Defesa sem Armadura, Artes Marciais, Chi, Movimento sem Armadura, Tradi????o Mon??stica, Defletir Proj??teis, Queda Lenta, Ataque Extra, Ataque Atordoante, Golpes de Chi, Evas??o, Mente Tranquila, Pureza Corporal, Idiomas do Sol e da Lua, Alma de Diamante, Corpo Atemporal, Corpo Vazio, Auto Aperfei??oamento"),
(11, "Paladino", "Sentido Divino, Cura pelas M??os, Estilo de Luta, Conjura????o, Destrui????o Divina, Sa??de Divina, Juramento Sagrado, Ataque Extra, Aura da Coragem, Destrui????o Divina Aprimorada, Toque Purificador, Aprimoramentos de Aura"),
(12, "Patrulheiro", "Inimigo Favorito, Explorador Natural, Estilo de Luta, Conjura????o, Arqu??tipo de Patrulheiro, Prontid??o Primitiva, Ataque Extra, Aprimoramentos de Inimigo Favorito e Explorador Natural, Caminho da Floresta, Mimetismo, Desaparecer, Sentidos Selvagens, Matador de Inimigos");

-- (id int not null, nome varchar(100) not null, tipo varchar(10) not null, raridade varchar(20) not null, preco double)
INSERT INTO item VALUES
(1, "Adaga" , "Arma", "Comum", 5.8),
(2, "Armadura de couro" , "Armadura", "Comum", 25.0),
(3, "Cajado do Arquimago" , "Magico", "Muito Raro", 1500.5),
(4, "Botas de rapidez" , "Magico", "Muito Raro", 550.5),
(5, "Po????o de cura" , "Consumivel", "Comum", 50.0),
(6, "Po????o de invisibilidade" , "Consumivel", "Incomum", 100.5),
(7, "Corda (metro)" , "Equipamento", "Ordin??rio", 25.0),
(8, "Pe de Cabra" , "Ferramenta", "Ordin??rio", 1.0),
(9, "Cristal transparente" , "Componente", "Comum", 0.5),
(10, "Pedra preciosa", "Tesouro", "Incomum", 100.5);

-- (id int not null, nome varchar(100) not null, funcao varchar(50), localizacao varchar(100))
INSERT INTO npc VALUES
(1,"Bazim Barlyr", "Pirata", "Ba??a da Perdi????o"),
(2,"Carydion", "Artista", "Escola de artes de Neverwinter"),
(3,"Cpt. Fright", "Militar", "Campo de treinamento de soldados de Mithral Hall"),
(4,"Rhymus", "Cavaleiro", "Guarda no porto de Baldur's Gate"),
(5,"Aesli Thrdar", "Mercante", "Andarilho. Atualmente em Daggerford"),
(6, "Almod", "Sacerdote", "Templo da Tr??ade em Bryn Shander"),
(7, "Grinarv Blaine", "Aristocrata", "Mans??o dos Blaine em Neverwinter"),
(8, "Isert Sarkarov", "Mercenario", "Anda pelo porto de Baldur's Gate"),
(9, "Carlos Guilhans", "Taberneiro", "Taberna em Bryn Shander"),
(10, "Jiulia Vendeta", "Paladina", "Sede da Guilda dos Cruzados");

-- (id int not null, descricao varchar(300) not null, recompensa varchar(100), id_npc int not null)
INSERT INTO quest VALUES
(1,"Roubar itens de um navio inimigo.", "Metade do saque", 1),
(2,"Ajudar na prote????o dos port??es contra uma invas??o de bandidos.", "Acesso livre ao porto e 100 gold", 4),
(3,"Resgatar a esposa do lorde que esta presa com o rival de comercio.", "100 gold", 7),
(4,"Ajudar a caravana de entrega de suprimentos da taberna que sofreu um acidente.", "Estadia e alimenta????o de gra??a", 9),
(5,"Buscar uma pe??a de arte sem danific??-la, em outra cidade.", "200 gold", 2),
(6,"Escolta durante a viagem do mercante at?? outra cidade.", "15 gold por dia de viagem", 5),
(7,"Explorar a tumba de Gwinhel Growew, e eliminar espectros na ??rea.", "100 gold e qualquer loot que tiver na tumba", 6),
(8,"Pegar uma ma???? dourada na arvore da eternidade.", "Entrar na guilda mais forte da cidade", 10),
(9,"Eliminar uma gangue de orcs que anda roubando viajantes nas estradas pr??ximas ?? cidade.", "350 gold e armas", 3),
(10,"Ajudar a eliminar um grupo de bandidos que saqueou seu esconderijo.", "50 gold, e uma arma", 8);

-- (id int not null, nome varchar(40), nivel int not null, id_jogador int not null, id_raca int not null, id_classe int not null, data_criacao date)
INSERT INTO personagem VALUES
(1, "Gehard", 7, 3, 4, 1, '2020/12/14'),
(2, "Jim Lee", 9, 6, 4, 10, '2020/1/10'),
(3, "Caylinn", 6, 2, 2, 9, '2021/1/23'),
(4, "Perola", 5, 1, 4, 8, '2021/3/23'),
(5, "Fushinn", 5, 4, 9, 3, '2021/3/15'),
(6, "Yonani", 4, 5, 10, 7, '2021/8/15'),
(7, "AEgir", 4, 9, 8, 5, '2021/8/15'),
(8, "Ellywick", 3, 7, 6, 4, '2021/9/3'),
(9, "Dandelion", 6, 10, 9, 2, '2021/1/23'),
(10, "Dreki", 8, 8, 4, 6, '2020/3/18');

-- (id_personagem int not null, id_item int not null, quantidade int)
INSERT INTO itens_personagem VALUES
(1, 05, 20),
(2, 06, 3),
(3, 08, 2),
(4, 09, 5),
(5, 04, 1),
(6, 07, 50),
(7, 03, 1),
(8, 01, 10),
(9, 02, 1),
(10, 10, 13);

-- (id_personagem int not null, id_quest int not null, completa boolean)
INSERT INTO quests_personagem VALUES
(2, 1, true),
(6, 5, true),
(8, 6, false),
(4, 8, false),
(1, 7, false),
(5, 9, false),
(9, 3, true),
(3, 10, false),
(7, 4, false),
(10, 2, true);

-- (id int not null, nome varchar(40), tipo varchar(20), localizacao varchar(100))
INSERT INTO lojas VALUES
(1, "O machado prateado", "Armas", "Waterdeep"),
(2, "O caldeir??o de Hastur", "Po????es", "Neverwinter"),
(3, "Grim??rio de Merlim", "Magia", "Daggerford"),
(4, "Pergaminho do Sabich??o", "Biblioteca", "Luskan"),
(5, "A coura??a do her??i", "Armadura", "Elturel"),
(6, "Prada", "Tecidos", "Sundabar"),
(7, "Mochila de aventureito", "Equipamentos gerais", "Everlund"),
(8, "Ghilihal especiarias", "Componentes", "Phlan"),
(9, "Castelo Forte", "Ferramentas", "Berdusk"),
(10, "Emporio de Rendaril", "Casa de Trocas", "Bryn Shander");

-- (id int not null, id_personagem int not null, id_loja int not null, data_transacao date)
INSERT INTO transacao VALUES
(1, 5, 1, '2019/12/19'),
(2, 4, 5, '2020/6/15'),
(3, 7, 3, '2021/1/7'),
(4, 8, 5, '2021/1/19'),
(5, 2, 2, '2021/2/10'),
(6, 1, 2, '2021/2/28'),
(7, 9, 7, '2021/3/17'),
(8, 10, 9, '2021/3/26'),
(9, 3, 8, '2021/6/8'),
(10, 6, 10, '2021/6/25');

-- (id_item int not null, id_transacao int not null, preco_item double not null, quantidade int)
INSERT INTO itens_transacao VALUES
(1, 1, 5.8, 10, preco_item*quantidade),
(2, 2, 25.0, 3, preco_item*quantidade),
(3, 3, 1500.5, 1, preco_item*quantidade),
(4, 4, 550.5, 2, preco_item*quantidade),
(5, 5, 50.0, 3, preco_item*quantidade),
(6, 6, 100.5, 1, preco_item*quantidade),
(7, 7, 25.0, 5, preco_item*quantidade),
(8, 8, 1.0, 6, preco_item*quantidade),
(9, 9, 0.5, 8, preco_item*quantidade),
(10, 10, 100.5, 1, preco_item*quantidade);
