# installare modulo interfaccia Db in mysql
# curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
# python get-pip.py
# pip install mysql-connector-python
# pip install pymysql  
# pip install sqlalchemy
# pip install pandas



from sqlalchemy import create_engine, Table, Column, Integer, String, MetaData
from sqlalchemy.ext.declarative import declarative_base
import sys
import mysql.connector

# CODICE ESEMPIO DEL DIALECT MYSQL CONNECTOR
db = mysql.connector.connect(
    host = "localhost",
    user = "root",
    password = "D4v1d3",
    database = "dbcentrirevisioni"
 )

cursor = db.cursor()
cursor.execute("Show tables;")

print(cursor.fetchall())

# OGETTO PER LA COSTRUZIONE DEL DATABASES
engine = create_engine('mysql+pymysql://root:D4v1d3@127.0.0.1:3306/dbcentrirevisioni',  isolation_level='READ COMMITTED') # READ COMMITTED, mysqlconnector ; AUTOCOMMIT,pymysql 
#Ritorna l'oggetto di connessione
conn = engine.connect()

# RACCOLTA DI DEFINIZIONI DI TABELLE
metadata = MetaData()

# riflette il database e aggiorna il metadata
metadata.reflect(engine)

# Trasazioni in modifica database
def transexc (entry):
    trans = conn.begin()
    # Provo ad eseguire la query di inserimento
    try:
        result = conn.execute(entry)
        trans.commit()
        # stampa il numero di righe inserite
        print(result.rowcount)
        return result
    except:
        # Se ci sono eccezioni, annulla la transazione e le modifiche, mostra sul terminale l'errore
        trans.rollback()
        e = sys.exc_info()
        print("C'è stato un errore ")
        print(e)


def getTabella(nomeTabella):
    # Lista contenente i nomi delle tabelle
    tabelledb = list(metadata.tables.keys())
    # Raccogli ogetti Tabelle
    Tabelle = []
    for i in range(len(tabelledb)):
        Tabelle = Tabelle + [Table(tabelledb[i], metadata, autoload=True)]

    # Se c'è una corrispondenza tra la stringa inviata a questa funzione e l'elenco delle tabelle
    # ne ritona la tabella associata atrimete esce con un codice errore
    i = 0
    for item in tabelledb:
        if ( nomeTabella == item ):
            break
        i += 1
    else:
        print("Nessuna tabella con questo nome")
        i = "NULL"

    if (i=="NULL"):
        pass
    else:
        return ( Tabelle[i] )
    
# Prendo la tabella comune
comune = getTabella('comune')
# Inserisci nella tabella comune
ins = comune.insert().values(CAP='10001', Comune='ZIBBIBBO')
transexc(ins)
# Aggiorna nella tabella comune
upd = comune.update().where( comune.c.Comune == 'ZIBBIBBO').values(CAP ='10009', Comune='ZURIGO')
transexc(upd)
# Rimuovi dalla tabella comune 
rem = comune.delete().where(comune.c.Comune == 'ZIBBIBBO')
rem = comune.delete().where(comune.c.Comune == 'ZURIGO')
transexc(rem)


# Prendo la tabella Ispettori
ispettori = getTabella('ispettore')


# Lista contenente i nomi delle tabelle
tabelledb = list(metadata.tables.keys())
for item in tabelledb:
    print(item)



columns = getTabelle('comune').c
for i in range(len(columns)):
    print(columns[i])

comune = Table( tabelledb[3], metadata, autoload=True)
columns = comune.c
for i in range(len(columns)):
    print(columns[i])



s = comune.select()
result = conn.execute(s)
conn.commit()

for row in result:
    print(row)


# stampa le chiavi primarie delle righe inserite
print(result.inserted_primary_key)




# Come CREARE UNA TABELLA 
students = Table( 'Tabella', metadata, Column('id', Integer, primary_key = True), Column('attributo1', String(length=40)), Column('Attributo2', String(length=40)), )
metadata.reflect(engine)