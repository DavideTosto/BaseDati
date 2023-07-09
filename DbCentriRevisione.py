#
### FASE IMPORT
#
#
from sqlalchemy import Column, Integer, String, Table, MetaData, UniqueConstraint, ForeignKey, Index, FLOAT, Date
from sqlalchemy import create_engine, func
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, relationship
from sqlalchemy import and_, or_
import sys
import random
from datetime import date

def rndstr():
     return random.randint(0, 65000)

def rndciv():
     return random.randint(0, 1000)

def trycommit():
    try:
        session.commit()
    except:
        session.rollback()
        e = sys.exc_info()
        print("C'è stato un errore ")
        print(e)

def autoincrement():
     try:
          trycommit()
          query = session.query(Strada).order_by(Strada.IdStrada.desc()).first().IdStrada + 1
          return query
     except:
          session.rollback()
          e = sys.exc_info()
          print("C'è stato un errore ")
          print(e)
          

### SET UP INIZIALE
engine = create_engine('mysql+pymysql://root:D4v1d3@127.0.0.1:3306/dbcentrirevisioni',  isolation_level='READ COMMITTED') 
#Ritorna l'oggetto di connessione
conn = engine.connect()

metadata = MetaData()
metadata.reflect(engine)


Session = sessionmaker(bind = engine, autocommit=False)
session = Session()

Base = declarative_base()

### DICHIARAZIONE TABELLE
    
class Strada(Base):
     __tablename__= 'strada'
     IdStrada = Column(Integer, primary_key=True, nullable=False, autoincrement=True)
     NomeStrada = Column(String(length=100))
     Comune = Column(String(length=50), ForeignKey('comune.Comune') ,nullable=False)
     # Aggiungi indice
     Index("NomeStrada_Index",NomeStrada )
     # Relazioni
     comune = relationship("Comune", foreign_keys=[Comune], back_populates="strada" )
     civico = relationship("Numero", backref="strada")

class Assistenzatecnica(Base):
     __tablename__= 'assistenzatecnica'
     IdAssistenza = Column(Integer, primary_key=True, nullable=False, autoincrement=True, unique=True)
     Nome = Column(String(length=100),nullable=False )
     IdNumeroCiv =Column(Integer, ForeignKey('numero.IdNumeroCiv'))
     telefono =  Column(String(length=10), unique=True)
     # Aggiunge indice
     Index('index_name', Nome)
     # Relazioni
     civico = relationship("Numero", back_populates="civicolink")
          
class Ordine(Base):
     __tablename__= 'ordine'
     IdOrdine = Column(Integer, primary_key=True, nullable=False, autoincrement=True)
     Quantità = Column(Integer, nullable=False)
     Prezzo = Column(FLOAT,nullable=False )
     Descrizione = Column(String(length=100), nullable=False)
     IdFornitore = Column(Integer, ForeignKey('fornitori.IdFornitore'))
     IdConcessione = Column(String(5), ForeignKey('protocolli.IdConcessione'))
     # # Relazioni
     fornito = relationship("Fornitori", foreign_keys=[IdFornitore] , back_populates="fornisce")
     richiesto = relationship("Protocolli", foreign_keys=[IdConcessione], back_populates="richiede")

class Fornitori(Base):
     __tablename__= 'fornitori'
     IdFornitore = Column(Integer, nullable=False, autoincrement=True, primary_key=True)
     Nome = Column(String(length=25), nullable=False )
     IdNumeroCiv =Column(Integer, ForeignKey('numero.IdNumeroCiv'))
     Telefono = Column(String(length=10), unique=True)
     # Aggiungi indice
     Index('nome_index', Nome)
     # # Relazioni
     fornisce = relationship("Ordine", back_populates="fornito")
     civico = relationship("Numero", back_populates="civicolink2")

class Revisioni(Base):
     __tablename__ = 'revisioni'
     IdRevisione = Column(Integer, primary_key=True, nullable=False, autoincrement=True)
     Esito = Column(String(10))
     Prezzo = Column(FLOAT)
     Giorno = Column() # data
     IdIspettore = Column(Integer, ForeignKey('protocolli.IdIspettore'), nullable=False)
     VIN = Column(String(17), ForeignKey('veicoli.VIN') , nullable=False)
     # # Relazioni
     ispettore = relationship("Protocolli", foreign_keys=[IdIspettore], back_populates="revisioni")
     veicolorevisione = relationship("Veicoli", foreign_keys=[VIN], back_populates="revisioni")

class Ispettore(Base):
     __tablename__= 'ispettore'
     IdIspettore = Column(Integer,ForeignKey("protocolli.IdIspettore") , nullable=False, primary_key=True)
     Nome = Column(String(length=50), nullable=False)
     Cognome = Column(String(length=50), nullable=False)
     IdConcessione = Column(String(length=5), ForeignKey('protocolli.IdConcessione')) #aggiustare
     # Aggiungi indice
     Index('indice_nominativo', Nome, Cognome)
     # # Relazioni
     autorizzazione = relationship("Protocolli", foreign_keys=[IdIspettore] , back_populates="ispettori")
     lavorain = relationship("Protocolli", foreign_keys=[IdConcessione], back_populates="concess")

