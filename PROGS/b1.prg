

awal = CTOD('27-06-2019')
akhir = CTOD('10-10-2020')


nilai =jangkawaktu(awal,akhir)
? awal
? akhir
? nilai

PROCEDURE jangkawaktu
 PARAMETER ARG1 , ARG2
 LOCAL LAMA
 LAMA = ((YEAR(ARG2) - YEAR(ARG1)) * 12) + (MONTH(ARG2) - MONTH(ARG1)) + 1
 RETURN LAMA
ENDPROC