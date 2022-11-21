* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
*  FileName UTILITAS.PRG <-- This file create by UnFoxAll
* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-



PROCEDURE BilSay
 PARAMETER _VALUE
 PS = ' '
 DIMENSION BIL( 11 )
 BIL( 1 ) = 'SATU '
 BIL( 2 ) = 'DUA '
 BIL( 3 ) = 'TIGA '
 BIL( 4 ) = 'EMPAT '
 BIL( 5 ) = 'LIMA '
 BIL( 6 ) = 'ENAM '
 BIL( 7 ) = 'TUJUH '
 BIL( 8 ) = 'DELAPAN '
 BIL( 9 ) = 'SEMBILAN '
 BIL( 10 ) = 'SEPULUH '
 BIL( 11 ) = 'SEBELAS '
 MIN_ = .F.
 IF _VALUE < 0
    MIN_ = .T.
    _VALUE = -(_VALUE)
 ENDIF 
 A = STR(_VALUE,15,2)
 MILYAR = SUBSTR(A,1,3)
 JUTA = SUBSTR(A,4,3)
 RIBU = SUBSTR(A,7,3)
 RATUS = SUBSTR(A,10,3)
 SEN = SUBSTR(A,14,2)
 PS =  ;
      IIF( .NOT. EMPTY(MILYAR) .AND. MILYAR <> '000',PROCTES(MILYAR) + 'MILYAR ',PS)
 PS = IIF( .NOT. EMPTY(JUTA) .AND. JUTA <> '000',PROCTES(JUTA) + 'JUTA ',PS)
 BIL( 1 ) = IIF(LEN(ALLTRIM(RIBU)) = 1,'SE',BIL(1))
 PS = IIF( .NOT. EMPTY(RIBU) .AND. RIBU <> '000',PROCTES(RIBU) + 'RIBU ',PS)
 BIL( 1 ) = 'SATU'
 PS = IIF( .NOT. EMPTY(RATUS) .AND. RATUS <> '000',PROCTES(RATUS),PS)
 PS = ALLTRIM(PS) + IIF(EMPTY(PS),' ',' RUPIAH ')
 PS = IIF( .NOT. EMPTY(SEN) .AND. SEN <> '00',PROCTES('0' + SEN) + ' SEN',PS)
 IF MIN_
    PS = '(Min) ' + PS
 ENDIF 
 RETURN PS
ENDPROC
*------
PROCEDURE proctes
 PARAMETER X
 FOR I = 1 TO 3
    CHR = SUBSTR(X,I,1)
    IF CHR = '0' .OR. CHR = ' '
       LOOP 
    ENDIF 
    IF I = 1
       PS = PS + IIF(CHR = '1','SERATUS ',BIL(VAL(CHR)) + 'RATUS ')
    ENDIF 
    IF I = 2
       IF CHR = '1'
          PS =  ;
               PS +  ;
         IIF(SUBSTR(X,I + 1,1) = '0' .OR. SUBSTR(X,I + 1,1) = '1',BIL(VAL(SUBSTR(X,2,2))),BIL(VAL(SUBSTR(X,I + 1,1))) + 'BELAS ')
          EXIT 
       ELSE 
          PS = PS + BIL(VAL(CHR)) + 'PULUH '
       ENDIF 
    ENDIF 
    PS = IIF(I = 3,PS + BIL(VAL(CHR)),PS)
 ENDFOR 
 RETURN PS
ENDPROC
*------*