class Motorizzazione(Base):   
     __tablename__= 'motorizzazione'
     IdMCTC =  Column(Integer, primary_key=True, nullable=False, autoincrement=True)
     Nome = Column(String(length=50), nullable=False)
     IdNumeroCiv =Column(Integer, ForeignKey('numero.IdNumeroCiv'))
     telefono = Column(String(length=10), unique=True)
     UniqueConstraint('Nome')
     # Aggiungi indice
     Index('indice_motorizzazione', IdMCTC )
     # Relazioni
     atti = relationship("Protocolli", back_populates="protocollo")
     civico = relationship("Numero", back_populates="civicolink4")

class Proprietario(Base):
     __tablename__= 'proprietario'
     CodiceFiscale = Column(String(length=16), primary_key=True, nullable=False)
     Nome = Column(String(length=100), nullable=False)
     Cognome = Column(String(length=100), nullable=False)
     IdNumeroCiv =Column(Integer, ForeignKey('numero.IdNumeroCiv'))
     #Aggiungi indice
     Index("Nominativo_index", Nome, Cognome)
     # # Relazioni
     proprieta = relationship("Veicoli", back_populates="proprietario", cascade = "all, delete-orphan")
     civico = relationship("Numero", back_populates="civicolink3")

class Centrirevisioni(Base):
     __tablename__= 'centrirevisioni'
     IdConcessione =  Column(String(length=5), ForeignKey('protocolli.IdConcessione') , primary_key=True, nullable=False)
     Nome =  Column(String(length=200), nullable=False )
     IdNumeroCiv =Column(Integer, ForeignKey('numero.IdNumeroCiv'))
     IdAssistenza = Column(Integer, ForeignKey('assistenzatecnica.IdAssistenza'))
     # # Relazioni:
     assistenze =  relationship("Assistenzatecnica", foreign_keys=[IdAssistenza] ,back_populates="centrirevisioni")
     concessione = relationship("Protocolli", foreign_keys=[IdConcessione], back_populates="CentriRev")
     meccanico = relationship("Meccanico", back_populates="centro")

     civico = relationship("Numero", back_populates="civicolink1")
    
     #Aggiungi indice
     Index('index_name', Nome)

class Protocolli(Base):
     __tablename__= 'protocolli'
     IdProtocolli =  Column(Integer, primary_key=True, nullable=False, autoincrement=True)
     Tipo = Column(String(length=30))
     IdIspettore = Column(Integer)
     IdConcessione = Column(String(length=5))
     Giorno = Column(Date) 
     IdMCTC = Column(Integer, ForeignKey('motorizzazione.IdMCTC'), nullable=False)
     #Aggiungi indice
     Index(IdMCTC)
     # # Relazioni:
     protocollo = relationship("Motorizzazione", foreign_keys=IdMCTC, back_populates="atti")
     CentriRev = relationship("Centrirevisioni", back_populates="concessione")
     ispettori = relationship("Ispettore", foreign_keys=[Ispettore.IdIspettore], back_populates="autorizzazione")
     concess = relationship("Ispettore",foreign_keys=[Ispettore.IdConcessione], back_populates="lavorain")
     revisioni = relationship("Revisioni", foreign_keys=[Revisioni.IdIspettore], back_populates="ispettore")
     richiede = relationship("Ordine", foreign_keys=[Ordine.IdConcessione], back_populates="richiesto")

class Meccanico(Base):
     __tablename__= 'meccanico'
     IdCollaboratore = Column(Integer, primary_key=True, nullable=False, autoincrement=True)
     Nome = Column(String(length=50), nullable=False)
     Cognome = Column(String(length=50), nullable=False)
     Ore = Column(Integer)
     PagaOraria = Column(FLOAT, nullable=False)
     Specializzazione = Column(String(length=50))
     IdConcessione = Column(String(length=5), ForeignKey('centrirevisioni.IdConcessione'))
     # Indici:
     Index("Nominativo_index", Nome, Cognome)
     # Relazioni
     centro = relationship("Centrirevisioni", foreign_keys=IdConcessione, back_populates="meccanico")
     veicolorip = relationship("Veicoli", secondary="ripara",overlaps="meccanico,ripara", backref="meccanico")

class Comune(Base):
    __tablename__ = 'comune'
    CAP = Column(String(length=5), nullable=False)
    Comune = Column(String(length=50), primary_key=True, nullable=False)
    #Aggiungi indice
    Index('index_name_comune', Comune)
    strada = relationship("Strada", back_populates="comune")

class Prov(Base):
     __tablename__= 'prov'
     Comune = Column(String(length=50), ForeignKey("comune.Comune") ,primary_key=True, nullable=False)
     Provincia = Column(String(length=50), primary_key=True, nullable=False)
     prov = Column(String(length=2), ForeignKey("regione.prov"), nullable=False)
     # Aggiungi indice
     Index('Comune_index', Comune)
     # Relazioni
     comune = relationship("Comune", backref="prov")

