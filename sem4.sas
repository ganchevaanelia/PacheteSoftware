data Studenti;
length Sex $ 1;
input Varsta Sex Proiect Activitate Examen;
datalines;
21 M 8 9 8
. F 9 9 9
35 M 8 8 8
48 F . . 7
59 F 9 7 9
15 M 8 . 9
67 F 9 8 9
. M 6 7 6
35 F 7 7 8
49 M 5 5 8 
;
title "Date studenti";
proc print data=Studenti; *noobs;
run;

title "Exemplu de operatori logici";
proc print data=work.studenti;
where Sex eq 'F' and
(Proiect in (9 10) or
examen eq 10);
var Sex Activitate Proiect Examen; 
run;


data Studenti;
length Sex $ 1;
input Varsta Sex Proiect Activitate Examen;
            if Varsta lt 20 and not missing(Varsta) then GrupVarsta = 1;
else if Varsta ge 20 and Varsta lt 40 then GrupVarsta = 2;
else if Varsta ge 40 and Varsta lt 60 then GrupVarsta = 3;
else if Varsta ge 60 then GrupVarsta = 4;
datalines;
21 M 8 9 8
. F 9 9 9
35 M 8 8 8
48 F . . 7
59 F 9 7 9
15 M 8 . 9
67 F 9 8 9
. M 6 7 6
35 F 7 7 8
49 M 5 5 8
;
title "Date studenti";
proc print data=Studenti noobs;
run;

data Femei;
length Sex $ 1;
input Varsta Sex Proiect Activitate Examen;
if Sex eq 'F';
datalines;
21 M 8 9 8
. F 9 9 9
35 M 8 8 8
48 F . . 7
59 F 9 7 9
15 M 8 . 9
67 F 9 8 9
. M 6 7 6
35 F 7 7 8
49 M 5 5 8
;
title "Date studente";
proc print data=Femei;
run;

data proiecte;
length Departament $ 9;
input CodProiect Departament $ Valoare;
datalines;
312 Productie 8720
313 Achizitii 12570
314 Productie 39750
315 Desfacere 7380
316 Desfacere 18390
;
run;
*/fara stabilirea latimii frecventei de raportare; 
data proiecte1;
set proiecte;
if Valoare le 10000 then 
	do;
	Raportare="Lunara";
	Prezentare='17dec2018'd; *constanta de tip data;
	end;
else 
	do;
	Raportare="Bilunara";
	Prezentare='20dec2018'd;
		end;
run;
*/cu stabilirea latimii frecventei de raportare; 
data proiecte2;
set proiecte;
length Raportare $8;
if Valoare le 10000 then 
	do;
	Raportare="Lunara";
	Prezentare='17dec2018'd; 
	end;
else 
	do;
	Raportare="Bilunara";
	Prezentare='20dec2018'd;
		end;
run;

title "Proiecte companie - fara impunerea latimii coloanei Raportare";
proc print data=proiecte1 noobs;
format Prezentare ddmmyy10.;
format Valoare COMMA8.;
run;
title "Proiecte companie - cu impunerea latimii coloanei Raportare";
proc print data=proiecte2 noobs;
format Prezentare ddmmyy10.;
format Valoare COMMA8.;
run;

data Studenti1;
set Studenti;
	where Sex eq 'M';
	NotaFinala=SUM(Proiect*0.3+Activitate*0.2+Examen*0.5);
	if NotaFinala>7;
run;
Title "Lista studentilor de sex masculin cu nota finala peste 7";
proc print data=Studenti1 noobs;
run;

data Studenti2;
length Sex $ 1;
input Varsta Sex Proiect Activitate Examen;
	SELECT;
		WHEN (missing(Varsta)) GrupVarsta= . ;
		WHEN (Varsta lt 20) GrupVarsta=1;
		WHEN (Varsta lt 40) GrupVarsta=2;
		WHEN (Varsta lt 60) GrupVarsta=3;
		OTHERWISE GrupVarsta=4;
	END;		
datalines;
21 M 8 9 8
. F 9 9 9
35 M 8 8 8
48 F . . 7
59 F 9 7 9
15 M 8 . 9
67 F 9 8 9
. M 6 7 6
35 F 7 7 8
49 M 5 5 8
;
title "Date studenti introduse cu SELECT";
proc print data=Studenti2;
run;

data Medii;
length Sex $ 1
GrupVarsta $ 13;
infile '/home/u58024946/Sem4/datesas.txt';
input Varsta Sex Proiect Activitate Examen;
if missing(Varsta) then delete;
if Varsta le 39 then 
do;
GrupVarsta = 'Grup1';
Medie = .4*Proiect + .6*Examen;
             end;
else if Varsta gt 39 then
do;
GrupVarsta  = 'Grup2';
medie = (Proiect + Examen)/2;
             end;
run;
title "Raportul Mediilor Studentilor";
proc print data=medii noobs;
var Proiect Activitate Examen;
run;

data Venit;
input 
	Zi : $8.
	venit : dollar6.;
	Total + Venit;
format Venit Total dollar8.;
datalines;
Luni $1,000
Marti $1,500
Miercuri .
Joi $2,000
Vineri $3,000
title "Incasari saptamanale";
proc print data=venit noobs;
run;

data Dobanda_Investitie;
Dobanda = .0375;
Total = 100;
do An = 1 to 3;
Total + Dobanda*Total;
output;
end;
     format Total dollar10.2;
run;
title "Evoluţie investiţie";
proc print data=Dobanda_Investitie noobs;
run;

libname ad_data "/home/u58024946/Sem4";
data work.venituri;
set ad_data.angajati;
prima=500;
vechime=YRDIF(DataAngajare, TODAY(), 'ACTUAL');
if vechime lt 5 then spor=0.05; 
else if vechime ge 5 and vechime lt 10 then spor= 0.1;
else if vechime>=10 then spor =0.15;
Venit_total=sum(salariu*(1+spor),prima); 
format Venit_total DOLLAR10.;
Luna_prima=month(DataAngajare);
run; 

title "Venituri totale angajati";
Proc print data=work.venituri noobs;
var CodAngajat Nume Prenume Departament Venit_total Luna_prima;
run;
