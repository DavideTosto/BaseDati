Create database DBCentriRevisioni; 
Show databases;
Use DBCentriRevisioni;

#############################################
  create TABLE IF NOT EXISTS Strada (
	IdStrada  int not null auto_increment,
    NomeStrada varchar(100),
	Comune varchar(50) not null,
    PRIMARY KEY (IdStrada),
    index strada_key (NomeStrada),
    FOREIGN KEY (Comune)
			references Comune (Comune)
				on update cascade
				on delete no action
  )engine=innoDB;
  #3° QRY in script
INSERT INTO `dbcentrirevisioni`.`strada` (`IdStrada`, `NomeStrada`, `Comune`) VALUES ('0', 'NULL', 'NULL');


  create TABLE IF NOT EXISTS TipoStrada (
    IdTipoStrada  int not null auto_increment,
    Tipostrada varchar(50) default null,
	NomeStrada varchar(100) default null,
    PRIMARY KEY (IdTipoStrada),
	FOREIGN KEY (NomeStrada)
			references Strada(Nomestrada)
				on update cascade
				on delete no action
  )engine=innoDB;
  #4° QRY in script


   create TABLE IF NOT EXISTS Comune (
		CAP char(5) not null,
        Comune varchar(50) not null,
        PRIMARY KEY (Comune)
   )engine=innoDB;
#2° qry in script qry
INSERT INTO `dbcentrirevisioni`.`Comune` (`CAP`,`COMUNE`) VALUES ('0','NULL');

    
    create TABLE IF NOT EXISTS PROV (
		Comune varchar(50) not null,
		Provincia varchar(50) not null,
		prov char(2) not null,
        unique(Comune, Provincia),
        FOREIGN KEY (prov)
			references Regione (prov)
				on update cascade
				on delete no action,
		FOREIGN KEY (Comune)
			references Comune (Comune)
				on update cascade
				on delete no action
	)engine=innoDB;    
    
# 1° qry in script query unione indirizzi
    
  create TABLE IF NOT EXISTS Regione (
	prov char(2) not null,
	Regione varchar(30) not null,
    unique (prov, Regione),
    key (prov)
  )engine=innoDB;
INSERT INTO `dbcentrirevisioni`.`Regione` (`prov`, `Regione`) SELECT DISTINCT SiglaProvincia, Regione FROM dbcentrirevisioni.`provincia regioni` order by SiglaProvincia;

   
   
 create TABLE IF NOT EXISTS Numero (
	IdNumeroCiv  int not null auto_increment,
    PRIMARY KEY (IdNumeroCiv),
    IdStrada int not null,
    Numero smallint default NULL,
	
    foreign key (IdStrada) 
		references strada (IdStrada)
			on update cascade
			on delete no action
 )engine=innoDB;
 INSERT INTO `dbcentrirevisioni`.`numero` (`IdNumeroCiv`, `IdStrada`, `Numero`) VALUES ('0', '0', '0');



 ###########################################
 
    create TABLE IF NOT EXISTS Motorizzazione  (
    
	IdMCTC int not null auto_increment,
    PRIMARY KEY (IdMCTC),
    Nome varchar(50) not null,
	IdNumeroCiv int not null,
    
    FOREIGN KEY (IdNumeroCiv)
		references Numero(IdNumeroCiv)
			on update cascade,
    
    telefono char(10) unique   
 )engine=innoDB;
 
 INSERT INTO `dbcentrirevisioni`.`motorizzazione` (`IdMCTC`, `Nome`, `IdNumeroCiv`, `telefono`) VALUES ('1', 'MCTC TRAPANI', '65542', '3214950387');
 INSERT INTO `dbcentrirevisioni`.`motorizzazione` (`IdMCTC`, `Nome`, `IdNumeroCiv`, `telefono`) VALUES ('2', 'MCTC CATANIA', '65542', '3214950387');
 INSERT INTO `dbcentrirevisioni`.`motorizzazione` (`IdMCTC`, `Nome`, `IdNumeroCiv`, `telefono`) VALUES ('3', 'MCTC FERRARA', '65542', '3214950387');
 INSERT INTO `dbcentrirevisioni`.`motorizzazione` (`IdMCTC`, `Nome`, `IdNumeroCiv`, `telefono`) VALUES ('3', 'MCTC PALERMO', '65542', '3214950387');
 INSERT INTO `dbcentrirevisioni`.`motorizzazione` (`IdMCTC`, `Nome`, `IdNumeroCiv`, `telefono`) VALUES ('5', 'MCTC TORNIO  ', '65542', '3214950387');

 
   create TABLE IF NOT EXISTS Protocolli (
	IdProtocolli int not null auto_increment,
    Tipo varchar(30),
    IdIspettore int unique default NULL,
    IdConcessione char(5) unique default NULL,
    Giorno date,
    IdMCTC int not null,
    PRIMARY KEY ( IdProtocolli),
    FOREIGN KEY ( IdMCTC )
			references Motorizzazione ( IdMCTC )
				on update cascade
                on delete no action,
	 KEY ( IdIspettore ),
	 KEY ( IdConcessione )
	
  )engine=innoDB;
  