class Regione(Base):
     __tablename__= 'regione'
     prov = Column(String(length=2), primary_key=True, nullable=False)
     Regione = Column(String(length=30), nullable=False)
     # Aggiungi indice
     Index("Provincia_index", prov)
     # Relazioni
     provincia = relationship("Prov", backref="regione")

class Ripara(Base):
     __tablename__ = 'ripara'
     IdRiparazione = Column(Integer, primary_key=True, nullable=False, autoincrement=True)
     Tempo = Column(FLOAT)
     Giorno = Column(Date) 
     DescIntervento = Column(String(length=200))
     IdCollaboratore = Column(Integer, ForeignKey('meccanico.IdCollaboratore'))
     VIN = Column(String(17), ForeignKey('veicoli.VIN'))
     
class Veicoli(Base):
     __tablename__= 'veicoli'
     VIN = Column(String(length=17), primary_key=True, nullable=False)
     targa = Column(String(length=7), unique=True)
     Modello = Column(String(length=50), ForeignKey("fabbricamodello.Modello"))
     AnnoImmatricolazione = Column(Integer)
     CodiceFiscale = Column(String(length=16), ForeignKey("proprietario.CodiceFiscale"))
     UniqueConstraint(VIN, targa)  
     # Aggiungi indice
     Index("Veicolo_index",targa)
     # # Relazioni:
     revisioni = relationship("Revisioni", back_populates="veicolorevisione")
     proprietario = relationship("Proprietario", foreign_keys=[CodiceFiscale] ,back_populates="proprieta")
     riparato = relationship("Meccanico", secondary='ripara', overlaps="meccanico,ripara", backref="veicoli")
     fabbricaveicolo = relationship("Fabbricamodello", back_populates="modelloveicolo")

class Fabbricamodello(Base):
      __tablename__= 'fabbricamodello'
      Modello = Column(String(length=100), primary_key=True, nullable=False)
      Fabbrica = Column(String(length=100), nullable=False)
      Index('fabbricamodello_indice', Modello)
      # # Relazioni
      modelloveicolo = relationship("Veicoli", foreign_keys=[Veicoli.Modello], back_populates="fabbricaveicolo")

class Numero(Base):
     __tablename__= 'numero'
     IdNumeroCiv = Column(Integer, primary_key=True, nullable=False, autoincrement=True) 
     IdStrada = Column(Integer, ForeignKey('strada.IdStrada'))
     Numero = Column(Integer)
     # Relazioni
     civicolink = relationship("Assistenzatecnica", foreign_keys=[Assistenzatecnica.IdNumeroCiv], back_populates="civico")
     civicolink1 = relationship("Centrirevisioni", foreign_keys=[Centrirevisioni.IdNumeroCiv], back_populates="civico")
     civicolink2 = relationship("Fornitori", foreign_keys=[Fornitori.IdNumeroCiv], back_populates="civico")
     civicolink3 = relationship("Proprietario", foreign_keys=[Proprietario.IdNumeroCiv], back_populates="civico")
     civicolink4 = relationship("Motorizzazione", foreign_keys=[Motorizzazione.IdNumeroCiv], back_populates="civico")

Assistenzatecnica.centrirevisioni = relationship("Centrirevisioni", order_by=Centrirevisioni.IdAssistenza, back_populates="assistenze" )

Base.metadata.create_all(engine)

# Aggiungi Concessione e il nome del centro revisioni (singolarmente)
P1 = Protocolli(Tipo = 'CONCESSIONE', IdConcessione = 'TPAH0', Giorno = '2020-01-01', IdMCTC = 1)
P1.CentriRev = [Centrirevisioni(IdConcessione = 'TPAH0', Nome = 'CENTRO REVISIONI URSO E COSTA', IdNumeroCiv = 65546)]
session.add(P1)
trycommit()

P1 = Protocolli(Tipo = 'CONCESSIONE', IdConcessione = 'TPAD8', Giorno = '2020-01-01', IdMCTC = 1)
P1.CentriRev =[Centrirevisioni(IdConcessione = 'TPAD8', Nome = 'ROCCO AIUTO', IdNumeroCiv = 65546)]
session.add(P1)
trycommit()

#Aggiungi Concessione e il nome del centro revisioni (insieme)
rows = [
     Protocolli(Tipo = 'CONCESSIONE', IdConcessione = 'CTAF1', Giorno = '2014-02-06', IdMCTC = 2,
                CentriRev = [Centrirevisioni(IdConcessione = 'CTAF1', Nome = 'CRUSL', IdNumeroCiv = 57)]),  
     Protocolli(Tipo = 'CONCESSIONE', IdConcessione = 'CTIC5', Giorno = '2002-02-02', IdMCTC = 2, 
                CentriRev = [Centrirevisioni(IdConcessione = 'CTIC5', Nome = 'SBUCAB', IdNumeroCiv = 69)]),
 ]
