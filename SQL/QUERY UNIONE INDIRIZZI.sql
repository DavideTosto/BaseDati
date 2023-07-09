SELECT * FROM dbcentrirevisioni.`comuni-localita-cap-italia`;

################ 1° qry
INSERT INTO `dbcentrirevisioni`.`prov` (`Comune`,`Provincia`, `Prov`) SELECT 
			DISTINCT `comuni-localita-cap-italia`.COMUNE,  `provincia regioni`.`Provincia`, `comunicr`.`Siglaprov`
			FROM dbcentrirevisioni.comunicr
			INNER JOIN
			dbcentrirevisioni.`provincia regioni` on `provincia regioni`.`siglaprovincia` = `comunicr`.`Siglaprov` 
            INNER JOIN
            dbcentrirevisioni.`comuni-localita-cap-italia` on `comunicr`.`CAP` = `comuni-localita-cap-italia`.`CAP`
            order by Provincia;
            
##################### 2° qry
INSERT INTO `dbcentrirevisioni`.`Comune` (`CAP`,`COMUNE`) 
			SELECT DISTINCT `comuni-localita-cap-italia`.`CAP`, `comuni-localita-cap-italia`.COMUNE
            FROM  dbcentrirevisioni.`comuni-localita-cap-italia`
            ORDER BY COMUNE;
			
####################### 3° qry 
INSERT INTO dbcentrirevisioni.strada (`NomeStrada`,`Comune`) 
		SELECT DISTINCT  `stradedaexcel`.nomestrada, `comune`.Comune
		FROM dbcentrirevisioni.`stradedaexcel`
		INNER JOIN
		dbcentrirevisioni.`comune` on `comune`.`comune` = `stradedaexcel`.`comune` ;

######################## 4° qry      
INSERT INTO dbcentrirevisioni.TipoStrada (`Tipostrada`,`NomeStrada`) 
		SELECT `stradedaexcel`.`TipoStrada`, `stradedaexcel`.`NomeStrada`
        FROM dbcentrirevisioni.`stradedaexcel`
		INNER JOIN
		dbcentrirevisioni.`comune` on `comune`.`comune` = `stradedaexcel`.`comune`;
        
######################## 5°
 INSERT INTO dbcentrirevisioni.Numero (`IdStrada`,`Numero`) 
		SELECT DISTINCT `strada`.`IdStrada`, `stradedaexcel`.`Numero`
		FROM dbcentrirevisioni.`stradedaexcel`
		INNER JOIN
        dbcentrirevisioni.`strada` on `strada`.`NomeStrada` = `stradedaexcel`.`NomeStrada`;
        
######################## 6°
INSERT INTO dbcentrirevisioni.Motorizzazione (`Nome`,`NomeStrada`,`Numero`,`CAP`) 
		SELECT `stradedaexcel`.`NomeStrada`, `stradedaexcel`.`Numero`
        FROM dbcentrirevisioni.`stradedaexcel`
		INNER JOIN
		dbcentrirevisioni.`comune` on `comune`.`comune` = `stradedaexcel`.`comune`;


######################  Prova query indirizzi  #############################
SELECT Comune.Comune, PROV.Provincia, Strada.NomeStrada, Strada.IdStrada
FROM dbcentrirevisioni.`Comune`
INNER JOIN dbcentrirevisioni.`PROV` on `comune`.`comune` = `PROV`.`comune`
INNER JOIN dbcentrirevisioni.`Strada` on `comune`.`comune` = `Strada`.`comune`
WHERE `comune`.`comune` = 'PACECO';

INSERT INTO dbcentrirevisioni.numero (`IdStrada`,`numero`) VALUES ('4161','36');
# 65547