INSERT INTO `dbcentrirevisioni`.`protocolli` (`IdProtocolli`, `Tipo`, `IdIspettore`, `IdMCTC`) VALUES ('1', 'AUTORIZZAZIONE', '1', '1');
INSERT INTO `dbcentrirevisioni`.`protocolli` (`IdProtocolli`, `Tipo`, `IdIspettore`, `IdMCTC`) VALUES ('2', 'AUTORIZZAZIONE', '2', '2');
INSERT INTO `dbcentrirevisioni`.`protocolli` (`IdProtocolli`, `Tipo`, `IdIspettore`, `IdMCTC`) VALUES ('3', 'AUTORIZZAZIONE', '3', '3');
INSERT INTO `dbcentrirevisioni`.`protocolli` (`IdProtocolli`, `Tipo`, `IdIspettore`, `IdMCTC`) VALUES ('4', 'AUTORIZZAZIONE', '4', '4');
INSERT INTO `dbcentrirevisioni`.`protocolli` (`IdProtocolli`, `Tipo`, `IdIspettore`, `IdMCTC`) VALUES ('5', 'AUTORIZZAZIONE', '5', '1');
INSERT INTO `dbcentrirevisioni`.`protocolli` (`IdProtocolli`, `Tipo`, `IdIspettore`, `IdMCTC`) VALUES ('6', 'AUTORIZZAZIONE', '6', '3');
INSERT INTO `dbcentrirevisioni`.`protocolli` (`IdProtocolli`, `Tipo`, `IdIspettore`, `IdMCTC`) VALUES ('7', 'AUTORIZZAZIONE', '7', '1');
INSERT INTO `dbcentrirevisioni`.`protocolli` (`IdProtocolli`, `Tipo`, `IdIspettore`, `IdMCTC`) VALUES ('10', 'CONCESSIONE', 'TPAE8','1');
INSERT INTO `dbcentrirevisioni`.`protocolli` (`IdProtocolli`, `Tipo`, `IdIspettore`, `IdMCTC`) VALUES ('11', 'CONCESSIONE', 'TPAB6','1');
INSERT INTO `dbcentrirevisioni`.`protocolli` (`IdProtocolli`, `Tipo`, `IdIspettore`, `IdMCTC`) VALUES ('12', 'CONCESSIONE', 'TPAI6', '1');
INSERT INTO `dbcentrirevisioni`.`protocolli` (`IdProtocolli`, `Tipo`, `IdIspettore`, `IdMCTC`) VALUES ('13', 'CONCESSIONE', 'TPAH0','1'); 
INSERT INTO `dbcentrirevisioni`.`protocolli` (`IdProtocolli`, `Tipo`, `IdIspettore`, `IdMCTC`) VALUES ('14', 'CONCESSIONE', 'TPAD1','1'); 
  ##########################################################

create TABLE IF NOT EXISTS Ispettore (
	IdIspettore int not null,
    Nome varchar(10) not null,
    Cognome varchar(10) not null,
    IdConcessione char(11) default 'Disoccupato',
    FOREIGN KEY ( IdConcessione)
            references Protocolli (IdConcessione),
	 FOREIGN KEY ( IdIspettore)
            references Protocolli (IdIspettore),
	 unique (IdIspettore, IdConcessione)
    ) engine=innoDB;
		
INSERT INTO `dbcentrirevisioni`.`Ispettore` (`IdIspettore`,`Nome`, `Cognome`, `IdConcessione`) VALUES ('1','Davide', 'Tosto', 'TPAH0');
INSERT INTO `dbcentrirevisioni`.`ispettore` (`IdIspettore`,`Nome`, `Cognome`, `IdConcessione`) VALUES ('2','GIUSEPPE', 'ANGELO', 'TPAE8');
INSERT INTO `dbcentrirevisioni`.`ispettore` (`IdIspettore`,`Nome`, `Cognome`, `IdConcessione`) VALUES ('3','ROBERTO', 'CUBEDDRO', 'TPAD1');
INSERT INTO `dbcentrirevisioni`.`ispettore` (`IdIspettore`,`Nome`, `Cognome`, `IdConcessione`) VALUES ('4','FANARA', 'GIUSEPPE', 'TPAE8');
INSERT INTO `dbcentrirevisioni`.`ispettore` (`IdIspettore`,`Nome`, `Cognome`, `IdConcessione`) VALUES ('5','FRANCESCO', 'BARONE', 'TPAH0');


create TABLE IF NOT EXISTS CentriRevisioni (
		IdConcessione char(5) PRIMARY KEY,
        FOREIGN KEY ( IdConcessione)
            references Protocolli (IdConcessione)
				on update cascade
				on delete no action,
                
        Nome varchar(200) not null,
		IdNumeroCiv int not null,
        FOREIGN KEY (IdNumeroCiv)
		references Numero(IdNumeroCiv)
			on update cascade
			on delete no action,
        
	IdAssistenza int not null,
	 FOREIGN KEY (IdAssistenza)
			references AssistenzaTecnica (IdAssistenza)
				on update cascade
				on delete no action
  )engine=innoDB;
  