session.add_all(rows)
trycommit()

# Eliminare tuple dalla tabella Assistenza Tecnica in base al valore della chiave primaria
query = session.query(Assistenzatecnica).filter(Assistenzatecnica.IdAssistenza == 1)
data = query.all()
print(data)
for item in range(len(data)):
            session.delete(data[item])
trycommit()

# Aggiumta una nuova tupla nella tabella Assistenza Tecnica
A1 = Assistenzatecnica(IdAssistenza = 1 , Nome="TECNOSERVICE",IdNumeroCiv="65543", telefono='345621302' )
session.add(A1)
trycommit()

# inserisce nuove tuple in nella tabella Motorizzazione
M1 = Motorizzazione(IdMCTC =6, Nome = 'MCTC DI ROMA', telefono = '3109544632')
# usa la relazione Protocolli per aggiungere delle tuple nella tabella Protocolli
M1.atti = [Protocolli(Tipo = 'CONCESSIONE', IdConcessione = 'RMSH2', Giorno = '2023-05-01', IdMCTC = 6)]
# usa la relazione CentriRev per aggiungere delle tuple nella tabella Centrirevisioni
M1.atti[0].CentriRev = [Centrirevisioni(IdConcessione = 'RMSH2', Nome = 'E MOJRREV', IdNumeroCiv = 1742)]
session.add(M1)
trycommit() 

# IN_OGG_rel = inserimento oggetti in relazione
# IN_OGG_rel: inseriti i dati in Protocolli inserisce i dati in ispettori
AUT1 = Protocolli(Tipo = 'AUTORIZZAZIONE', IdIspettore='9', Giorno = '1987-07-06', IdMCTC = 3)
AUT1.ispettori = [Ispettore(IdIspettore = 9, Nome = 'Davide', Cognome = 'Tosto')]
session.add(AUT1)
trycommit() 

# Inseriti i dati in Revisioni 
REV = Revisioni(IdIspettore = 9, Esito='POSITIVO', Prezzo=66.88, Giorno='2020-03-04', VIN='WVWZZZ1KZAP056080' )
session.add(REV)
trycommit() 

# IN_OGG_rel: inseriti i dati in Veicoli inserisce i dati in Revisioni
VEI = Veicoli(VIN='ZFA19900046832155', targa='AB123CD', Modello='PUNTO', AnnoImmatricolazione=2010, CodiceFiscale='TSTDVD96E01D423P')
VEI.revisioni = [Revisioni(IdIspettore = 9, Esito='POSITIVO', Prezzo=66.88, Giorno='1998-03-04', VIN='ZFA19900046832155'),
                 Revisioni(IdIspettore = 9, Esito='POSITIVO', Prezzo=66.88, Giorno='2000-03-04', VIN='ZFA19900046832155'),
                 Revisioni(IdIspettore = 9, Esito='POSITIVO', Prezzo=66.88, Giorno='2002-03-04', VIN='ZFA19900046832155'),
                 Revisioni(IdIspettore = 9, Esito='POSITIVO', Prezzo=66.88, Giorno='2004-03-04', VIN='ZFA19900046832155')]
session.add(VEI)
trycommit()

# IN_OGG_rel: inseriti i dati in Proprietario inserisce i dati in Veicoli
PROP = Proprietario(CodiceFiscale='MNNPRC93E41E310W', Nome='PATRICIA ALEJANDRA', Cognome='MONNO')
PROP.proprieta = [Veicoli(VIN='ZFA19900014532689', targa='EF456GH', Modello='PUNTO', AnnoImmatricolazione=2000, CodiceFiscale='MNNPRC93E41E310W'),
                  Veicoli(VIN='ZFA19900028534961', targa='IL789MN', Modello='PUNTO', AnnoImmatricolazione=1997, CodiceFiscale='MNNPRC93E41E310W'),
                  Veicoli(VIN='ZFA19900064579135', targa='OP101QR', Modello='PUNTO', AnnoImmatricolazione=2002, CodiceFiscale='MNNPRC93E41E310W'),
                  Veicoli(VIN='ZFA19900067358201', targa='US112TU', Modello='PUNTO', AnnoImmatricolazione=2004, CodiceFiscale='MNNPRC93E41E310W')]
session.add(PROP)
trycommit()

# IN_OGG_rel: inseriti i dati in Veicoli inserisce i dati in Proprietario
VEI = Veicoli(VIN='ZFA19900012409860', targa='AZ195BY', Modello='PUNTO', AnnoImmatricolazione=1998, CodiceFiscale='GRSDLD39S01I925W')
VEI.proprietario = Proprietario(CodiceFiscale='GRSDLD39S01I925W', Nome='DANILO DOMENICO', Cognome='GROSHEV')
session.add(VEI)
trycommit()

