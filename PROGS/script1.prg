* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
*  FileName SCRIPT1.PRG <-- This file create by UnFoxAll
* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


 PARAMETER P_KATA
 LOCAL L_HASIL , L_ACAK , L_INDEX , I
 L_ACAK = 'MULYONO RAFIANTO'
 L_HASIL = ''
 L_INDEX = 1
 FOR I = 1 TO LEN(ALLTRIM(P_KATA))
 L_HASIL = L_HASIL + CHR(ASC(SUBSTR(P_KATA,I,1)) + ASC(SUBSTR(L_ACAK,L_INDEX,1)))
 L_INDEX = L_INDEX + 1
 IF L_INDEX > LEN(L_ACAK)
 L_INDEX = 1
 ENDIF 
 ENDFOR 
 RETURN L_HASIL
*
