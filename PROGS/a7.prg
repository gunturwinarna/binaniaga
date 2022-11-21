KREDIT=SYS(2015)

BROW
*!*	LOCAL t1, t2, x, h
*!*	CLEAR
*!*	t1 = SECONDS()
*!*	h = FOPEN( "d:\data\kpri0417" )   && 3.2 mb in size
*!*	FSEEK( h, 0,1 )  && Move the pointer
*!*	x = FREAD( h, 10 )  && Read 1000 bytes
*!*	t2 = SECONDS()

*!*	?x
*!*	FSEEK( h, 0,1 )
*!*	x = FREAD( h, 10 )
*!*	?x

*!*	FSEEK( h, 0,1 )
*!*	x = FREAD( h, 10 )
*!*	?x

*!*	FCLOSE( h )
CLEAR
HURUF = SPACE(10)
 ANGKA1 = SPACE(10)
X ='       S D F G  H J 08S1D5F6G6H6J2K8U5I5'
? X
 W=ALLTRIM(X)
? LEN(X)
 Y = LEN(ALLTRIM(X))
 ANGKA ='0123456789'
 FOR I = 1 TO Y
    G = SUBSTR(W,I,1)
     IF RAT(G,ANGKA) > 0
 		ANGKA1 = ANGKA1 +G    
        ELSE
        HURUF = HURUF +G
     ENDIF
    *? G
    *? I
    
 NEXT
 ? X
 ? ANGKA1
 ? HURUF