# IN_OGG_rel: inseriti i dati in Foritori inserisce i dati in Ordine
FOR = Fornitori(Nome = 'LAUTOR', Telefono = '3279465130')
FOR.fornisce = [ Ordine( Quantità = 10, Prezzo = 0.20, Descrizione = 'Guarnizioni in Gomma', IdFornitore = 1),
                 Ordine( Quantità = 1, Prezzo = 10.40, Descrizione = 'Filtro olio', IdFornitore = 3),]
session.add(FOR)
trycommit()

# IN_OGG_rel: esegita la query su Protocolli inserisce i dati in Ordine
# Ad ogni IdConcessione in Protocolli corrisponde un solo centro revisoni
# dunque tramite questa query riusciamo a inserire nel centro revisioni corrispondente
# i ordini da effettuare
AZD = session.query(Protocolli).filter(Protocolli.IdConcessione == 'TPAH0').first()
AZD.richiede = [Ordine( Quantità = 10, Prezzo = 0.20, Descrizione = 'Guarnizioni in Gomma', IdFornitore = 1)]
session.add(AZD)
trycommit()

# IN_OGG_rel: inseriti i dati in Ordine inserisce i dati del richiedente (CentroRevisioni = Protocolli(IdConcessione))
# e del fornitore
rows = [
     Ordine( Quantità = 5, Prezzo = 20.5, Descrizione = 'Biellette', 
             fornito = Fornitori(Nome = 'RicambA', Telefono = '3579461382'),
             richiesto =(session.query(Protocolli).filter(Protocolli.IdConcessione == 'TPAH0').first()))
]
session.add_all(rows)
trycommit()

# IN_OGG_rel: eseugita la query su Meccanico inserisce i dati in Centrirevisioni
MEC = session.query(Meccanico).filter(Meccanico.IdCollaboratore == 1).first()
MEC.centro = Centrirevisioni( concessione=Protocolli(IdConcessione = 'TPAB6', Giorno = '1993-06-12', IdMCTC = 1, Tipo = 'CONCESSIONE'),
                              Nome = 'MAIORANA', IdNumeroCiv = 567)
session.add(MEC)
trycommit()

# Inserisce i dati in Meccanico
row = [
     Meccanico( Nome = 'Silvio', Cognome = 'Bono', Specializzazione = 'Elettrauto', Ore=8, PagaOraria=10.5, IdConcessione='TPAB6'),
     Meccanico( Nome = 'Filippo', Cognome = 'Campo', Specializzazione = 'Lattoniere', Ore=7, PagaOraria=7.5, IdConcessione='TPAD8'),
     Meccanico( Nome = 'Giovanni', Cognome = 'Cavallaro', Specializzazione = 'Meccanico', Ore=8, PagaOraria=9.5, IdConcessione='TPAI6'),
     Meccanico( Nome = 'Giuseppe', Cognome = 'Renda', Specializzazione = 'Elettrauto', Ore=11, PagaOraria=11.5, IdConcessione='CTAF1')
]
session.add_all(row)
trycommit()

# La seguente query su Fabbricamodello restituisce tutti i modelli di auto prodotti dalla FIAT
# e li stampa a video
FAB = session.query(Fabbricamodello).filter(Fabbricamodello.Fabbrica == 'FIAT').all()
for i in FAB:
    print((i.Fabbrica)+" "+(i.Modello))

# La seguente query restituisce le Riparazioni effettuate su auto FIAT
# e le stampa a video
RIP = session.query(Fabbricamodello, Veicoli, Ripara).filter(and_(
     (Fabbricamodello.Modello == Veicoli.Modello),
     (Fabbricamodello.Fabbrica == "FIAT"),
     (Veicoli.VIN == Ripara.VIN))).all()
for i in RIP:
     if (i._data[2].DescIntervento != None):
          print(i._data[1].Modello+" "+i._data[1].VIN+" "+i._data[2].DescIntervento)
     else:
          print(i._data[1].Modello+" "+i._data[1].VIN+" Descrizione non disponibile")

# Crea un nuovo comune, una nuova provincia e una nuova regione
COM = [   Regione(prov = 'AL', Regione = 'ABBIA'), 
          Prov(Comune= 'ABIANTO', prov = 'AL', Provincia = 'ALIFORNIA'), 
          Comune(Comune = 'ABIANGO', CAP = 10002) ]
session.add_all(COM)
trycommit()

# IN_OGG_rel: Aggiunta di nuove tuple in Numero(civico), Strada, Comune, Prov e Regione
NEW = Regione(Regione = 'ZIGNA', prov = 'ZZ',
          provincia= [Prov(Comune= 'ZONDRIO', prov = 'ZZ', Provincia = 'ZANZIA', 
                            comune = Comune(Comune = 'ZONDRIO', CAP = 10002,
                                            strada = [Strada(NomeStrada = "Via Corte dei Conti", IdStrada = autoincrement(),
                                                      civico = [Numero( Numero = 1, IdStrada = autoincrement() )] )],
                            ))], )
session.add(NEW)
trycommit()

# La seguente query restituisce il comune, la provincia e la regione di ZONDRIO
query = session.query(Comune, Prov, Regione).filter(and_(
     (Comune.Comune == Prov.Comune),
     (Prov.prov == Regione.prov),
     (Comune.Comune == 'ZONDRIO'))).all()