INSERT INTO `dbcentrirevisioni`.`centrirevisioni` (`IdConcessione`, `Nome`, `IdNumeroCiv`, `IdAssistenza`) VALUES ('TPAH0', 'CENTRO REVISIONI URSO E COSTA', '65545', '1');
INSERT INTO `dbcentrirevisioni`.`centrirevisioni` (`IdConcessione`, `Nome`, `IdNumeroCiv`, `IdAssistenza`) VALUES ('TPAE8', 'GIUSEPPE D\'ANGELO', '65546', '2');
INSERT INTO `dbcentrirevisioni`.`centrirevisioni` (`IdConcessione`, `Nome`, `IdNumeroCiv`, `IdAssistenza`) VALUES ('TPAB8', 'GIACALONE', '65547', '1');
INSERT INTO `dbcentrirevisioni`.`centrirevisioni` (`IdConcessione`, `Nome`, `IdNumeroCiv`, `IdAssistenza`) VALUES ('TPAI6', 'AUTOCULOMA', '11111', '1');
INSERT INTO `dbcentrirevisioni`.`centrirevisioni` (`IdConcessione`, `Nome`, `IdNumeroCiv`, `IdAssistenza`) VALUES ('TPAD1', 'CIESSE', '1379', '1');

  
  create TABLE IF NOT EXISTS AssistenzaTecnica (
		IdAssistenza int unique NOT NULL,
        PRIMARY KEY (IdAssistenza),
        Nome varchar(100) not null,
        
        IdNumeroCiv int not null,
        FOREIGN KEY (IdNumeroCiv)
		references Numero(IdNumeroCiv)
			on update cascade
			on delete no action,
            
        telefono char(10) unique
  )engine=innoDB;

INSERT INTO `dbcentrirevisioni`.`assistenzatecnica` (`IdAssistenza`, `Nome`, `IdNumeroCiv`, `telefono`) VALUES ('1', 'TECNOSERVICE', '65543', '345621302');
INSERT INTO `dbcentrirevisioni`.`assistenzatecnica` (`IdAssistenza`, `Nome`, `IdNumeroCiv`, `telefono`) VALUES ('2', 'CERRI', '65544', '3201236548');

  
#####################################
#####################################

create TABLE IF NOT EXISTS Proprietario (
	CodiceFiscale char(17) primary key,
    Nome varchar(100) not null,
    Cognome varchar(100) not null,
    
    IdNumeroCiv int not null,
        FOREIGN KEY (IdNumeroCiv)
		references Numero(IdNumeroCiv)
			on update cascade
			on delete no action

    ) engine=innoDB;
    
INSERT INTO `dbcentrirevisioni`.`proprietario` (`CodiceFiscale`, `Nome`, `Cognome`, `IdNumeroCiv`) VALUES ('TSTDVD96E01D423P', 'DAVIDE', 'TOSTO', '1');
INSERT INTO `dbcentrirevisioni`.`proprietario` (`CodiceFiscale`, `Nome`, `Cognome`, `IdNumeroCiv`) VALUES ('TLOFNC68T41D748R', 'FRANCESCA ADRIANA', 'TOLU', '5384');
INSERT INTO `dbcentrirevisioni`.`proprietario` (`CodiceFiscale`, `Nome`, `Cognome`, `IdNumeroCiv`) VALUES (' BNFVRN16C41E923N', 'VALERIA ANNA', 'BENFANTE', '887');
UPDATE `dbcentrirevisioni`.`proprietario` SET `CodiceFiscale` = 'BNFVRN16C41E923N' WHERE (`CodiceFiscale` = ' BNFVRN16C41E923N');
INSERT INTO `dbcentrirevisioni`.`proprietario` (`CodiceFiscale`, `Nome`, `Cognome`, `IdNumeroCiv`) VALUES ('RBZTSL28B01F387U', 'TARSILLO', 'RABEZZANA MORO', '778');
INSERT INTO `dbcentrirevisioni`.`proprietario` (`CodiceFiscale`, `Nome`, `Cognome`, `IdNumeroCiv`) VALUES ('CRLLLL95C41H462K', 'LUISELLA CARLA', ' CARLONE', '4916');
INSERT INTO `dbcentrirevisioni`.`proprietario` (`CodiceFiscale`, `Nome`, `Cognome`, `IdNumeroCiv`) VALUES ('TRBLVD80L01B280P', 'ILIE OVIDIU', 'TRABUCCHI', '1794');
INSERT INTO `dbcentrirevisioni`.`proprietario` (`CodiceFiscale`, `Nome`, `Cognome`, `IdNumeroCiv`) VALUES ('MHLCST02A41F608F', 'CRISTINA ANGELA', 'MHILLI', '2336');
INSERT INTO `dbcentrirevisioni`.`proprietario` (`CodiceFiscale`, `Nome`, `Cognome`, `IdNumeroCiv`) VALUES ('BLLNZN95L41I821X', 'ENZINA', 'BALLIU', '5387');
INSERT INTO `dbcentrirevisioni`.`proprietario` (`CodiceFiscale`, `Nome`, `Cognome`, `IdNumeroCiv`) VALUES ('CRTMTG35P01C341S', 'MATTEO GABRIELE', 'CARTURAN', '493');

    
 create TABLE IF NOT EXISTS FabbricaModello (
	Modello varchar(10) PRIMARY KEY,
    Fabbrica varchar(10) not null,
    unique (Modello, Fabbrica)
 )engine=innoDB;
 
