DATA stud;
	INFILE "/home/u58024946/sem6/caritabil.txt";
	input CENTRU $ PROFIL $ GEN $ AN;
	PROC FORMAT;
value $oras 'BUC'='Bucuresti'
'IAS'='Iasi'
'TIM'='Timisoara'
other = 'Cluj';
VALUE $profil 'ECON'='Economic'
'TEHN'='Tehnic'
other = 'Umanist';
RUN;
PROC freq DATA=stud;
	TABLES CENTRU*PROFIL;
	FORMAT CENTRU $oras. PROFIL $profil.;
Title "Tabele de frecventa";
RUN;

LIBNAME data "/home/u58024946/sem6";
TITLE 'Salariu mediu anual pe departamente';
GOPTIONS  reset=all;
AXIS1 order =("FLIGHT OPERATIONS" "FINANCE & IT" "HUMAN RESOURCES" "SALES & MARKETING" "CORPORATE OPERATIONS"
"AIRPORT OPERATIONS" "FLIGHT OPERATIONS"); 
PROC GCHART data=data.angajati;
	VBAR Departament / sumvar=Salariu
			type=mean
			 maxis=axis1;
RUN;
QUIT;

LIBNAME echipe "/home/u58024946/sem6";
RUN;
PROC UNIVARIATE DATA=echipe.echipe PLOT;
TITLE;
RUN;