for i in query:
     print("Comune: "+i._data[0].Comune+" - Provincia: "+i._data[1].prov+" - Regione: "+i._data[2].Regione)

# Aggiunta di dei record indicanti l'indirzzo in AssistenzaTecnica(IN MODO CASUALE)
for i in session.query(Assistenzatecnica).all():
     if (i.IdNumeroCiv == None):
          i.IdNumeroCiv = random.randint(1, 65000)
          session.add(i)
          trycommit()

################# Aggiunta di oggetti in relazione da:

# Assistenza Tecnica aggiungo un nuovo indirizzo
STR = session.query(Strada).filter(Strada.NomeStrada == "Via Corte dei Conti").first()
ASS = Assistenzatecnica( Nome="Ravaglioli", telefono="3216547895", 
                         civico = Numero ( IdStrada=STR.IdStrada, Numero=2 ) )
session.add(ASS)
trycommit()

# Protocolli ( Centri revisioni o Ispettore ) aggiungo un nuovo indirizzo
STR = session.query(Strada).filter(Strada.NomeStrada == "Via Corte dei Conti").first()
C1 = Protocolli(Tipo = 'CONCESSIONE', IdConcessione = 'CTAF2', Giorno = '2021-07-05', IdMCTC = 2)
C1.CentriRev =[Centrirevisioni(IdConcessione = 'CTAF2', Nome = 'SBUCAB', 
                               civico = Numero ( IdStrada=STR.IdStrada, Numero=rndciv() ))]
session.add(C1)
trycommit()

# Fornitori aggiungo un nuovo indirizzo
STR = session.query(Strada).filter(Strada.NomeStrada == "VIA TRIESTE").first()
CFR  = Fornitori(Nome = 'UTOROTU', Telefono = '3461200258',
                    civico = Numero ( IdStrada=STR.IdStrada, Numero=rndciv() ))
session.add(CFR)
trycommit()

#  Veicoli aggiungo un Proprietario che a sua volta aggiunge un nuovo indirizzo
STR = session.query(Strada, Comune).filter(and_(Strada.NomeStrada == "VIA DELLA RESISTENZA"),
                                             (Comune.Comune == "FALERONE")).first()
VEI = Veicoli(VIN='ZFA19900056321489', targa='DF111FD', Modello='PUNTO', AnnoImmatricolazione=2006, 
              proprietario = Proprietario(CodiceFiscale='DRNLRT19L01F126N', Nome='ALBERT AZUAYI', Cognome='DI RENDE', 
                                civico = Numero ( IdStrada=STR._data[0].IdStrada, Numero=rndciv())))
session.add(VEI)
trycommit()

# Motorizzazione aggiungo un nuovo indirizzo
STR =  session.query(Strada, Comune).filter(and_(Strada.NomeStrada == "VIA DIOCLEZIANO"),
                                              (Comune.Comune == "NAPOLI")).first()
M1 = Motorizzazione( Nome = 'MCTC DI NAPOLI', telefono = '3894560011',
                     civico = Numero ( IdStrada=STR._data[0].IdStrada, Numero=rndciv()))      
session.add(M1)
trycommit()

# Update riga
session.query(Comune).filter(Comune.Comune == 'ZONDRIO').update({Comune.Comune: 'ZURICO'})
session.query(Comune).filter(Comune.Comune == 'ZURICO').update({Comune.Comune: 'ZONDRIO'})
session.query(Veicoli).filter(Veicoli.VIN == 'ZFA19900056321489').update({Veicoli.VIN: 'ZFA19900056321490', Veicoli.Modello: 'YPSILON', Veicoli.AnnoImmatricolazione: 2007})
session.query(Revisioni).filter(Revisioni.IdRevisione == 1).update({Revisioni.Esito: 'REGOLARE'})
session.query(Ispettore).filter(Ispettore.IdIspettore == 2).update({Ispettore.Nome: 'GIOVANNI', Ispettore.Cognome: 'ROSSI'})
session.query(Protocolli).filter(Protocolli.IdProtocolli == 2).update({Protocolli.IdMCTC: 2})
session.query(Fornitori).filter(Fornitori.IdFornitore == 2).update({Fornitori.Telefono: '3461200268'})
session.query(Assistenzatecnica).filter(Assistenzatecnica.IdAssistenza == 2).update({Assistenzatecnica.Nome: 'Ravaglioli', Assistenzatecnica.telefono: '3216547795'})
trycommit()




#elimina riga
query = session.query(Comune).filter( and_ (Comune.CAP == '10002', Comune.Comune == 'ZONDRIO'))
data = query.all()
for item in range(len(data)):
            session.delete(data[item])
            print(data[item].Comune)

######################################## !!!!!! Query !!!!!! ########################################

# Crea prima query semplice
query = session.query(Comune,).filter(Comune.Comune == 'PACECO')
rows = query.all()
# Visualizza la query
for item in range(len(rows)):
    print(rows[item].Comune, rows[item].CAP)