ALTER TABLE `dbcentrirevisioni`.`fabbricamodello` 
CHANGE COLUMN `Modello` `Modello` VARCHAR(100) NOT NULL ,
CHANGE COLUMN `Fabbrica` `Fabbrica` VARCHAR(100) NOT NULL ;

INSERT INTO `dbcentrirevisioni`.`FabbricaModello`(`Modello`,`Fabbrica`) VALUES ('CIUNQUECENTO','FIAT');
INSERT INTO `dbcentrirevisioni`.`FabbricaModello`(`Modello`,`Fabbrica`) VALUES ('500','FIAT');
INSERT INTO `dbcentrirevisioni`.`FabbricaModello`(`Modello`,`Fabbrica`) VALUES ('500 X','FIAT');
INSERT INTO `dbcentrirevisioni`.`FabbricaModello`(`Modello`,`Fabbrica`) VALUES ('500 L','FIAT');
INSERT INTO `dbcentrirevisioni`.`FabbricaModello`(`Modello`,`Fabbrica`) VALUES ('TIPO','FIAT');
INSERT INTO `dbcentrirevisioni`.`FabbricaModello`(`Modello`,`Fabbrica`) VALUES ('PUNTO','FIAT');
INSERT INTO `dbcentrirevisioni`.`FabbricaModello`(`Modello`,`Fabbrica`) VALUES ('FIORINO','FIAT');
INSERT INTO `dbcentrirevisioni`.`FabbricaModello`(`Modello`,`Fabbrica`) VALUES ('C3','CITROEN');
INSERT INTO `dbcentrirevisioni`.`FabbricaModello`(`Modello`,`Fabbrica`) VALUES ('C4','CITROEN');
INSERT INTO `dbcentrirevisioni`.`FabbricaModello`(`Modello`,`Fabbrica`) VALUES ('NEMO','CITROEN');
INSERT INTO `dbcentrirevisioni`.`FabbricaModello`(`Modello`,`Fabbrica`) VALUES ('206','PEUGEOT');
INSERT INTO `dbcentrirevisioni`.`FabbricaModello`(`Modello`,`Fabbrica`) VALUES ('107','PEUGEOT');
INSERT INTO `dbcentrirevisioni`.`FabbricaModello`(`Modello`,`Fabbrica`) VALUES ('GIULIA','ALFA ROMEO');
INSERT INTO `dbcentrirevisioni`.`fabbricamodello` (`Modello`, `Fabbrica`) VALUES ('GIULIETTA', 'ALFA ROMEO');
INSERT INTO `dbcentrirevisioni`.`fabbricamodello` (`Modello`, `Fabbrica`) VALUES ('COOPER', 'MINI');
INSERT INTO `dbcentrirevisioni`.`fabbricamodello` (`Modello`, `Fabbrica`) VALUES ('GOLF', 'VOLKSWAGEN');
INSERT INTO `dbcentrirevisioni`.`fabbricamodello` (`Modello`, `Fabbrica`) VALUES ('YPSILON', 'LANCIA');

 
 create TABLE IF NOT EXISTS Veicoli (
	VIN char(16) PRIMARY KEY,
    targa char(7) unique,
    Modello varchar(10),
    AnnoImmatricolazione int default NULL,
    
    CodiceFiscale char(16) not null,
     FOREIGN KEY ( CodiceFiscale )
		references Proprietario ( CodiceFiscale )
			on update cascade
			on delete cascade,
	 FOREIGN KEY ( Modello )
		references FabbricaModello ( Modello )
			on update cascade
			on delete set null
 )engine=innoDB;
 
 ALTER TABLE `dbcentrirevisioni`.`veicoli` 
CHANGE COLUMN `Modello` `Modello` VARCHAR(50) NULL DEFAULT NULL ;
 
