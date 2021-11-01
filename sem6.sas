**1
DATA cititori;
	INFILE "/home/u58024946/sem6/micii_cititori.txt";
	INPUT Nume $ Clasa $ DataParticipare DATE9. Suport $ Cantitate;
	Castig=Cantitate*3;
RUN;
PROC SORT DATA=cititori;
	BY Clasa;
PROC PRINT DATA=cititori sumlabel='Total #byval(Clasa)' grandtotal_label='Total' ;
	BY Clasa;
	SUM Castig;
	TITLE 'Fondurile stranse de fiecare clasa';
RUN;
**2
*Statistici descriptive cu UNIVARIATE;
DATA note;
	INFILE "/home/u58024946/sem6/note.txt";
	INPUT Punctaj @@;
RUN;
PROC UNIVARIATE DATA=note PLOT;
VAR Punctaj;
TITLE;
RUN;
**3
*Valori extreme si histograma cu UNIVARIATE;
LIBNAME sem4 "/home/u58024946/sem6";
*punctul a);
PROC UNIVARIATE DATA=sem4.amenzi_viteza;
	VAR Amenzi;
	ID Stat;
	Title "Indicatori statistici pentru amenzile de viteza";
RUN;
*punctul b);
PROC UNIVARIATE DATA=sem4.amenzi_viteza noprint; *nu fiseaza tabelele de iesire;
	VAR Amenzi;
	HISTOGRAM Amenzi;
	Title "Histograma pentru amenzile de viteza";
RUN;
*punctul c);
PROC UNIVARIATE DATA=sem4.amenzi_viteza NEXTRVAL=5 NEXTROBS=0;
	VAR Amenzi;
	ID Stat;
	Title "Indicatori statistici cu valori limita distincte pentru amenzile de viteza";
RUN;
**4
libname ad_data "/home/u58024946/sem6";
DATA vanzari;    
   SET ad_data.flori;
   Luna = MONTH(DataVanzare); 
PROC SORT DATA =vanzari;    
   BY Luna; 
* Calculeaza media vanzarilor lunare de bulbi de flori;
PROC MEANS DATA = vanzari;    
   BY Luna;    
   VAR Lalele Gladiole Zambile;
   TITLE 'Raportul vanzarilor lunare de bulbi de flori';
RUN;
**5
*Scrierea statisticilor agregate intr-un set de date;
DATA vanzari1;    
    SET ad_data.flori;
PROC SORT DATA = vanzari1;
   BY IDClient;
PROC MEANS NOPRINT DATA = vanzari1;
   BY IDClient;
   VAR Lalele Gladiole Zambile;
   OUTPUT OUT = totaluri  MEAN(Lalele Gladiole Zambile) =
          MedieLalele MedieGladiole MedieZambile
      SUM(Lalele Gladiole Zambile) = Lalele Gladiole Zambile;
PROC PRINT DATA = totaluri;
   TITLE 'Raport privind bulbii de flori vanduti fiecarui client';
   FORMAT MedieLalele MedieGladiole MedieZambile 3.;
RUN;
**6
*Intervale de incredere pentru medie;
DATA PaginiCarte;
INFILE "/home/u58024946/sem6/carti.txt";
INPUT NrPagini @@;
RUN;
PROC MEANS DATA=PaginiCarte N MEAN MEDIAN CLM ALPHA=.10;
	TITLE "Raport privind numarul de pagini al cartilor ilustrate";
RUN;
**7
PROC FORMAT;
value $zona 
	'i' = 'interior'
	'x' = 'exterior';
RUN; 
DATA comenzi;
INPUT cafea $ zona $ @@;
DATALINES;
esp i cap x cap i fra i lat i fra x esp x fra i lat x esp x
cap i esp x cap x fra x .   x fra i esp x cap i lat i fra i
fra i fra i lat x esp x fra i esp x esp i fra i cap i fra i
;
RUN;
Title "Tabele de frecventa pentru zona si zona/cafea";
PROC freq DATA=comenzi;
 format zona $zona.;
TABLES zona zona*cafea;
RUN;
**8
*Determinarea frecventelor datelor grupate;
LIBNAME sem4 "/home/u58024946/sem6";
PROC FORMAT;
value nivel low-<40000='Mic'
40000-<60000='Mediu'
60000-100000='Mare'
other = 'Executiv';
RUN;
PROC FREQ DATA=sem4.angajati ;
	TABLES Salariu /nocum ;
	FORMAT Salariu nivel.;
TITLE "Raport privind nivelul salariului anual";
RUN;
PROC FREQ DATA=sem4.angajati;
	TABLES Departament * Salariu/ nocol norow nopercent;
	FORMAT Salariu nivel.;