# Query per la stampa dei veicoli con revisione irregolare cui sono stati sottoposti a riparazione
# nella stessa data della revisione
R_A_R_N = session.query(Revisioni, Ripara).filter(and_(Revisioni.Esito=='IRREGOLARE'),
                                                       ((Revisioni.Giorno) == (Ripara.Giorno)),
                                                       (Ripara.VIN == Revisioni.VIN)).all()
print("")
print("Veicoli con revisione irregolare cui sono stati sottoposti a riparazione")
for i in R_A_R_N:
     if (i._data[1].DescIntervento != None):
          print(i._data[0].VIN+" "+str(i._data[1].Giorno)+" "+i._data[1].DescIntervento)
     else:
          print(i._data[0].VIN+" "+str(i._data[1].Giorno)+" Descrizione non disponibile")
print("")
print("I centri revisioni che hanno effettuato ordini con quantità maggiore di 5 e prezzo superiore a 5€")

# I centri revisioni che hanno effettuato ordini con quantità maggiore di 5 e prezzo superiore a 5€.
ORD_CR = session.query(Centrirevisioni, Ordine).filter(and_((Ordine.IdConcessione == Centrirevisioni.IdConcessione),
                                                             (Ordine.Quantità > 5),
                                                             (Ordine.Prezzo > 5.00))).all()
for i in ORD_CR:
     print(i._data[0].Nome+" Quantità: "+str(i._data[1].Quantità)+"; Prezzo: "+str(i._data[1].Prezzo)+\
           "€; - "+i._data[1].Descrizione)
print("")


print("I fornitori e i Centri Revisioni che hanno maggiormente venduto/speso in un singolo ordine.")
# I fornitori e i Centri Revisioni che hanno maggiormente venduto/speso in un singolo ordine.
somma = session.query(func.sum(Ordine.Prezzo)).all()
n_elementi = session.query(func.count(Ordine.Prezzo)).all()
terzo_quartile = (somma[0][0]/n_elementi[0][0])*0.75

SPESA = session.query(Fornitori, Ordine, Centrirevisioni).filter(and_((Ordine.Prezzo > terzo_quartile),
                                                                      (Centrirevisioni.IdConcessione == Ordine.IdConcessione),
                                                                      (Fornitori.IdFornitore == Ordine.IdFornitore) )).all()
for i in SPESA:
     print(i._data[0].Nome+" "+str(i._data[1].Prezzo)+"€; - "+i._data[2].Nome)
print("")

print("Revisioni effettuate a veicoli con anno di immatricolazione superiore al 2010")
# Revisioni effettuate a veicoli con anno di immatricolazione superiore al 2010
REV = session.query(Revisioni, Veicoli, Fabbricamodello).filter(and_((Revisioni.VIN == Veicoli.VIN),
                                                    (Veicoli.AnnoImmatricolazione > 2010),
                                                    (Veicoli.Modello == Fabbricamodello.Modello))).all()
for i in REV:
     print("Esito: "+i._data[0].Esito+", giorno: "+str(i._data[0].Giorno)+"; ---> TARGA: "+i._data[1].targa+"; Fabbrica: "+\
          i._data[2].Fabbrica+"; Modello: "+i._data[2].Modello+"; Anno Imm.: "+str(i._data[1].AnnoImmatricolazione) )
print("")


# Presso quale centro lavorano i dipendenti che guadagnano meno in assoluto. 
# Nella query sarà indicato anche il nominativo e la specializzazione dello stesso operaio.
print("Presso quale centro lavorano i dipendenti che guadagnano meno di 8€ all'ora e che lavorano per meno di 8 ore al giorno.")

DIP = session.query(Meccanico, Centrirevisioni).filter(and_((Meccanico.IdConcessione == Centrirevisioni.IdConcessione),
                                                            (Meccanico.PagaOraria < float(8.00)),
                                                            (Meccanico.Ore < float(8.00)))).all()
for i in DIP:
     print("Nome: "+i._data[0].Nome+", Cognome: "+i._data[0].Cognome+", Specializzazione: "+i._data[0].Specializzazione+", Paga oraria: "\
           +str(i._data[0].PagaOraria)+"€; ---> Centro: "+i._data[1].Nome)
print("")


# Veicoli che hanno effettuato la revisione presso il Centro Revisioni identificato dal codice TPAE8.
# Tra le colonne della tabella viene anche specificato l'ispettore che ha effettuato il controllo e tutte le informazioni relative al veicolo.
print("Veicoli che hanno effettuato la revisione presso il Centro Revisioni identificato dal codice TPAE8.")

REV = session.query(Ispettore, Veicoli, Fabbricamodello, Revisioni).filter(and_((Ispettore.IdConcessione == 'TPAE8'),
                                                                                (Ispettore.IdIspettore == Revisioni.IdIspettore),
                                                                                (Revisioni.VIN == Veicoli.VIN),
                                                                                (Veicoli.Modello == Fabbricamodello.Modello)
                                                                                )).all()