INSERT INTO `dbcentrirevisioni`.`veicoli` (`VIN`, `targa`, `Modello`, `AnnoImmatricolazione`, `CodiceFiscale`) VALUES ('ZFA141A0001291210', 'AV215DE', 'CIUNQUECENTO', '1997', 'BLLNZN95L41I821X');
INSERT INTO `dbcentrirevisioni`.`veicoli` (`VIN`, `targa`, `Modello`, `AnnoImmatricolazione`, `CodiceFiscale`) VALUES ('ZFA14600009305900', 'AB048HH', 'PUNTO', '1994', 'BNFVRN16C41E923N');
INSERT INTO `dbcentrirevisioni`.`veicoli` (`VIN`, `targa`, `Modello`, `AnnoImmatricolazione`, `CodiceFiscale`) VALUES ('ZAR94000007349826', 'EX249FJ', 'GIULIETTA', '2014', 'TRBLVD80L01B280P');
INSERT INTO `dbcentrirevisioni`.`veicoli` (`VIN`, `targa`, `Modello`, `AnnoImmatricolazione`, `CodiceFiscale`) VALUES ('VF34E9HD8DS093677', 'GH148SY', 'C3', '2013', 'TRBLVD80L01B280P');
INSERT INTO `dbcentrirevisioni`.`veicoli` (`VIN`, `targa`, `Modello`, `AnnoImmatricolazione`, `CodiceFiscale`) VALUES ('WF0JXXGAHJHE38807', 'FM362ZF', 'C3', '2018', 'TLOFNC68T41D748R');
INSERT INTO `dbcentrirevisioni`.`veicoli` (`VIN`, `targa`, `Modello`, `AnnoImmatricolazione`, `CodiceFiscale`) VALUES ('VF77FBHY6HJ895445', 'FK678KR', 'C4', '2018', 'TLOFNC68T41D748R');
INSERT INTO `dbcentrirevisioni`.`veicoli` (`VIN`, `targa`, `Modello`, `AnnoImmatricolazione`, `CodiceFiscale`) VALUES ('ZAR91600006048606', 'BD415ES', 'GIULIETTA', '1999', 'CRTMTG35P01C341S');
INSERT INTO `dbcentrirevisioni`.`veicoli` (`VIN`, `targa`, `Modello`, `AnnoImmatricolazione`, `CodiceFiscale`) VALUES ('ZAR12345678912345', 'FH568FM', 'GIULIETTA', '2017', 'TSTDVD96E01D423P');
INSERT INTO `dbcentrirevisioni`.`veicoli` (`VIN`, `targa`, `Modello`, `AnnoImmatricolazione`, `CodiceFiscale`) VALUES ('ZFA17600000624917', 'GE315JV', 'PUNTO', '1996', 'MHLCST02A41F608F');
INSERT INTO `dbcentrirevisioni`.`veicoli` (`VIN`, `targa`, `Modello`, `AnnoImmatricolazione`, `CodiceFiscale`) VALUES ('ZLA31200005244246', 'FA340RE', '500', '2015', 'TSTDVD96E01D423P');
INSERT INTO `dbcentrirevisioni`.`veicoli` (`VIN`, `targa`, `Modello`, `AnnoImmatricolazione`, `CodiceFiscale`) VALUES ('WVWZZZ1KZAP056080', 'DX152PG', 'GOLF', '2009', 'MHLCST02A41F608F');
INSERT INTO `dbcentrirevisioni`.`veicoli` (`VIN`, `targa`, `Modello`, `AnnoImmatricolazione`, `CodiceFiscale`) VALUES ('VF7FCHFXC9A110681', 'DS109PF', 'C4', '2000', 'RBZTSL28B01F387U');
INSERT INTO `dbcentrirevisioni`.`veicoli` (`VIN`, `targa`, `Modello`, `AnnoImmatricolazione`, `CodiceFiscale`) VALUES ('ZFA18800004637119', 'CL351NY', 'PUNTO', '1998', 'CRTMTG35P01C341S');
INSERT INTO `dbcentrirevisioni`.`veicoli` (`VIN`, `targa`, `Modello`, `AnnoImmatricolazione`, `CodiceFiscale`) VALUES ('JTDKC123205021089', 'FH562YC', 'COOPER', '1996', 'RBZTSL28B01F387U');
INSERT INTO `dbcentrirevisioni`.`veicoli` (`VIN`, `targa`, `Modello`, `AnnoImmatricolazione`, `CodiceFiscale`) VALUES ('ZAR94000007229479', 'ES705LK', 'GIULIETTA', '2015', 'TSTDVD96E01D423P');
INSERT INTO `dbcentrirevisioni`.`veicoli` (`VIN`, `targa`, `Modello`, `AnnoImmatricolazione`, `CodiceFiscale`) VALUES ('ZFA18700001124126', 'CD999YX', '500', '1998', 'RBZTSL28B01F387U');
INSERT INTO `dbcentrirevisioni`.`veicoli` (`VIN`, `targa`, `Modello`, `AnnoImmatricolazione`, `CodiceFiscale`) VALUES ('ZLA31200005345708', 'CF943TR', 'YPSILON', '2012', 'RBZTSL28B01F387U');
INSERT INTO `dbcentrirevisioni`.`veicoli` (`VIN`, `targa`, `Modello`, `AnnoImmatricolazione`, `CodiceFiscale`) VALUES ('ZFA19900001425075', 'GF583BW', '500 X', '2016', 'TSTDVD96E01D423P');

    
#######################################
######################################
######################################
 
  create TABLE IF NOT EXISTS Fornitori (
	IdFornitore int not null auto_increment,
    Nome varchar(25) not null,
    
     IdNumeroCiv int not null,
        FOREIGN KEY (IdNumeroCiv)
		references Numero(IdNumeroCiv)
			on update cascade
			on delete no action,
            
	Telefono char(10) unique,
    PRIMARY KEY (IdFornitore)
 )engine=innoDB;
