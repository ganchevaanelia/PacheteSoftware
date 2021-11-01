data produsee;
	infile '/home/u58024946/Sem 3/produsee.txt' dlm='*';
	input Nume $ Pret Categorie $;
run;

libname produsee '/home/u58024946/Sem 3/';
data produsee.date_test;
	input Nume $ 1-8
	          Pret 9-11
 	          Categorie $ 12-20;
datalines; 
run;

libname culori '/home/u58024946/Sem 3/';
data culori.date_test;
	input Col $ 1-8;
datalines;
Rosu
Galben
Albastru
Verde
Roz
Rosu
Verde
Mov
Maro
Alb
run;


proc format;
value $culoare 'Rosu', 'Galben', 'Albastru' = 'Culori de baza'
			'Alb', 'Negru' = 'Non-culori';
run;

data culori;
infile '/home/u58024946/Sem 3/culori.txt'
input Col$ 1-8;
datalines;
title "Date despre culori";
proc print data=culori;
var Col;
format Col $culoare.;
run;