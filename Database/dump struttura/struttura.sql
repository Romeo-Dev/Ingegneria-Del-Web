drop database if exists PollWeb; 

# creaimo il database e lo selezioniamo come default per tutte le istruzioni successive
create database PollWeb;
use PollWeb;

create table gruppo(
ID integer unsigned not null primary key auto_increment,
ruolo varchar(50) not null
);

create table utente(
ID integer unsigned not null primary key auto_increment,
IDruolo integer unsigned not null,
nome  varchar(100) not null,
cognome  varchar(100) not null,
email varchar(100) not null,

constraint gruppo_utente foreign key (IDruolo) references gruppo(ID) on update cascade on delete cascade
);

create table tipologia(
ID integer unsigned not null primary key auto_increment,
tipologia varchar(100) not null
);

create table sondaggio(
ID integer unsigned not null primary key auto_increment,
IDresponsabile integer unsigned not null,
titolo varchar(255) not null,
testo_apertura text not null,
testo_chiusura text not null,
riservato boolean default false,
attivato boolean default false,
url varchar(255),
 constraint utente_sondaggio foreign key (IDresponsabile) references utente(ID) on update cascade on delete cascade
);


create table partecipano(
ID integer unsigned not null primary key auto_increment,
IDpartecipante integer unsigned not null,
IDsondaggio integer unsigned not null,
password varchar(50),
completato boolean default false,

	constraint utente_partecipano foreign key (IDpartecipante) references utente(ID) on update cascade on delete cascade,
	constraint sondaggio_partecipano foreign key (IDsondaggio) references sondaggio(ID) on update cascade on delete cascade
);

create table domande(
ID integer unsigned not null primary key auto_increment,
IDtipo integer unsigned not null,
IDsondaggio integer unsigned not null,
testo text not null,
nota text,
obbligatoria boolean default false,
min integer not null default 0,
max integer,
regular_exp varchar(100),
	
	
	constraint tipologia_domanda  foreign key (IDtipo) references tipologia(ID) on update cascade on delete cascade,
	constraint sondaggio_domanda foreign key (IDsondaggio) references sondaggio(ID) on update cascade on delete cascade

);


create table risposte(
ID integer unsigned not null primary key auto_increment,
IDdomanda integer unsigned not null,
IDpartecipante integer unsigned not null,
giorno timestamp not null,
valore varchar(255) not null,
constraint utente_risposte foreign key (IDpartecipante) references utente(ID) on update cascade on delete cascade,
constraint domande_risposte foreign key (IDdomanda) references domande(ID) on update cascade on delete cascade
);