INSERT INTO `dbcentrirevisioni`.`fornitori` (`Nome`, `IdNumeroCiv`, `Telefono`) VALUES ('Autoricambi', '6321', '3201569873');
INSERT INTO `dbcentrirevisioni`.`fornitori` (`Nome`, `IdNumeroCiv`, `Telefono`) VALUES ('Ricambimoto', '1122', '3021569436');
INSERT INTO `dbcentrirevisioni`.`fornitori` (`Nome`, `IdNumeroCiv`, `Telefono`) VALUES ('Campericambi', '3678', '321569487');
INSERT INTO `dbcentrirevisioni`.`fornitori` (`Nome`, `IdNumeroCiv`, `Telefono`) VALUES ('Triclibi', '328', '3289741650');

 
 
   create TABLE IF NOT EXISTS Ordine (
	IdOrdine int not null auto_increment,
    PRIMARY KEY (IdOrdine),
    
    Quantità smallint not null,
    Prezzo float not null,
    IdFornitore int not null,
    IdConcessione char(5) not null,
    
    FOREIGN KEY ( IdFornitore)
			references Fornitori ( IdFornitore )
            on update cascade
            on delete no action,
	FOREIGN KEY ( IdConcessione)
            references CentriRevisioni (IdConcessione)
			on update cascade
            on delete no action
 )engine=innoDB;
 
INSERT INTO `dbcentrirevisioni`.`ordine` (`Quantità`, `Prezzo`, `IdFornitore`, `IdConcessione`) VALUES ('75', '0.50', '1', 'TPAH0');
INSERT INTO `dbcentrirevisioni`.`ordine` (`Quantità`, `Prezzo`, `IdFornitore`, `IdConcessione`) VALUES ('21', '1.50', '2', 'TPAE8');
INSERT INTO `dbcentrirevisioni`.`ordine` (`Quantità`, `Prezzo`, `IdFornitore`, `IdConcessione`) VALUES ('39', '1', '1', 'TPAH0');
INSERT INTO `dbcentrirevisioni`.`ordine` (`Quantità`, `Prezzo`, `IdFornitore`, `IdConcessione`) VALUES ('1', '50', '2', 'TPAE8');
INSERT INTO `dbcentrirevisioni`.`ordine` (`Quantità`, `Prezzo`, `IdFornitore`, `IdConcessione`) VALUES ('3', '100', '1', 'TPAH0');
INSERT INTO `dbcentrirevisioni`.`ordine` (`Quantità`, `Prezzo`, `IdFornitore`, `IdConcessione`) VALUES ('27', '0.50', '3', 'TPAE8');
INSERT INTO `dbcentrirevisioni`.`ordine` (`Quantità`, `Prezzo`, `IdFornitore`, `IdConcessione`) VALUES ('53', '1.50', '1', 'TPAH0');
INSERT INTO `dbcentrirevisioni`.`ordine` (`Quantità`, `Prezzo`, `IdFornitore`, `IdConcessione`) VALUES ('45', '1', '4', 'TPAB8');
INSERT INTO `dbcentrirevisioni`.`ordine` (`Quantità`, `Prezzo`, `IdFornitore`, `IdConcessione`) VALUES ('2', '50', '4', 'TPAB8');
INSERT INTO `dbcentrirevisioni`.`ordine` (`Quantità`, `Prezzo`, `IdFornitore`, `IdConcessione`) VALUES ('78', '4', '1', 'TPAE8');


 create TABLE IF NOT EXISTS Meccanico (
	IdCollaboratore int not null auto_increment,
    PRIMARY KEY (IdCollaboratore),
    
    Nome varchar(10) not null,
    Cognome varchar(10) not null,
    Ore smallint not null,
    PagaOraria float not null,
    
    Specializzazione varchar(50),	
    IdConcessione varchar(15) default 'Disoccupato',
    FOREIGN KEY (IdConcessione)
			references CentriRevisioni ( IdConcessione)
            on update cascade
            on delete set null
 ) engine=innoDB;
 
 INSERT INTO `dbcentrirevisioni`.`meccanico` (`Nome`, `Cognome`, `Ore`, `PagaOraria`, `Specializzazione`, `IdConcessione`) VALUES ('Vasile', 'Leonardo', '7', '12', 'Meccanico', 'TPAH0');
