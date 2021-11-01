data Vanzari;
set import(keep=Regiune TotalVanzari);
SELECT;
WHEN (Regiune='Nord') Ponderi=1.5;
WHEN (Regiune='Sud') Ponderi=1.7;
WHEN (Regiune='Est') Ponderi=2;
WHEN (Regiune='Vest') Ponderi=2;
END;
run;
Title "Lista - Total vanzari, Regiuni, Ponderi ";
proc Print data=vanzari;
run;

data Vanzari2;
set import;
WHERE Regiune EQ 'Nord' and
Cantitate lt 60 
or
Client EQ "Pet's are Us";
run;
Title "Vanzari";
proc print data=vanzari2;
run;

data Investitie_Finala;
investitie=1000;
rataDobanzii=.0425;
DO UNTIL(investitie GE 30000);
An +1;
investitie= investitie + rataDobanzii*investitie;
output;
end;
format investitie dollar10.2;
run;
title "Numarul de ani necesari obtinerii a 30 000$";
proc print data=Investitie_Finala noobs;
run;