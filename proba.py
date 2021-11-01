i = 0;
lista = []
while i < 8:
    value = int(input("Tastati 8 numere: "))
    lista.append(value)
    i += 1
print(lista)
l_par = []
l_impar = []
k=0;
while k < 8:
    n = lista.pop()
    if(n % 2 == 0):
        l_par.append(n)
    else:
        l_impar.append(n)
    k += 1
print(l_impar)
print(l_par)
p = len(l_par)
i = len(l_impar)
if (p > i):
    print("lista para are mai multe elemente")
elif (i < p):
    print("lista impara are mai multe elemente")
else:
    print("egale")