INSERT INTO `dbcentrirevisioni`.`meccanico` (`Nome`, `Cognome`, `Ore`, `PagaOraria`, `Specializzazione`, `IdConcessione`) VALUES ('Pizzimenti', 'Francesco', '8', '10', 'Elettrauto', 'TPAH0');
INSERT INTO `dbcentrirevisioni`.`meccanico` (`Nome`, `Cognome`, `Ore`, `PagaOraria`, `Specializzazione`, `IdConcessione`) VALUES ('Marco', 'Di Bono', '7', '9', 'Carrozziere', 'TPAE8');
INSERT INTO `dbcentrirevisioni`.`meccanico` (`Nome`, `Cognome`, `Ore`, `PagaOraria`, `Specializzazione`, `IdConcessione`) VALUES ('Marco', 'Di Bella', '8', '15', 'Meccanico', 'TPAD1');
INSERT INTO `dbcentrirevisioni`.`meccanico` (`Nome`, `Cognome`, `Ore`, `PagaOraria`, `Specializzazione`, `IdConcessione`) VALUES ('Natale', 'Romano', '7', '8', 'Elettrauto', 'TPAH0');
INSERT INTO `dbcentrirevisioni`.`meccanico` (`Nome`, `Cognome`, `Ore`, `PagaOraria`, `Specializzazione`, `IdConcessione`) VALUES ('Cipollina', 'Alberto', '8', '10', 'Meccanico', 'TPAD1');
INSERT INTO `dbcentrirevisioni`.`meccanico` (`Nome`, `Cognome`, `Ore`, `PagaOraria`, `Specializzazione`, `IdConcessione`) VALUES ('Francesco', 'Palermo', '7', '5', 'Elettrauto', 'TPAE8');
INSERT INTO `dbcentrirevisioni`.`meccanico` (`Nome`, `Cognome`, `Ore`, `PagaOraria`, `Specializzazione`, `IdConcessione`) VALUES ('Francesco', 'ffggg', '7', '5', 'Elettrauto', 'TPAE8');

 
 ################################## 4
 #################################
  
 
  create TABLE IF NOT EXISTS Ripara (
	IdRiparazione int not null auto_increment,
    PRIMARY KEY (IdRiparazione),
    Tempo float default 0.05,
	Giorno date,
    IdCollaboratore int not null,
    VIN char(17) not null,
    
     FOREIGN KEY ( IdCollaboratore )
		references Meccanico ( IdCollaboratore )
				on update cascade
                on delete no action,	
	 FOREIGN KEY ( VIN )
		references Veicoli ( VIN )
				on update cascade
                on delete no action
  )engine=innoDB;
INSERT INTO `dbcentrirevisioni`.`ripara` (`IdRiparazione`, `Tempo`, `Giorno`, `IdCollaboratore`, `VIN`) VALUES ('1', '1', '2021/09/09', '4', 'ZAR94000007229479');
INSERT INTO `dbcentrirevisioni`.`ripara` (`IdRiparazione`, `Tempo`, `Giorno`, `IdCollaboratore`, `VIN`) VALUES ('2', '2', '2021/06/19', '5', 'VF7FCHFXC9A110681');
INSERT INTO `dbcentrirevisioni`.`ripara` (`IdRiparazione`, `Tempo`, `Giorno`, `IdCollaboratore`, `VIN`) VALUES ('3', '3', '2020/01/01', '6', 'ZLA31200005244246');
INSERT INTO `dbcentrirevisioni`.`ripara` (`IdRiparazione`, `Tempo`, `Giorno`, `IdCollaboratore`, `VIN`) VALUES ('4', '4', '2020/01/02', '7', 'VF7FCHFXC9A110681');
INSERT INTO `dbcentrirevisioni`.`ripara` (`IdRiparazione`, `Tempo`, `Giorno`, `IdCollaboratore`, `VIN`) VALUES ('5', '1', '2020/01/03', '7', 'ZAR94000007229479');
INSERT INTO `dbcentrirevisioni`.`ripara` (`IdRiparazione`, `Tempo`, `Giorno`, `IdCollaboratore`, `VIN`) VALUES ('6', '1', '2020/01/04', '2', 'VF7FCHFXC9A110681');
INSERT INTO `dbcentrirevisioni`.`ripara` (`IdRiparazione`, `Tempo`, `Giorno`, `IdCollaboratore`, `VIN`) VALUES ('7', '2', '2020/01/05', '1', 'ZLA31200005244246');
INSERT INTO `dbcentrirevisioni`.`ripara` (`IdRiparazione`, `Tempo`, `Giorno`, `IdCollaboratore`, `VIN`) VALUES ('8', '4', '2020/01/06', '1', 'ZFA141A0001291210');
INSERT INTO `dbcentrirevisioni`.`ripara` (`IdRiparazione`, `Tempo`, `Giorno`, `IdCollaboratore`, `VIN`) VALUES ('9', '7', '2020/01/07', '2', 'ZFA14600009305900');
INSERT INTO `dbcentrirevisioni`.`ripara` (`IdRiparazione`, `Tempo`, `Giorno`, `IdCollaboratore`, `VIN`) VALUES ('10', '4', '2023/01/23', '2', 'VF77FBHY6HJ895445');
INSERT INTO `dbcentrirevisioni`.`ripara` (`IdRiparazione`, `Tempo`, `Giorno`, `IdCollaboratore`, `VIN`) VALUES ('11', '8', '2023/04/30', '4', 'ZAR12345678912345');
INSERT INTO `dbcentrirevisioni`.`ripara` (`IdRiparazione`, `Tempo`, `Giorno`, `IdCollaboratore`, `VIN`) VALUES ('12', '1', '2023/05/2', '3', 'WF0JXXGAHJHE38807');
INSERT INTO `dbcentrirevisioni`.`ripara` (`IdRiparazione`, `Tempo`, `Giorno`, `IdCollaboratore`, `VIN`) VALUES ('13', '2', '2023/08/15', '5', 'ZAR12345678912345');
INSERT INTO `dbcentrirevisioni`.`ripara` (`IdRiparazione`, `Tempo`, `Giorno`, `IdCollaboratore`, `VIN`) VALUES ('14', '3', '2023/01/09', '7', 'ZAR91600006048606');
INSERT INTO `dbcentrirevisioni`.`ripara` (`IdRiparazione`, `Tempo`, `Giorno`, `IdCollaboratore`, `VIN`) VALUES ('15', '4', '2022/2/2', '6', 'ZAR91600006048606');
INSERT INTO `dbcentrirevisioni`.`ripara` (`IdRiparazione`, `Tempo`, `Giorno`, `IdCollaboratore`, `VIN`) VALUES ('17', '4', '2022/2/2', '9', 'ZAR91600006048606');

  create TABLE IF NOT EXISTS Revisioni (
	IdRevisione int not null auto_increment,
    PRIMARY KEY (IdRevisione),
    Esito varchar(10),
    Prezzo float,
    Giorno date,
    
    IdIspettore int not null,
    VIN char(17) not null,
    
     FOREIGN KEY ( IdIspettore )
		references Protocolli ( IdIspettore )
				on update cascade
                on delete no action,	
	 FOREIGN KEY ( VIN )
		references Veicoli ( VIN )
				on update cascade
                on delete no action
  )engine=innoDB;