for i in REV:
     print("Ispettore: "+i._data[0].Nome+" "+i._data[0].Cognome+", Targa: "+i._data[1].targa+", Fabbrica: "+i._data[2].Fabbrica+\
           ", Modello: "+i._data[2].Modello+", Anno immatricolazione: "+str(i._data[1].AnnoImmatricolazione)+", Esito: "+i._data[3].Esito+\
           ", Giorno: "+str(i._data[3].Giorno))

print("")

# I veicoli a cui è stata effettuata sia la revisione che la manutenzione con i prezzi più alti.
# (Prevedendo che un costo maggiore della mano d'opera si tramuti in un conto più oneroso).
print("I veicoli a cui è stata effettuata sia la revisione che la manutenzione con i prezzi più alti.")
massimo = (session.query(func.max(Ripara.Tempo)).all())
terzo_quartile = massimo[0]._data[0]*0.75

VEI = session.query(Veicoli, Fabbricamodello, Ripara, Revisioni).filter(and_((Veicoli.VIN == Ripara.VIN),
                                                                             (Veicoli.VIN == Revisioni.VIN),
                                                                             (Veicoli.Modello == Fabbricamodello.Modello),
                                                                             (Ripara.Tempo > terzo_quartile),
                                                                             (Revisioni.Prezzo > 66.88),
                                                                             )).all()
for i in VEI:
     print("VEICOLO ---->    Targa: "+i._data[0].targa+", Fabbrica: "+i._data[1].Fabbrica+", Modello: "+i._data[1].Modello+ \
           ", Anno immatricolazione: "+str(i._data[0].AnnoImmatricolazione))
     print("   REVISIONE -->  Esito: "+i._data[3].Esito+", Giorno: "+str(i._data[3].Giorno))
     print("   MANUTENZIONE -> Descrizione  intervento: "+i._data[2].DescIntervento+", Giorno: "+str(i._data[2].Giorno))
     print("")
print("")

# Le riparazione al veicolo che sono costate meno al centro revisioni.
# (Considerando come spesa soltanto il costo della manodopera).
print("La riparazione al veicolo che è costata meno al centro revisioni.")
massimo = (session.query(func.max(Ripara.Tempo)).all())
primo_quartile = massimo[0]._data[0]*0.25

massimo = (session.query(func.max(Meccanico.PagaOraria)).all())
primo_quartile_paga = massimo[0]._data[0]*0.25

VEI = session.query(Veicoli, Fabbricamodello, Ripara, Meccanico).filter(and_((Veicoli.VIN == Ripara.VIN),
                                                                             (Meccanico.IdCollaboratore == Ripara.IdCollaboratore),
                                                                             (Veicoli.Modello == Fabbricamodello.Modello),
                                                                             (Ripara.Tempo <= primo_quartile),
                                                                             (Meccanico.PagaOraria < primo_quartile_paga),
                                                                           )).all()
for i in VEI:
     print("VEICOLO ---->    Targa: "+i._data[0].targa+", Fabbrica: "+i._data[1].Fabbrica+", Modello: "+i._data[1].Modello+ \
           ", Anno immatricolazione: "+str(i._data[0].AnnoImmatricolazione))
     print("   MANUTENZIONE -> Descrizione  intervento: "+i._data[2].DescIntervento+", Giorno: "+str(i._data[2].Giorno))
     print("")       
print("")

row = [
          Numero(IdStrada = 1, Numero = 1),Numero(IdStrada = 1, Numero = 1),Numero(IdStrada = 1, Numero = 1),
          Numero(IdStrada = 1, Numero = 3),Numero(IdStrada = 1, Numero = 3),Numero(IdStrada = 1, Numero = 3),
          Numero(IdStrada = 1, Numero = 4),Numero(IdStrada = 1, Numero = 4),Numero(IdStrada = 1, Numero = 4),
          Numero(IdStrada = 1, Numero = 5),Numero(IdStrada = 1, Numero = 5),Numero(IdStrada = 1, Numero = 5),
]
session.add_all(row)
trycommit()

# Rimuovere indirizzi clone
print("Rimozione indirizzi duplicati")       
IND = session.query(Numero.IdStrada, Numero.Numero).group_by(Numero.IdStrada, Numero.Numero).having(func.count(Numero.IdStrada) > 1).all()
for i in IND:
     canc = session.query(Numero).filter(and_((Numero.IdStrada == i._data[0]),(Numero.Numero == i._data[1]))).all()
     for j in range(len(canc)-1):
          session.delete(canc[j])
trycommit()


IND = session.query(Numero.IdStrada, Numero.Numero).group_by(Numero.IdStrada, Numero.Numero).having(func.count(Numero.IdStrada) > 1).all()
for i in IND:
     if (i._data[0]) or (i._data[1]):
          print(i._data[0], i._data[1])
else:
     print("Nessun duplicato!")
print("")
i = 0



############################################## FINE ####################################################### 
