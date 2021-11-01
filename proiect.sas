/* 1 */
proc import datafile  =  '/home/u58024946/proiect/dateExcel.xlsx'
 out  =  carti_excel
 dbms  =  xlsx
 replace;
run;

proc import datafile  =  '/home/u58024946/proiect/dateExcel2.xlsx'
 out  =  vanzari_excel
 dbms  =  xlsx
 replace;
run;

/* 2 */
data carti; 
 infile "/home/u58024946/proiect/date3.txt"; 
 input Cod  PretVanzare ; 
/*  if missing(Comenzi) then delete;  */

if PretVanzare < 20 then Discount =  PretVanzare - 0* PretVanzare; 
else if PretVanzare > 80 then Discount = PretVanzare - 0.1 * PretVanzare;
else if PretVanzare < 80 AND PretVanzare > 20 then Discount = PretVanzare - 0.05 * PretVanzare;
 run;
 
 title "Date carti";
proc print data=carti noobs;
run;


/* 3 */
proc SQL;
create table Editura As 
Select * from carti_excel
 where Editura='RAO'; 
 run;
 quit;

/* 4 */
proc SQL;
create table PretTotal As
select c.Denumire,c.PretVanzare*v.Total from carti_excel c, vanzari_excel v
where c.Cod=v.Cod;
quit;

/* 5 */
LIBNAME data "/home/u58024946";
TITLE 'Distributia cartilor in functie de tip';
/* GOPTIONS  reset=all; */
PROC GCHART data=carti_excel;
	VBAR Tip;
RUN;
QUIT;

/* 6 */
DATA denumiri;   
   INFILE '/home/u58024946/proiect/denumiri.txt' dlm=',';    
   INPUT Cod  Denumire; 
RUN;
data vanzariInformatii;
merge denumiri vanzari_excel;
by Cod;
proc print data = vanzariInformatii;
run;