INSERT INTO `dbcentrirevisioni`.`revisioni` (`IdRevisione`, `Esito`, `Prezzo`, `Giorno`, `IdIspettore`, `VIN`) VALUES ('1', 'REGOLARE', '66.88', '2015-01-01', '1', 'ZFA17600000624917');
INSERT INTO `dbcentrirevisioni`.`revisioni` (`IdRevisione`, `Esito`, `Prezzo`, `Giorno`, `IdIspettore`, `VIN`) VALUES ('2', 'REGOLARE', '66.88', '2017-03-01', '6', 'ZLA31200005244246');
INSERT INTO `dbcentrirevisioni`.`revisioni` (`IdRevisione`, `Esito`, `Prezzo`, `Giorno`, `IdIspettore`, `VIN`) VALUES ('3', 'IRREGOLARE', '66.88', '2019-05-01', '2', 'WVWZZZ1KZAP056080');
INSERT INTO `dbcentrirevisioni`.`revisioni` (`IdRevisione`, `Esito`, `Prezzo`, `Giorno`, `IdIspettore`, `VIN`) VALUES ('4', 'IRREGOLARE', '79', '2022-07-01', '1', 'VF7FCHFXC9A110681');
INSERT INTO `dbcentrirevisioni`.`revisioni` (`IdRevisione`, `Esito`, `Prezzo`, `Giorno`, `IdIspettore`, `VIN`) VALUES ('5', 'REGOLARE', '79', '2022-09-22', '3', 'ZFA18800004637119');
INSERT INTO `dbcentrirevisioni`.`revisioni` (`IdRevisione`, `Esito`, `Prezzo`, `Giorno`, `IdIspettore`, `VIN`) VALUES ('6', 'REGOLARE', '79', '2022-12-12', '2', 'JTDKC123205021089');
INSERT INTO `dbcentrirevisioni`.`revisioni` (`IdRevisione`, `Esito`, `Prezzo`, `Giorno`, `IdIspettore`, `VIN`) VALUES ('7', 'IRREGOLARE', '79', '2023-01-03', '4', 'ZAR94000007229479');
INSERT INTO `dbcentrirevisioni`.`revisioni` (`IdRevisione`, `Esito`, `Prezzo`, `Giorno`, `IdIspettore`, `VIN`) VALUES ('8', 'IRREGOLARE', '79', '2023-05-07', '3', 'JTDKC123205021089');
INSERT INTO `dbcentrirevisioni`.`revisioni` (`IdRevisione`, `Esito`, `Prezzo`, `Giorno`, `IdIspettore`, `VIN`) VALUES ('9', 'REGOLARE', '79', '2023-05-30', '5', 'ZFA17600000624917');
INSERT INTO `dbcentrirevisioni`.`revisioni` (`IdRevisione`, `Esito`, `Prezzo`, `Giorno`, `IdIspettore`, `VIN`) VALUES ('10', 'REGOLARE', '79', '2023-06-06', '4', 'WVWZZZ1KZAP056080');
INSERT INTO `dbcentrirevisioni`.`revisioni` (`IdRevisione`, `Esito`, `Prezzo`, `Giorno`, `IdIspettore`, `VIN`) VALUES ('11', 'IRREGOLARE', '79', '2023/09/14', '1', 'ZFA17600000624917');

 