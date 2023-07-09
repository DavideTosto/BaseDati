ALTER TABLE `dbcentrirevisioni`.`strada` 
DROP FOREIGN KEY `strada_ibfk_1`;
ALTER TABLE `dbcentrirevisioni`.`strada` 
ADD CONSTRAINT `strada_ibfk_1`
  FOREIGN KEY (`Comune`)
  REFERENCES `dbcentrirevisioni`.`comune` (`Comune`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE;
  
ALTER TABLE `dbcentrirevisioni`.`tipostrada` 
DROP FOREIGN KEY `tipostrada_ibfk_1`;
ALTER TABLE `dbcentrirevisioni`.`tipostrada` 
ADD CONSTRAINT `tipostrada_ibfk_1`
  FOREIGN KEY (`NomeStrada`)
  REFERENCES `dbcentrirevisioni`.`strada` (`NomeStrada`)
  ON DELETE SET NULL
  ON UPDATE CASCADE;
  
ALTER TABLE `dbcentrirevisioni`.`numero` 
DROP FOREIGN KEY `numero_ibfk_1`;
ALTER TABLE `dbcentrirevisioni`.`numero` 
CHANGE COLUMN `IdStrada` `IdStrada` INT NULL ;
ALTER TABLE `dbcentrirevisioni`.`numero` 
ADD CONSTRAINT `numero_ibfk_1`
  FOREIGN KEY (`IdStrada`)
  REFERENCES `dbcentrirevisioni`.`strada` (`IdStrada`)
  ON DELETE SET NULL
  ON UPDATE CASCADE;

ALTER TABLE `dbcentrirevisioni`.`motorizzazione` 
DROP FOREIGN KEY `motorizzazione_ibfk_1`;
ALTER TABLE `dbcentrirevisioni`.`motorizzazione` 
CHANGE COLUMN `IdNumeroCiv` `IdNumeroCiv` INT NULL ;
ALTER TABLE `dbcentrirevisioni`.`motorizzazione` 
ADD CONSTRAINT `motorizzazione_ibfk_1`
  FOREIGN KEY (`IdNumeroCiv`)
  REFERENCES `dbcentrirevisioni`.`numero` (`IdNumeroCiv`)
  ON DELETE SET NULL
  ON UPDATE CASCADE;
  
  
ALTER TABLE `dbcentrirevisioni`.`assistenzatecnica` 
DROP FOREIGN KEY `assistenzatecnica_ibfk_1`;
ALTER TABLE `dbcentrirevisioni`.`assistenzatecnica` 
CHANGE COLUMN `IdNumeroCiv` `IdNumeroCiv` INT NULL ;
ALTER TABLE `dbcentrirevisioni`.`assistenzatecnica` 
ADD CONSTRAINT `assistenzatecnica_ibfk_1`
  FOREIGN KEY (`IdNumeroCiv`)
  REFERENCES `dbcentrirevisioni`.`numero` (`IdNumeroCiv`)
  ON DELETE SET NULL
  ON UPDATE CASCADE;


ALTER TABLE `dbcentrirevisioni`.`centrirevisioni` 
DROP FOREIGN KEY `centrirevisioni_ibfk_3`;
ALTER TABLE `dbcentrirevisioni`.`centrirevisioni` 
CHANGE COLUMN `IdAssistenza` `IdAssistenza` INT NULL ;
ALTER TABLE `dbcentrirevisioni`.`centrirevisioni` 
ADD CONSTRAINT `centrirevisioni_ibfk_3`
  FOREIGN KEY (`IdAssistenza`)
  REFERENCES `dbcentrirevisioni`.`assistenzatecnica` (`IdAssistenza`)
  ON DELETE SET NULL
  ON UPDATE CASCADE;

ALTER TABLE `dbcentrirevisioni`.`proprietario` 
DROP FOREIGN KEY `proprietario_ibfk_1`;
ALTER TABLE `dbcentrirevisioni`.`proprietario` 
CHANGE COLUMN `IdNumeroCiv` `IdNumeroCiv` INT NULL ;
ALTER TABLE `dbcentrirevisioni`.`proprietario` 
ADD CONSTRAINT `proprietario_ibfk_1`
  FOREIGN KEY (`IdNumeroCiv`)
  REFERENCES `dbcentrirevisioni`.`numero` (`IdNumeroCiv`)
  ON DELETE SET NULL
  ON UPDATE CASCADE;

ALTER TABLE `dbcentrirevisioni`.`veicoli` 
DROP FOREIGN KEY `veicoli_ibfk_1`;
ALTER TABLE `dbcentrirevisioni`.`veicoli` 
CHANGE COLUMN `CodiceFiscale` `CodiceFiscale` CHAR(16) NULL ;
ALTER TABLE `dbcentrirevisioni`.`veicoli` 
ADD CONSTRAINT `veicoli_ibfk_1`
  FOREIGN KEY (`CodiceFiscale`)
  REFERENCES `dbcentrirevisioni`.`proprietario` (`CodiceFiscale`)
  ON DELETE SET NULL
  ON UPDATE CASCADE;

ALTER TABLE `dbcentrirevisioni`.`ripara` 
DROP FOREIGN KEY `ripara_ibfk_2`;
ALTER TABLE `dbcentrirevisioni`.`ripara` 
CHANGE COLUMN `VIN` `VIN` CHAR(17) NULL ;
ALTER TABLE `dbcentrirevisioni`.`ripara` 
ADD CONSTRAINT `ripara_ibfk_2`
  FOREIGN KEY (`VIN`)
  REFERENCES `dbcentrirevisioni`.`veicoli` (`VIN`)
  ON DELETE SET NULL
  ON UPDATE CASCADE;
  
ALTER TABLE `dbcentrirevisioni`.`fornitori` 
DROP FOREIGN KEY `fornitori_ibfk_1`;
ALTER TABLE `dbcentrirevisioni`.`fornitori` 
CHANGE COLUMN `IdNumeroCiv` `IdNumeroCiv` INT NULL ;
ALTER TABLE `dbcentrirevisioni`.`fornitori` 
ADD CONSTRAINT `fornitori_ibfk_1`
  FOREIGN KEY (`IdNumeroCiv`)
  REFERENCES `dbcentrirevisioni`.`numero` (`IdNumeroCiv`)
  ON DELETE SET NULL
  ON UPDATE CASCADE;
  
  ALTER TABLE `dbcentrirevisioni`.`ordine` 
DROP FOREIGN KEY `ordine_ibfk_1`,
DROP FOREIGN KEY `ordine_ibfk_2`;
ALTER TABLE `dbcentrirevisioni`.`ordine` 
CHANGE COLUMN `IdFornitore` `IdFornitore` INT NULL ,
CHANGE COLUMN `IdConcessione` `IdConcessione` CHAR(5) NULL ;
ALTER TABLE `dbcentrirevisioni`.`ordine` 
ADD CONSTRAINT `ordine_ibfk_1`
  FOREIGN KEY (`IdFornitore`)
  REFERENCES `dbcentrirevisioni`.`fornitori` (`IdFornitore`)
  ON DELETE SET NULL
  ON UPDATE CASCADE,
ADD CONSTRAINT `ordine_ibfk_2`
  FOREIGN KEY (`IdConcessione`)
  REFERENCES `dbcentrirevisioni`.`centrirevisioni` (`IdConcessione`)
  ON DELETE SET NULL
  ON UPDATE CASCADE;
  
  ##########################
  ALTER TABLE `dbcentrirevisioni`.`meccanico` 
CHANGE COLUMN `Nome` `Nome` VARCHAR(50) NOT NULL ,
CHANGE COLUMN `Cognome` `Cognome` VARCHAR(50) NOT NULL ;

#####################
ALTER TABLE `dbcentrirevisioni`.`ripara` 
CHANGE COLUMN `IdCollaboratore` `IdCollaboratore` INT NULL ;
ALTER TABLE `dbcentrirevisioni`.`ripara` 
ADD CONSTRAINT `meccanico_ibfk_2`
  FOREIGN KEY (`IdCollaboratore`)
  REFERENCES `dbcentrirevisioni`.`meccanico` (`IdCollaboratore`)
  ON DELETE SET NULL
  ON UPDATE CASCADE;
  
###############################################


ALTER TABLE `dbcentrirevisioni`.`centrirevisioni` 
ADD INDEX `index_name` (`Nome` ASC) VISIBLE;
############################## indici per tabella



ALTER TABLE `dbcentrirevisioni`.`proprietario` 
ADD INDEX `Nominativo_index` (`Nome` ASC, `Cognome` ASC) VISIBLE;
############################## indici per tabella
ALTER TABLE `dbcentrirevisioni`.`prov` 
ADD INDEX `Comune_index` (`Comune` ASC) USING BTREE;
############################## indici per tabella
 ALTER TABLE `dbcentrirevisioni`.`strada` 
ADD INDEX `NomeStrada_Index` (`NomeStrada` ASC) USING BTREE;
############################## aggiunfi primary key ad ispettore
ALTER TABLE `dbcentrirevisioni`.`prov` 
ADD PRIMARY KEY (`Comune`, `Provincia`);



########################################## 
ALTER TABLE `dbcentrirevisioni`.`assistenzatecnica` 
ADD INDEX `Assistenza_index` (`IdAssistenza` ASC) USING BTREE;
############################# Index assistenza tecnica
ALTER TABLE `dbcentrirevisioni`.`centrirevisioni` 
ADD INDEX `index_CR` (`IdConcessione` ASC) USING BTREE,
ADD INDEX `index_ASS` (`IdAssistenza` ASC) USING BTREE;
############################## 
ALTER TABLE `dbcentrirevisioni`.`motorizzazione` 
ADD INDEX `indice_motorizzazione` (`IdMCTC` ASC) USING BTREE;
############################## indici per tabella Moroizzazione
ALTER TABLE `dbcentrirevisioni`.`ispettore` 
#ADD INDEX `IdIspettore` (`IdIspettore` ASC) VISIBLE,
ADD INDEX `IdConcessione` (`IdConcessione` ASC) VISIBLE;
############################## indici per tabella ispettore
ALTER TABLE `dbcentrirevisioni`.`meccanico` 
ADD INDEX `IdConcessione_index` (`IdConcessione` ASC) USING BTREE,
ADD INDEX `Id_collab_index` (`IdCollaboratore` ASC) USING BTREE;
############################## indici per tabella Meccanico
ALTER TABLE `dbcentrirevisioni`.`veicoli` 
ADD INDEX `Veicolo_index` (`targa` ASC) VISIBLE,
ADD INDEX `telaio_index` (`VIN` ASC, `Modello` ASC) VISIBLE;
############################## indici per tabella Veicoli
ALTER TABLE `dbcentrirevisioni`.`fabbricamodello` 
ADD INDEX `fabbricamodello_indice` (`Modello` ASC) USING BTREE;
############################## indici per tabella FabbricaModello
ALTER TABLE `dbcentrirevisioni`.`ripara` 
ADD INDEX `meccanico_index`USING BTREE (`IdCollaboratore` ASC) VISIBLE,
ADD INDEX `veicoli_index` USING BTREE (`VIN`) VISIBLE;
############################## indici per tabella Ripara
ALTER TABLE `dbcentrirevisioni`.`revisioni` 
ADD INDEX `veicoli_index` USING BTREE (`VIN` ASC) VISIBLE,
ADD INDEX `ispettore_index` USING BTREE (`IdIspettore`) VISIBLE;
############################## indici per tabella Revisioni
ALTER TABLE `dbcentrirevisioni`.`proprietario` 
ADD INDEX `Nominativo_index` USING BTREE (`Cognome` ASC) VISIBLE,
ADD INDEX `CF_index` USING BTREE (`CodiceFiscale` ASC) VISIBLE;
############################## indici per tabella Proprietario
ALTER TABLE `dbcentrirevisioni`.`fornitori` 
ADD INDEX `nome_index`  USING BTREE (`Nome` ASC) VISIBLE,
ADD INDEX `Fornitore_index` USING BTREE (`IdForitore` ASC) VISIBLE;
############################## indici per tabella Fornitore
ALTER TABLE `dbcentrirevisioni`.`fornitori` 
ADD COLUMN `PIVA` CHAR(11) NOT NULL,
ADD UNIQUE INDEX `Unicità` (`PIVA` ASC, `Nome` ASC) VISIBLE;
############################## aggiunta colonna e unicità
ALTER TABLE `dbcentrirevisioni`.`ordine` 
ADD INDEX `for_centri_index` USING BTREE (`IdConcessione`) VISIBLE,
ADD INDEX `for_fornitori_index` USING BTREE (`IdFornitore`) VISIBLE;
############################## indici per tabella Ordini
ALTER TABLE `dbcentrirevisioni`.`comune` 
ADD INDEX `indice_nome_comune` (`Comune` ASC) USING BTREE;
############################## indici per tabella Comune
ALTER TABLE `dbcentrirevisioni`.`regione` 
ADD INDEX `Prov_index` (`prov` ASC) VISIBLE;
############################## indici per tabella Regione
ALTER TABLE `dbcentrirevisioni`.`prov` 
ADD INDEX `prov_index` USING BTREE (`prov`) VISIBLE,
ADD INDEX `comune_index` USING BTREE (`Comune`) VISIBLE;
############################## indici per tabella Provincia
ALTER TABLE `dbcentrirevisioni`.`strada` 
ADD INDEX `comune_index` USING BTREE (`Comune`) VISIBLE,
ADD INDEX `strada_index` USING BTREE (`IdStrada`) VISIBLE;
############################## indici per tabella Strada
ALTER TABLE `dbcentrirevisioni`.`numero` 
ADD INDEX `civico_index`  USING BTREE (`IdNumeroCiv` ASC) VISIBLE,
ADD INDEX `strada_index` USING BTREE (`IdStrada`) VISIBLE;
############################## indici per tabella Numero

DELETE FROM `dbcentrirevisioni`.`assistenzatecnica` WHERE (`IdAssistenza` = '1');
UPDATE `dbcentrirevisioni`.`ordine` SET `Quantità` = '15', `Prezzo` = '10', `Descrizione` = 'Igenizzante' WHERE (`IdOrdine` = '4');
UPDATE `dbcentrirevisioni`.`veicoli` SET `Modello` = 'YPSILON' WHERE (`VIN` = 'ZLA31200005244246');
INSERT INTO `dbcentrirevisioni`.`fabbricamodello` (`Modello`, `Fabbrica`) VALUES ('MITO', 'ALFA ROMEO');
UPDATE `dbcentrirevisioni`.`veicoli` SET `Modello` = 'MITO', `AnnoImmatricolazione` = '2013' WHERE (`VIN` = 'ZAR94000007229479');
INSERT INTO `dbcentrirevisioni`.`ripara` (`Tempo`, `Giorno`, `IdCollaboratore`, `VIN`, `DescIntervento`) VALUES ('1', '2019-01-01', '2', 'VF7FCHFXC9A110681', 'Pressione Pneumatici');
UPDATE `dbcentrirevisioni`.`ripara` SET `DescIntervento` = 'Convergenza' WHERE (`IdRiparazione` = '28');
UPDATE `dbcentrirevisioni`.`meccanico` SET `PagaOraria` = '3.50' WHERE (`IdCollaboratore` = '12');
UPDATE `dbcentrirevisioni`.`ripara` SET `DescIntervento` = 'Tagliando' WHERE (`IdRiparazione` = '2');
UPDATE `dbcentrirevisioni`.`ripara` SET `DescIntervento` = 'Cambio Gomme' WHERE (`IdRiparazione` = '3');
UPDATE `dbcentrirevisioni`.`ripara` SET `DescIntervento` = 'Distribuzione' WHERE (`IdRiparazione` = '4');
UPDATE `dbcentrirevisioni`.`ripara` SET `DescIntervento` = 'Tagliando' WHERE (`IdRiparazione` = '6');
UPDATE `dbcentrirevisioni`.`ripara` SET `DescIntervento` = 'Tagliando' WHERE (`IdRiparazione` = '7');
UPDATE `dbcentrirevisioni`.`ripara` SET `DescIntervento` = 'Cambio Frizione' WHERE (`IdRiparazione` = '8');
UPDATE `dbcentrirevisioni`.`ripara` SET `DescIntervento` = 'Intervento su Centralina' WHERE (`IdRiparazione` = '9');
UPDATE `dbcentrirevisioni`.`ripara` SET `DescIntervento` = 'Frizione' WHERE (`IdRiparazione` = '10');
UPDATE `dbcentrirevisioni`.`ripara` SET `DescIntervento` = 'Quadro Strumenti' WHERE (`IdRiparazione` = '11');
UPDATE `dbcentrirevisioni`.`ripara` SET `DescIntervento` = 'Tagliando' WHERE (`IdRiparazione` = '12');
UPDATE `dbcentrirevisioni`.`ripara` SET `DescIntervento` = 'Impianto Frenante' WHERE (`IdRiparazione` = '14');
UPDATE `dbcentrirevisioni`.`ripara` SET `DescIntervento` = 'Controlli generici' WHERE (`IdRiparazione` = '15');
UPDATE `dbcentrirevisioni`.`ripara` SET `DescIntervento` = 'Controlli generici' WHERE (`IdRiparazione` = '16');
UPDATE `dbcentrirevisioni`.`ripara` SET `DescIntervento` = 'Controlli generici' WHERE (`IdRiparazione` = '17');

 