TITLE "Raport privind nivelul salariului anual pe departament";
RUN;
**9
LIBNAME ad_data "/home/u58024946/sem6";
TITLE 'Distributia vanzarilor in functie de tara si model';
GOPTIONS  reset=all;
* grafic cu bare pentru variabile discrete;
PROC GCHART data=ad_data.biciclete;
	VBAR Model Tara;
RUN;
QUIT;
**
LIBNAME ad_data "/home/u58024946/sem6";
TITLE 'Distributia vanzarilor in functie de tara si model';
GOPTIONS  reset=all;
* grafic cu bare pentru variabile discrete;
PROC GCHART data=ad_data.biciclete;
	PIE Model;
RUN;
QUIT;
**10
TITLE "Distributia vanzarilor totale";
PATTERN value=solid;
PROC GCHART data=ad_data.biciclete;
	vbar VanzariTotale / midpoints= 0 to 12000 by 2000;
RUN;
QUIT;
**11
* grafic cu bare care reprezinta sume;
TITLE "Suma vanzarilor totale pe tara";
PATTERN value=L1;
*definirea unei axe cu valori ordonate;
AXIS1 order =("Franta" "Italia" "SUA" "Marea Britanie"); 
PROC GCHART data=ad_data.biciclete;
VBAR Tara / sumvar=VanzariTotale
			type=sum
			maxis=axis1;
RUN;
QUIT;
**12
*grafic cu a doua variabila ca subgrup;
TITLE "Distribuita vanzarilor in functie tara și de model";
PATTERN value = solid;
PROC GCHART data=ad_data.Biciclete;
VBAR Tara / subgroup=Model;
RUN;
QUIT;
**13
*grafice care arata corelatia intre variabile;
*diagrama de corelatie standard;
TITLE "Evolutia in timp a pretului actiunii- Grafic standard";
 PROC GPLOT data=ad_data.actiuni;
 	PLOT DATA * Pret;
RUN;
QUIT;
*diagrama de corelatie cu puncte;
SYMBOL value=dot;
TITLE "Evolutia in timp a pretului actiunii- Grafic cu puncte";
PROC GPLOT data=ad_data.actiuni;
 	PLOT Data * Pret;
RUN;
QUIT;
*diagrama de corelatie cu linie continua;
SYMBOL value=dot i=sm;
TITLE "Evolutia in timp a pretului actiunii- Grafic cu linie continua";
PROC GPLOT data=ad_data.actiuni;
 	PLOT Data * Pret;
RUN;
QUIT;
**14
*Analiza de corelatie;
DATA grupa_studenti;
    INPUT Punctaj Televiziune Exercitii @@;
DATALINES;
56 6 2   78 7 4   84 5 5   73 4 0   90 3 4
44 9 0   76 5 1   87 3 3   92 2 7   75 8 3
85 1 6   67 4 2   90 5 5   84 6 5   74 5 2
64 4 1   73 0 5   78 5 2   69 6 1   56 7 1
87 8 4   73 8 3  100 0 6   54 8 0   81 5 4
78 5 2   69 4 1   64 7 1   73 7 3   65 6 2
;
RUN;
PROC CORR DATA = grupa_studenti;
   VAR Televiziune Exercitii;
   WITH Punctaj;
   TITLE 'Corelatie intre punctajul la test';
   TITLE2 'Si orele petrecute la televizor sau exarsand';
RUN;
**15
*Analiza de regresie;
DATA racoritoare;
	INFILE "/home/u58024946/sem6/racoritoare.txt";
	INPUT Data: MMDDYY. Vanzari Temperatura;
RUN;
PROC PRINT data=racoritoare;
	FORMAT data DDMMYY.;
RUN; 
PROC CORR  data=racoritoare;
	VAR Temperatura;
	WITH Vanzari;
	TITLE "Corelatia intre vanzarile de racoritoare";
RUN;
PROC REG data=racoritoare;
	MODEL Vanzari=Temperatura;
	PLOT Vanzari*Temperatura;
	TITLE "Rezultatele analizei de regresie";
RUN;
**16
*Analiza dispersionala;
DATA locatii;
	INFILE "/home/u58024946/sem6/locatii.txt";
	INPUT Vanzari Locatie$;
RUN; 
PROC ANOVA DATA=locatii;
	CLASS Locatie;
	MODEL Vanzari = Locatie;
	MEANS Locatie / SCHEFFE;
	TITLE "Vanzarile de racoritoare in cele trei locatii";
RUN;




