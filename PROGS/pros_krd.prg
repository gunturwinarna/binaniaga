* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
*  FileName PROS_KRD.PRG <-- This file create by UnFoxAll
* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-



PROCEDURE PinjMenuHit
 PARAMETER MMENUKE
 HIDE POPUP MENUHITPINJ
 IF EMPTY(MNOREK)
 RETURN 
 ENDIF 
 DO CASE 
 CASE MMENUKE = 1
 DO FORM pinjaman_perhitungan WITH MNOREK
 CASE MMENUKE = 2
  HITDENDA(MNOREK,TGLNOW,'d:\PELUNASAN.TXT')
 ENDCASE 
 SHOW POPUP MENUHITPINJ
 RETURN 
ENDPROC
*------
* -------------------
PROCEDURE saldokrdx
 PARAMETER MNOREK , XXTGL
 LOCAL MBUNGA , JDWPK , JDWBG , BYRPK , BYRBG , SLDPK , SLDBG , MRATE , WJBPK , WJBBG ,  ;
      JDWKE , ANGSKE , HARUSKE
 LOCAL MSISAPK , MSISABG , KALIPK , KALIBG , ODPK , ODBG , TGLODPK , TGLODBG
 LOCAL NJDWPK , NJDWBG , MSISA , MTGLKHBYR , MHRSPK , MHRSBG , MSISAJDWPK , MSISAJDWBG
 OLDSELECT = SELECT()
 CREATE CURSOR SALDOKRD ( NOREK C ( 25 ) , TGLJTEMPO D , KOL C ( 1 ) , PLAFON N ( 15 ) ,  ;
      PKAWAL N ( 15 ) , BGAWAL N ( 15 ) , SISAPK N ( 15 ) , SISABG N ( 15 ) ,  ;
      HRSPK N ( 15 ) , HRSBG N ( 15 ) , SISAJDWPK N ( 15 ) , SISAJDWBG N  ;
      ( 15 ) , KALIPK N ( 6 , 3 ) , KALIBG N ( 5 , 1 ) , JUMJDWPK N ( 3 ) ,  ;
      JUMJDWBG N ( 3 ) , ODPK N ( 15 ) , ODBG N ( 15 ) , TGLODPK DATE ,  ;
      TGLODBG DATE , WJBPK N ( 15 ) , WJBBG N ( 15 ) , JDWKE INT ( 3 ) , ANGSKE  ;
      INT ( 3 ) , HARUSPKKE INT ( 3 ) , HARUSBGKE INT ( 3 ) , NJDWPK N ( 15  ;
      ) , NJDWBG N ( 15 ) , MTGLKHBYR DATE , BYRPK N ( 15 ) , BYRBG N ( 15 ) ,  ;
      DENDA N ( 10 ) , KALIBYRPK N ( 3 ) , KALIBYRBG N ( 3 ) , JAMINAN C  ;
      ( 100 ) , TAKSASI N ( 15 ) , PPAP N ( 15 ) , PPAP1 N ( 15 ) , BGAKRUAL  ;
      N ( 15 ) , KONTIJENSI N ( 15 ) , ADM N ( 15 ) , PROVISI N ( 15 ) ,  ;
      BIAYA N ( 15 ) )
 KREDIT = SYS(2015)
 ANGSUR = SYS(2015)
 JADWAL = SYS(2015)
 CJAMINAN = SYS(2015)
 CBPKB = SYS(2015)
 CSERTIFIKAT = SYS(2015)
 CSIMPANAN = SYS(2015)
 CLAIN = SYS(2015)
 CSQL = "select * from pinjaman where norek='" + MNOREK + "'"
 LCEK = SQLEXEC(OODBC,CSQL,KREDIT)
 
 IF ISNULL(NOREK)
 	USE 
 	SELECT (OLDSELECT)
 	RETURN 
 ENDIF 
 CSQL =  ;
      "select * from pinjaman_mutasi where norek='" + MNOREK + "' and tanggal<='" +  ;
	   SQLDATE(XXTGL) + "' order by tanggal"
 LCEK = SQLEXEC(OODBC,CSQL,ANGSUR)
 CSQL =  ;
      "select * from pinjaman_jadwal where norek='" + MNOREK + "' order by tanggal"
 LCEK = SQLEXEC(OODBC,CSQL,JADWAL)
 CSQL = "select * from pinjaman_jaminan where norek='" + MNOREK + "'"
 LCEK = SQLEXEC(OODBC,CSQL,CJAMINAN)
  SELECT &ANGSUR
 INDEX ON NOREK + DTOS(TANGGAL) TAG ANGSUR
  SELECT &JADWAL
 INDEX ON NOREK + DTOS(TANGGAL) TAG JADWAL
 SET NEAR ON
  SELECT &KREDIT
 XXTGL = IIF(XXTGL > TGLLUNAS .AND.  .NOT. EMPTY(TGLLUNAS),TGLLUNAS,XXTGL)
 MTGLREALISASI = TANGGAL
 
  SELECT &KREDIT
 STORE 0 TO MBUNGA , JDWPK , JDWBG , BYRPK , BYRBG , SLDPK , SLDBG , MRATE , WJBPK ,  ;
      WJBBG , JDWKE , ANGSKE , HARUSPKKE , HARUSBGKE , MSISAPK , MSISABG ,  ;
      KALIPK , KALIBG , ODPK , ODBG , NJDWPK , NJDWBG , MSISA
 STORE 0 TO VSISAPK
 STORE CTOD('  -  -    ') TO TGLODPK , TGLODBG , MTGLKHBYR
 STORE 0 TO JPK , JBG , MPKAWAL , MBGAWAL , MHRSPK , MHRSBG , MPKNOW , MBGNOW
 STORE 0 TO MKLBYRPK , MKLBYRBG , MSISAJDWPK , MSISAJDWBG
 MRATE = RATE
 
 DO CASE 
	CASE KDHIT = 'A' .OR. KDHIT = 'B' .OR. KDHIT = 'D' .OR. KDHIT = 'E' .OR. KDHIT = 'I' .OR.  ;
		 KDHIT = 'J' .OR. KDHIT = 'M'
		 * Hitung jumlah pembayaran
  	  	 select &ANGSUR
		
 		 DO WHILE .NOT. EOF()
 	        IF KODE <>'06'
 		     BYRPK = BYRPK + POKOK  
 		     BYRBG = BYRBG + JASA
 		    ENDIF
 		 SKIP
 		 ENDDO
 		
 		  GO TOP
 		  MTGLAKHIR = TANGGAL
 	   	 SCAN 
 			MTGLAKHIR = MAX(MTGLAKHIR,TANGGAL)
 		 ENDSCAN 
	 	 
	 	 JANGSURAN = BYRPK + BYRBG
	 	 SLDPK = BYRPK
	 	 SLDBG = BYRBG
	 	 TBUNGA = 0
		 select &JADWAL
 		 GO TOP
 		 MANGBG = JASA
 		 DO WHILE  .NOT. EOF()
 			IF XXTGL < AKHIRBLN(TANGGAL)
 				EXIT 
 			ENDIF 
 			IF .T.
 				JDWKE = JDWKE + 1
 				IF SLDPK < POKOK
 					TGLODPK = IIF(EMPTY(TGLODPK),TANGGAL,TGLODPK)
	 				IF SLDPK > 0
	    				KALIPK = KALIPK + ((POKOK - SLDPK) / POKOK)
	    				ODPK = ODPK + (POKOK - SLDPK)
	 				ELSE 
	    				KALIPK = KALIPK + 1
	    				ODPK = ODPK + POKOK
	 				ENDIF 
 				ELSE 
 				    MKLBYRPK = MKLBYRPK + 1
 				ENDIF 
 				SLDPK = SLDPK - (MIN(POKOK,SLDPK))
 			ENDIF 
 			IF .T.
 				IF SLDBG < JASA
 	       			TGLODBG = IIF(EMPTY(TGLODBG),TANGGAL,TGLODBG)
			 		IF SLDBG > 0
			    		KALIBG = KALIBG + ((JASA - SLDBG) / JASA)
			    		ODBG = ODBG + (JASA - SLDBG)
			 		ELSE 
			    		KALIBG = KALIBG + 1
			    		ODBG = ODBG + JASA
			 		ENDIF 
	    		ELSE 
 					MKLBYRBG = MKLBYRBG + 1
 	   			ENDIF 
 				SLDBG = SLDBG - MIN(JASA,SLDBG)
 			ENDIF 
	 		IF TANGGAL <= XXTGL
		 		JDWPK = JDWPK + POKOK
		 		JDWBG = JDWBG + JASA
		 		TBUNGA = TBUNGA + JASA
	 		ENDIF 
	 			JANGSURAN = JANGSURAN - (POKOK + JASA)
 			IF JANGSURAN >= 0
		 		ANGSKE = ANGSKE + 1
 			ENDIF 
 			IF TANGGAL <= AKHIRBLN(XXTGL)
	 			IF POKOK > 0
	 				HARUSPKKE = HARUSPKKE + 1
	 			ENDIF 
		 		IF JASA > 0
		 			HARUSBGKE 																																																																																																																																																																												= HARUSBGKE + 1
		 		ENDIF 
			ENDIF 
 			SKIP 
 		 ENDDO 
	 	 GO TOP
	   	 DO WHILE  .NOT. EOF()
		 	IF POKOK > 0
		 		JPK = JPK + 1
		 	ENDIF 
		 	IF JASA > 0
		 		JBG = JBG + 1
		 	ENDIF 
		 	MPKAWAL = MPKAWAL + POKOK
		 	MBGAWAL = MBGAWAL + JASA
		 	IF TANGGAL < AKHIRBLN(XXTGL)
		 		MHRSPK = MHRSPK + POKOK
		 		MHRSBG = MHRSBG + JASA
		 	ELSE 
		 		MSISAJDWPK = MSISAJDWPK + POKOK
		 		MSISAJDWBG = MSISAJDWBG + JASA
		 	ENDIF 
		 	IF XXTGL < TANGGAL AND TANGGAL < AKHIRBLN(XXTGL)
		 		NJDWPK = POKOK
		 		NJDWBG = JASA
		 	ENDIF 
		 	SKIP 
	 	 ENDDO 
	  	 SELECT &KREDIT
	  	 MSISAPK = POKOK - BYRPK
	  	 MSISABG = JASA - BYRBG

 ENDCASE 
 
  select &KREDIT
 KALIPK = IIF(KALIPK = 0 .AND. ODPK > 0,1,KALIPK)
 KALIBG = IIF(KALIBG = 0 .AND. ODBG > 0,1,KALIBG)
 IF ODPK < 0
 	ODPK = ODPK + WJBPK
 	WJBPK = 0
 ENDIF 
 IF ODBG < 0
 	ODBG = ODBG + WJBBG
 	WJBBG = 0
 ENDIF 
 IF WJBPK > MSISAPK
 	WJBPK = MSISAPK
 ENDIF 
 IF WJBBG > MSISABG
 	WJBBG = MSISABG
 ENDIF 

 
  vlama=jangkawaktu(&KREDIT->tglmulai,&KREDIT->tgljtempo)
   glama=selisihbln(&KREDIT->tglmulai,xxtgl)

   DO CASE
           * sudah jatuh tempo dan tidak turun jasa
      CASE GLama-vlama > 0 AND YEAR(&KREDIT->tglbupn) = 0
      	    Mhrsbg = mhrsbg + (glama-vlama) * (mangbg/2)
     		ODBG = MHRSBG - BYRBG 
          * sudah jatuh tempo dan  turun jasa
      CASE GLama-vlama > 0 AND YEAR(&KREDIT->tglbupn) > 0
      	    Mhrsbg = mhrsbg + (glama-vlama) * (mangbg/2)
     		ODBG = MHRSBG - BYRBG 
     		
     		* sudah jatuh tempo 
      CASE GLama-vlama > 0
      		Mhrsbg = glama * mangbg
     		ODBG = MHRSBG - BYRBG 
     		
     		* belum jatuh tempo (hitungan bulanan)
     OTHERWISE
           	Mhrsbg = mhrsbg
     		ODBG = MHRSBG - BYRBG 	
   ENDCASE
   
 
    IF GLama-vlama > 0 AND YEAR(&KREDIT->tglbupn) = 0
     Mhrsbg = mhrsbg + (glama-vlama) * (mangbg/2)
     ODBG = MHRSBG - BYRBG 
     
    else
    
    MHRDBG = MHRSBG
	ODBG = MHRSBG - BYRBG 
    ENDIF

*!*	  
*!*	  IF GLAMA-VLAMA > 0  AND YEAR(&KREDIT->tglbupn) = 0
*!*	     MHRSBG = vLAMA * MANGBG
*!*	     ODBG = MHRSBG - BYRBG
*!*	  ELSE
*!*	    
*!*	  ENDIF
*  MESSAGEBOX(mHRSBG)

 VSISAPK = MSISAPK
 VSISABG = MSISABG
 VKALIPK = KALIPK
 VKALIBG = KALIBG
 VODPK = ODPK
 VODBG = ODBG
 VTGLODPK = TGLODPK
 VTGLODBG = TGLODBG
 VWJBPK = WJBPK
 VWJBBG = WJBBG
 VJDWKE = JDWKE
 VANGSKE = ANGSKE
 VHARUSPKKE = HARUSPKKE
 VHARUSBGKE = HARUSBGKE
 VNJDWPK = NJDWPK
 VNJDWBG = NJDWBG
 VMTGLKHBYR = MTGLKHBYR
 VBYRPK = BYRPK
 VBYRBG = BYRBG
 VTAKSASI = 0
 VJAMINAN = ''
 KOLEKTA = '1'
 IF &KREDIT->tgljtempo > xxtgl
     MLEBIHJT = 0
 ELSE 
  	mtgljtempo=&KREDIT->tgljtempo      
	 IF XXTGL >= MTGLJTEMPO AND XXTGL <= MAJU1BLN(MTGLJTEMPO)
	 	MLEBIHJT = 1
	 ELSE 
		 IF XXTGL <= MAJU1BLN(MAJU1BLN(MTGLJTEMPO))
		 	MLEBIHJT = 2
		 ELSE 
		 	MLEBIHJT = 3
		 ENDIF 
	 ENDIF 
 ENDIF
 LEBIHJT=MLEBIHJT 
*!*	 IF mnorek='101227624' 
*!*	   MESSAGEBOX('jatuh tempo  : '+TRANSFORM(mlebihjt,'99'))
*!*	   MESSAGEBOX(' tunggak :'+TRANSFORM(vkalipk,'99.99'))
*!*	 endif
 ANGSBULANAN = 'Y'
  mkdhit=&KREDIT->kdhit
 IF MKDHIT = 'K' .OR. MKDHIT = 'L' .OR. MKDHIT = 'M' .OR. MKDHIT = 'F' .OR. MKDHIT = 'H'
 	DNGANGSURAN = 'T'
 ELSE 
	 IF MKDHIT = 'E' .OR. MKDHIT = 'I' .OR. MKDHIT = 'J'
		 ANGSBULANAN = 'T'
	 ENDIF 
	 DNGANGSURAN = 'Y'
 ENDIF 
 

	 
	 IF VKALIPK <= 3.2 
	 	KOLEKTA = '1'
	 	ELSE 
	 	IF (VKALIPK <= 6.2) 
			 KOLEKTA = '2'
	 		ELSE 
	 		KOLEKTA = '3'
			
	 	ENDIF 
	 ENDIF 
	 
	 
	 IF lebihjt > 2
	   kolekta = '4'
	 endif


*** DATA JAMINAN/AGUNAN
  select &cJAMINAN
 STORE 0 TO MNILAIOLD , MPPAP1
 GO TOP
 MTAKSASI = 0
 N = 0
 mjaminan = SPACE(1)
 DO WHILE  .NOT. EOF()
	N = N + 1
 	MNOBERKAS = NOBERKAS
 	
 	mjenis = jenis
 	
	 DO CASE 
		 CASE RTRIM(JENIS) = 'KENDARAAN' OR RTRIM(JENIS) = 'BPKB'
			 CSQL =  ;
			      "select * from pinjaman_jaminan_bpkb where noberkas='" + ALLTRIM(MNOBERKAS) + "'"
			 LCEK = SQLEXEC(OODBC,CSQL,'SMT')
			 IF N = 1
				 IF NOBERKAS = MNOBERKAS AND (EMPTY(TGLAMBIL) .OR. TGLAMBIL > MTGL)
				 MJAMINAN = 'BPKB ' + ALLTRIM(NOBPKB) +' '+ NOPOLISI
			*	 MJAMINAN = 'BPKB ' + ALLTRIM(NOBPKB) + TRANSFORM(NOPOLISI,'@R !!-!!!!-!!'))
				 ELSE 
				 N = 0
				 ENDIF 
			 ELSE 
				 IF NOBERKAS = MNOBERKAS AND (EMPTY(TGLAMBIL) .OR. TGLAMBIL > MTGL)
				 N = N - 1
				 MJAMINAN =  MJAMINAN + ' BPKB ' + ALLTRIM(NOBPKB) +' '+ NOPOLISI

				 ELSE 
				 MJAMINAN =  MJAMINAN + ' BPKB ' + ALLTRIM(NOBPKB) + ' '+ NOPOLISI
		
				 ENDIF 
			 ENDIF 
			 USE 
			
	 CASE RTRIM(JENIS) = ' TANAH' OR RTRIM(JENIS) = 'STPK'
	 
			 CSQL =  ;
			      "select * from pinjaman_jaminan_sertifikat where noberkas='" + ALLTRIM(MNOBERKAS) +  ;
			"'"
			 LCEK = SQLEXEC(OODBC,CSQL,'SMT')
			 IF N = 1
				 IF NOBERKAS = MNOBERKAS AND (EMPTY(TGLAMBIL) .OR. TGLAMBIL > MTGL)
				 MJAMINAN = mjaminan+' STPK  '  + ALLTRIM(NOSERTIFIKAT) + ' ' + ALLTRIM(STR(LUAS,12))
							 ELSE 
				 N = 0
				 ENDIF 
			 ELSE 
				 IF NOBERKAS = MNOBERKAS AND (EMPTY(TGLAMBIL) .OR. TGLAMBIL > MTGL)
				 N = N - 1
				 MJAMINAN = mjaminan+' STPK '  + ALLTRIM(NOSERTIFIKAT) + ' ' + ALLTRIM(STR(LUAS,12))
				
				 ENDIF 
			 ENDIF 
			 USE 
			
	 CASE RTRIM(JENIS) = 'SMB'
		 CSQL =  ;
		      "select * from pinjaman_jaminan_simpanan where noberkas='" + ALLTRIM(MNOBERKAS) +  ;
		"'"
		 LCEK = SQLEXEC(OODBC,CSQL,'SMT')
		 IF N = 1
			 IF NOBERKAS = MNOBERKAS AND (EMPTY(TGLAMBIL) .OR. TGLAMBIL > MTGL)
			 MJAMINAN =  mjaminan+;
			      ALLTRIM(JENIS) + ' AN.' + ALLTRIM(NAMA) + ' ' + TRANSFORM(JUMLAH,'999,999,999')
			 MTAKSASI = MTAKSASI + JUMLAH
			 MNILAIOLD = MNILAIOLD + JUMLAH
			 
			 ELSE 
			 N = 0
			 ENDIF 
		 ELSE 
			 IF NOBERKAS = MNOBERKAS AND (EMPTY(TGLAMBIL) .OR. TGLAMBIL > MTGL)
			 N = N - 1
			  MJAMINAN = mjaminan+ ;
			      ALLTRIM(JENIS) + ' AN.' + ALLTRIM(NAMA) + ' ' + TRANSFORM(JUMLAH,'999,999,999')
			 ELSE 
			 MTAKSASI = MTAKSASI + NOMINAL
			 MNILAIOLD = MNILAIOLD + NOMINAL
			 
			 ENDIF 
		 ENDIF 
		 USE 
	  CASE RTRIM(JENIS) = 'NON'
		 CSQL =  ;
		      "select * from pinjaman_jaminan_non where noberkas='" + ALLTRIM(MNOBERKAS) +  ;
		"'"
		 LCEK = SQLEXEC(OODBC,CSQL,'SMT')
		 IF N = 1
			 IF NOBERKAS = MNOBERKAS AND (EMPTY(TGLAMBIL) .OR. TGLAMBIL > MTGL)
			 MJAMINAN =  mjaminan+ALLTRIM(mJENIS) +' '+  ALLTRIM(NAMA) + ' ' + ALLTRIM(keterangan)
			 
			 
			 ELSE 
			 N = 0
			 ENDIF 
		 ELSE 
			 IF NOBERKAS = MNOBERKAS AND (EMPTY(TGLAMBIL) .OR. TGLAMBIL > MTGL)
			 N = N - 1
			 MJAMINAN =  mjaminan+ALLTRIM(mJENIS) +' '+  ALLTRIM(NAMA) + ' ' + ALLTRIM(keterangan)
			 ELSE 
			
			 
			 ENDIF 
		 ENDIF 
		 USE 
		 
	 OTHERWISE 
	 CSQL =  ;
	      "select * from pinjaman_jaminan_lainnya where noberkas='" + ALLTRIM(MNOBERKAS) +  ;
	"'"
	 LCEK = SQLEXEC(OODBC,CSQL,'SMT')
	 IF N = 1
		 IF NOBERKAS = MNOBERKAS AND (EMPTY(TGLAMBIL) .OR. TGLAMBIL > MTGL)
		  MJAMINAN =  mjaminan+ALLTRIM(mJENIS) +' '+  ALLTRIM(NAMA) + ' ' + ALLTRIM(keterangan)
		
		 MTAKSASI = MTAKSASI + NILAI
		
		 ELSE 
		 N = 0
		 ENDIF 
	 ELSE 
		 IF NOBERKAS = MNOBERKAS AND (EMPTY(TGLAMBIL) .OR. TGLAMBIL > MTGL)
		 N = N - 1
		  MJAMINAN =  mjaminan+ALLTRIM(mJENIS) +  ALLTRIM(NAMA) + ' ' + ALLTRIM(keterangan)
		
		 ELSE 
		 MTAKSASI = MTAKSASI + NILAI
		 
		 ENDIF 
	 ENDIF 
	 USE 
	 
	 ENDCASE 
  SELECT &cJAMINAN
 SKIP 
 ENDDO 
 
 *MJAMINAN = ''
 IF N > 1
* MJAMINAN = ALLTRIM(MJAMINAN) + SPACE(50 - LEN(ALLTRIM(MJAMINAN)))
 MJAMINAN = LEFT(MJAMINAN,60)
 *MJAMINAN = MJAMINAN + ' (' + STR(N,2) + ' Jaminan)'
 
 ELSE 
 MJAMINAN = ALLTRIM(MJAMINAN) + SPACE(50)
 MJAMINAN = LEFT(MJAMINAN,60)
 ENDIF 

MTAKSASI = 0
MPPAP = 0
MPPAP1 = 0
 SELECT SALDOKRD
 APPEND BLANK
  REPLACE norek WITH &KREDIT->norek
  REPLACE tgljtempo WITH &KREDIT->tgljtempo
 REPLACE KOL WITH KOLEKTA
  REPLACE plafon WITH &KREDIT->pokok
 REPLACE PKAWAL WITH MPKAWAL , BGAWAL WITH MBGAWAL
 REPLACE JUMJDWPK WITH JPK , JUMJDWBG WITH JBG
 REPLACE HRSPK WITH MHRSPK , HRSBG WITH MHRSBG
 REPLACE SISAJDWPK WITH MSISAJDWPK , SISAJDWBG WITH MSISAJDWBG
 REPLACE SISAPK WITH IIF(ISNULL(VSISAPK),0,VSISAPK) , SISABG WITH VSISABG , KALIPK WITH  ;
      VKALIPK
 REPLACE KALIBG WITH VKALIBG , ODPK WITH VODPK , ODBG WITH VODBG , TGLODPK WITH VTGLODPK
 REPLACE KALIBYRPK WITH MKLBYRPK , KALIBYRBG WITH MKLBYRBG
 REPLACE TGLODBG WITH VTGLODBG , WJBPK WITH VWJBPK , WJBBG WITH VWJBBG , JDWKE WITH  ;
      VJDWKE
 REPLACE ANGSKE WITH VANGSKE , HARUSPKKE WITH VHARUSPKKE , HARUSBGKE WITH VHARUSBGKE ,  ;
      NJDWPK WITH VNJDWPK
 REPLACE NJDWBG WITH VNJDWBG , MTGLKHBYR WITH VMTGLKHBYR , BYRPK WITH VBYRPK , BYRBG  ;
      WITH VBYRBG
 REPLACE JAMINAN WITH MJAMINAN , TAKSASI WITH MTAKSASI , PPAP WITH  ;
      IIF(ISNULL(MPPAP),0,MPPAP) , PPAP1 WITH IIF(ISNULL(MPPAP1),0,MPPAP1)
  SELECT &kredit
 USE 
  SELECT &ANGSUR
 USE 
  SELECT &JADWAL
 USE 
  SELECT &cJAMINAN
 USE 
 SELECT SALDOKRD
 MDATA = ALIAS()
 SELECT (OLDSELECT)

 RETURN MDATA
ENDPROC







* -------------------
PROCEDURE saldokrd
 PARAMETER MNOREK , XXTGL
 LOCAL MBUNGA , JDWPK , JDWBG , BYRPK , BYRBG , SLDPK , SLDBG , MRATE , WJBPK , WJBBG ,  ;
      JDWKE , ANGSKE , HARUSKE
 LOCAL MSISAPK , MSISABG , KALIPK , KALIBG , ODPK , ODBG , TGLODPK , TGLODBG
 LOCAL NJDWPK , NJDWBG , MSISA , MTGLKHBYR , MHRSPK , MHRSBG , MSISAJDWPK , MSISAJDWBG
 OLDSELECT = SELECT()
 CREATE CURSOR SALDOKRD ( NOREK C ( 25 ) , TGLJTEMPO D , KOL C ( 1 ) , PLAFON N ( 15 ) ,  ;
      PKAWAL N ( 15 ) , BGAWAL N ( 15 ) , SISAPK N ( 15 ) , SISABG N ( 15 ) ,  ;
      HRSPK N ( 15 ) , HRSBG N ( 15 ) , SISAJDWPK N ( 15 ) , SISAJDWBG N  ;
      ( 15 ) , KALIPK N ( 6 , 3 ) , KALIBG N ( 5 , 1 ) , JUMJDWPK N ( 3 ) ,  ;
      JUMJDWBG N ( 3 ) , ODPK N ( 15 ) , ODBG N ( 15 ) , TGLODPK DATE ,  ;
      TGLODBG DATE , WJBPK N ( 15 ) , WJBBG N ( 15 ) , JDWKE INT ( 3 ) , ANGSKE  ;
      INT ( 3 ) , HARUSPKKE INT ( 3 ) , HARUSBGKE INT ( 3 ) , NJDWPK N ( 15  ;
      ) , NJDWBG N ( 15 ) , MTGLKHBYR DATE , BYRPK N ( 15 ) , BYRBG N ( 15 ) ,  ;
      DENDA N ( 10 ) , KALIBYRPK N ( 3 ) , KALIBYRBG N ( 3 ) , JAMINAN C  ;
      ( 100 ) , TAKSASI N ( 15 ) , PPAP N ( 15 ) , PPAP1 N ( 15 ) , BGAKRUAL  ;
      N ( 15 ) , KONTIJENSI N ( 15 ) , ADM N ( 15 ) , PROVISI N ( 15 ) ,  ;
      BIAYA N ( 15 ) )
 KREDIT = SYS(2015)
 ANGSUR = SYS(2015)
 JADWAL = SYS(2015)
 CJAMINAN = SYS(2015)
 CBPKB = SYS(2015)
 CSERTIFIKAT = SYS(2015)
 CSIMPANAN = SYS(2015)
 CLAIN = SYS(2015)
 CSQL = "select * from pinjaman where norek='" + MNOREK + "'"
 LCEK = SQLEXEC(OODBC,CSQL,KREDIT)
 
 IF ISNULL(NOREK)
 	USE 
 	SELECT (OLDSELECT)
 	RETURN 
 ENDIF 
 CSQL =  ;
      "select * from pinjaman_mutasi where norek='" + MNOREK + "' and tanggal<='" +  ;
	   SQLDATE(XXTGL) + "' order by tanggal"
 LCEK = SQLEXEC(OODBC,CSQL,ANGSUR)
 CSQL =  ;
      "select * from pinjaman_jadwal where norek='" + MNOREK + "' order by tanggal"
 LCEK = SQLEXEC(OODBC,CSQL,JADWAL)
 CSQL = "select * from pinjaman_jaminan where norek='" + MNOREK + "'"
 LCEK = SQLEXEC(OODBC,CSQL,CJAMINAN)
  SELECT &ANGSUR
 INDEX ON NOREK + DTOS(TANGGAL) TAG ANGSUR
  SELECT &JADWAL
 INDEX ON NOREK + DTOS(TANGGAL) TAG JADWAL
 SET NEAR ON
  SELECT &KREDIT
 XXTGL = IIF(XXTGL > TGLLUNAS .AND.  .NOT. EMPTY(TGLLUNAS),TGLLUNAS,XXTGL)
 MTGLREALISASI = TANGGAL
 
  SELECT &KREDIT
 STORE 0 TO MBUNGA , JDWPK , JDWBG , BYRPK , BYRBG , SLDPK , SLDBG , MRATE , WJBPK ,  ;
      WJBBG , JDWKE , ANGSKE , HARUSPKKE , HARUSBGKE , MSISAPK , MSISABG ,  ;
      KALIPK , KALIBG , ODPK , ODBG , NJDWPK , NJDWBG , MSISA
 STORE 0 TO VSISAPK, mangbg
 STORE CTOD('  -  -    ') TO TGLODPK , TGLODBG , MTGLKHBYR
 STORE 0 TO JPK , JBG , MPKAWAL , MBGAWAL , MHRSPK , MHRSBG , MPKNOW , MBGNOW
 STORE 0 TO MKLBYRPK , MKLBYRBG , MSISAJDWPK , MSISAJDWBG
 MRATE = RATE
 
 DO CASE 
	CASE KDHIT = 'A' .OR. KDHIT = 'B' .OR. KDHIT = 'D' .OR. KDHIT = 'E' .OR. KDHIT = 'I' .OR.  ;
		 KDHIT = 'J' .OR. KDHIT = 'M'
		 * Hitung jumlah pembayaran
  	  	 select &ANGSUR
		
 		 DO WHILE .NOT. EOF()
 	        IF KODE <>'06' AND kode <>'03'
 		     BYRPK = BYRPK + POKOK  
 		     BYRBG = BYRBG + JASA
 		    ENDIF
 		 SKIP
 		 ENDDO
 		
 		  GO TOP
 		  MTGLAKHIR = TANGGAL
 	   	 SCAN 
 			MTGLAKHIR = MAX(MTGLAKHIR,TANGGAL)
 		 ENDSCAN 
	 	 
	 	 JANGSURAN = BYRPK + BYRBG
	 	 SLDPK = BYRPK
	 	 SLDBG = BYRBG
	 	 TBUNGA = 0
		 select &JADWAL
 		 GO TOP
 		 MANGBG = JASA
 		 DO WHILE  .NOT. EOF()
 			IF XXTGL < AKHIRBLN(TANGGAL)
 				EXIT 
 			ENDIF 
 			IF .T.
 				JDWKE = JDWKE + 1
 				IF SLDPK < POKOK
 					TGLODPK = IIF(EMPTY(TGLODPK),TANGGAL,TGLODPK)
	 				IF SLDPK > 0
	    				KALIPK = KALIPK + ((POKOK - SLDPK) / POKOK)
	    				ODPK = ODPK + (POKOK - SLDPK)
	 				ELSE 
	    				KALIPK = KALIPK + 1
	    				ODPK = ODPK + POKOK
	 				ENDIF 
 				ELSE 
 				    MKLBYRPK = MKLBYRPK + 1
 				ENDIF 
 				SLDPK = SLDPK - (MIN(POKOK,SLDPK))
 			ENDIF 
 			IF .T.
 				IF SLDBG < JASA
 	       			TGLODBG = IIF(EMPTY(TGLODBG),TANGGAL,TGLODBG)
			 		IF SLDBG > 0
			    		KALIBG = KALIBG + ((JASA - SLDBG) / JASA)
			    		ODBG = ODBG + (JASA - SLDBG)
			 		ELSE 
			    		KALIBG = KALIBG + 1
			    		ODBG = ODBG + JASA
			 		ENDIF 
	    		ELSE 
 					MKLBYRBG = MKLBYRBG + 1
 	   			ENDIF 
 				SLDBG = SLDBG - MIN(JASA,SLDBG)
 			ENDIF 
	 		IF TANGGAL <= XXTGL
		 		JDWPK = JDWPK + POKOK
		 		JDWBG = JDWBG + JASA
		 		TBUNGA = TBUNGA + JASA
	 		ENDIF 
	 			JANGSURAN = JANGSURAN - (POKOK + JASA)
 			IF JANGSURAN >= 0
		 		ANGSKE = ANGSKE + 1
 			ENDIF 
 			IF TANGGAL <= AKHIRBLN(XXTGL)
	 			IF POKOK > 0
	 				HARUSPKKE = HARUSPKKE + 1
	 			ENDIF 
		 		IF JASA > 0
		 			HARUSBGKE 																																																																																																																																																																												= HARUSBGKE + 1
		 		ENDIF 
			ENDIF 
 			SKIP 
 		 ENDDO 
	 	 GO TOP
	   	 DO WHILE  .NOT. EOF()
		 	IF POKOK > 0
		 		JPK = JPK + 1
		 	ENDIF 
		 	IF JASA > 0
		 		JBG = JBG + 1
		 	ENDIF 
		 	MPKAWAL = MPKAWAL + POKOK
		 	MBGAWAL = MBGAWAL + JASA
		 	IF TANGGAL < AKHIRBLN(XXTGL)
		 		MHRSPK = MHRSPK + POKOK
		 		MHRSBG = MHRSBG + JASA
		 	ELSE 
		 		MSISAJDWPK = MSISAJDWPK + POKOK
		 		MSISAJDWBG = MSISAJDWBG + JASA
		 	ENDIF 
		 	IF XXTGL < TANGGAL AND TANGGAL < AKHIRBLN(XXTGL)
		 		NJDWPK = POKOK
		 		NJDWBG = JASA
		 	ENDIF 
		 	SKIP 
	 	 ENDDO 
	  	 SELECT &KREDIT
	  	 MSISAPK = POKOK - BYRPK
	  	 MSISABG = JASA - BYRBG

 ENDCASE 
 
  select &KREDIT
 KALIPK = IIF(KALIPK = 0 .AND. ODPK > 0,1,KALIPK)
 KALIBG = IIF(KALIBG = 0 .AND. ODBG > 0,1,KALIBG)
 IF ODPK < 0
 	ODPK = ODPK + WJBPK
 	WJBPK = 0
 ENDIF 
 IF ODBG < 0
 	ODBG = ODBG + WJBBG
 	WJBBG = 0
 ENDIF 
 IF WJBPK > MSISAPK
 	WJBPK = MSISAPK
 ENDIF 
 IF WJBBG > MSISABG
 	WJBBG = MSISABG
 ENDIF 

 
  vlama=jangkawaktu(&KREDIT->tglmulai,&KREDIT->tgljtempo)
   glama=selisihbln(&KREDIT->tglmulai,xxtgl)
IF mangbg=0
   MESSAGEBOX('nomor rekeming : ' +mnorek )
ENDIF

   DO CASE
           * sudah jatuh tempo dan tidak turun jasa
      CASE GLama-vlama > 0 AND YEAR(&KREDIT->tglbupn) = 0  AND vlama = 20
             ket =' satu'
      	    Mhrsbg = mhrsbg + (glama-vlama) * (mangbg)
     		ODBG = MHRSBG - BYRBG 
          * sudah jatuh tempo dan  turun jasa
      CASE GLama-vlama > 0 AND YEAR(&KREDIT->tglbupn) > 0
      	    Mhrsbg = mhrsbg + (glama-vlama) * (mangbg/2)
     		ODBG = MHRSBG - BYRBG 
     		 ket =' dua'
     		* sudah jatuh tempo 
      CASE GLama-vlama > 0
      		Mhrsbg = glama * mangbg
     		ODBG = MHRSBG - BYRBG 
     		
     		 ket =' tiga'
     		* belum jatuh tempo (hitungan bulanan)
     OTHERWISE
      ket =' empat'
           	Mhrsbg = mhrsbg
     		ODBG = MHRSBG - BYRBG 	
   ENDCASE
   
 *  MESSAGEBOX(ket + TRANSFORM(mhrsbg,'999,999'))
   
   * tutup 18 maret 2021
*!*	    IF GLama-vlama > 0 AND YEAR(&KREDIT->tglbupn) = 0
*!*	     Mhrsbg = mhrsbg + (glama-vlama) * (mangbg/2)
*!*	     ODBG = MHRSBG - BYRBG 
*!*	     
*!*	    else
*!*	    
*!*	    MHRDBG = MHRSBG
*!*		ODBG = MHRSBG - BYRBG 
*!*	    ENDIF




*!*	  
*!*	  IF GLAMA-VLAMA > 0  AND YEAR(&KREDIT->tglbupn) = 0
*!*	     MHRSBG = vLAMA * MANGBG
*!*	     ODBG = MHRSBG - BYRBG
*!*	  ELSE
*!*	    
*!*	  ENDIF
*  MESSAGEBOX(mHRSBG)

 VSISAPK = MSISAPK
 VSISABG = MSISABG
 VKALIPK = KALIPK
 VKALIBG = KALIBG
 VODPK = ODPK
 VODBG = ODBG
 VTGLODPK = TGLODPK
 VTGLODBG = TGLODBG
 VWJBPK = WJBPK
 VWJBBG = WJBBG
 VJDWKE = JDWKE
 VANGSKE = ANGSKE
 VHARUSPKKE = HARUSPKKE
 VHARUSBGKE = HARUSBGKE
 VNJDWPK = NJDWPK
 VNJDWBG = NJDWBG
 VMTGLKHBYR = MTGLKHBYR
 VBYRPK = BYRPK
 VBYRBG = BYRBG
 VTAKSASI = 0
 VJAMINAN = ''
 KOLEKTA = '1'
 IF &KREDIT->tgljtempo > xxtgl
     MLEBIHJT = 0
 ELSE 
  	mtgljtempo=&KREDIT->tgljtempo      
	 IF XXTGL >= MTGLJTEMPO AND XXTGL <= MAJU1BLN(MTGLJTEMPO)
	 	MLEBIHJT = 1
	 ELSE 
		 IF XXTGL <= MAJU1BLN(MAJU1BLN(MTGLJTEMPO))
		 	MLEBIHJT = 2
		 ELSE 
		 	MLEBIHJT = 3
		 ENDIF 
	 ENDIF 
 ENDIF
 LEBIHJT=MLEBIHJT 
*!*	 IF mnorek='101227624' 
*!*	   MESSAGEBOX('jatuh tempo  : '+TRANSFORM(mlebihjt,'99'))
*!*	   MESSAGEBOX(' tunggak :'+TRANSFORM(vkalipk,'99.99'))
*!*	 endif
 ANGSBULANAN = 'Y'
  mkdhit=&KREDIT->kdhit
 IF MKDHIT = 'K' .OR. MKDHIT = 'L' .OR. MKDHIT = 'M' .OR. MKDHIT = 'F' .OR. MKDHIT = 'H'
 	DNGANGSURAN = 'T'
 ELSE 
	 IF MKDHIT = 'E' .OR. MKDHIT = 'I' .OR. MKDHIT = 'J'
		 ANGSBULANAN = 'T'
	 ENDIF 
	 DNGANGSURAN = 'Y'
 ENDIF 
 
** Perhitungan nilai kolekta
*!*   02122020 rumus kolekta di sesuikan dengan clipper jatauh tempo di gunakan khusus setelah 2 bulan	
*!*		 IF VKALIPK <= 3.2 AND LEBIHJT = 0
*!*		 	KOLEKTA = '1'
*!*		 	ELSE 
*!*		 	IF (VKALIPK <= 6.2) .OR. LEBIHJT = 1
*!*				 KOLEKTA = '2'
*!*		 		ELSE 
*!*		 		IF (VKALIPK <= 12.2 ) .OR. LEBIHJT = 2
*!*		 			KOLEKTA = '3'
*!*		 		ELSE 
*!*		 			KOLEKTA = '4'
*!*		 		ENDIF 
*!*		 	ENDIF 
*!*		 ENDIF 
	 
	 IF VKALIPK <= 3 
	 	KOLEKTA = '1'
	 	ELSE 
	 	IF (VKALIPK <= 6) 
			 KOLEKTA = '2'
	 		ELSE 
	 		KOLEKTA = '3'
			
	 	ENDIF 
	 ENDIF 
	 
	 
	 IF lebihjt > 2
	   kolekta = '4'
	 endif


*** DATA JAMINAN/AGUNAN
*!*	  select &cJAMINAN
*!*	 STORE 0 TO MNILAIOLD , MPPAP1
*!*	 GO TOP
*!*	 MTAKSASI = 0
*!*	 N = 0
*!*	 DO WHILE  .NOT. EOF()
*!*	 N = N + 1
*!*	 MNOBERKAS = NOBERKAS
*!*	 DO CASE 
*!*	 CASE RTRIM(JENIS) = 'KENDARAAN'
*!*	 CSQL =  ;
*!*	      "select * from pinjaman_jaminan_bpkb where noberkas='" + ALLTRIM(MNOBERKAS) + "'"
*!*	 LCEK = SQLEXEC(OODBC,CSQL,'SMT')
*!*	 IF N = 1
*!*	 IF NOBERKAS = MNOBERKAS AND (EMPTY(TGLAMBIL) .OR. TGLAMBIL > MTGL)
*!*	 MJAMINAN =  ;
*!*	      'KENDARAAN ' +  ;
*!*	ALLTRIM(ALLTRIM(MERK) + ' ' + ALLTRIM(TYPE) + ' ' + TAHUN + ' ' + ALLTRIM(NOBPKB) +  ;
*!*	TRANSFORM(NOPOLISI,'@R !!-!!!!-!!'))
*!*	 MNILAIOLD = MNILAIOLD + (NILAI * 0.75)
*!*	 MTAKSASI = MTAKSASI + NILAI
*!*	 CSQL =  ;
*!*	      "select ket2,ket3 from setsandi where kode='P009' and sandi='" + PENGIKATAN + "'"
*!*	 LCEK = SQLEXEC(OODBC,CSQL,'SMT1')
*!*	 MFIELD = ALLTRIM(KET2)
*!*	 MFIELD = IIF(EMPTY(MFIELD),'NILAI',MFIELD)
*!*	 MPROSEN = VAL(KET3)
*!*	 USE 
*!*	 SELECT SMT
*!*	  mppap1=mppap1+(&mField*(mprosen/100))
*!*	 ELSE 
*!*	 N = 0
*!*	 ENDIF 
*!*	 ELSE 
*!*	 IF NOBERKAS = MNOBERKAS AND (EMPTY(TGLAMBIL) .OR. TGLAMBIL > MTGL)
*!*	 N = N - 1
*!*	 ELSE 
*!*	 MNILAIOLD = MNILAIOLD + (NILAI * 0.75)
*!*	 MTAKSASI = MTAKSASI + NILAI
*!*	 CSQL =  ;
*!*	      "select ket2,ket3 from setsandi where kode='P009' and sandi='" + PENGIKATAN + "'"
*!*	 LCEK = SQLEXEC(OODBC,CSQL,'SMT1')
*!*	 MFIELD = ALLTRIM(KET2)
*!*	 MFIELD = IIF(EMPTY(MFIELD),'NILAI',MFIELD)
*!*	 MPROSEN = VAL(KET3)
*!*	 USE 
*!*	 SELECT SMT
*!*	  mppap1=mppap1+(&mField*(mprosen/100))
*!*	 ENDIF 
*!*	 ENDIF 
*!*	 USE 
*!*	 CASE RTRIM(JENIS) = 'TANAH'
*!*	 CSQL =  ;
*!*	      "select * from pinjaman_jaminan_sertifikat where noberkas='" + ALLTRIM(MNOBERKAS) +  ;
*!*	"'"
*!*	 LCEK = SQLEXEC(OODBC,CSQL,'SMT')
*!*	 IF N = 1
*!*	 IF NOBERKAS = MNOBERKAS AND (EMPTY(TGLAMBIL) .OR. TGLAMBIL > MTGL)
*!*	 MJAMINAN =  ;
*!*	      'TANAH ' + ALLTRIM(STATUS) + ' ' + ALLTRIM(NOSERTIFIKAT) + ' ' +  ;
*!*	ALLTRIM(STR(LUAS,12))
*!*	 MTAKSASI = MTAKSASI + NILAI
*!*	 MNILAIOLD = MNILAIOLD + (NILAI * 0.75)
*!*	 CSQL =  ;
*!*	      "select ket2,ket3 from setsandi where kode='P010' and sandi='" + PENGIKATAN + "'"
*!*	 LCEK = SQLEXEC(OODBC,CSQL,'SMT1')
*!*	 MFIELD = ALLTRIM(KET2)
*!*	 MFIELD = IIF(EMPTY(MFIELD),'NILAI',MFIELD)
*!*	 MPROSEN = VAL(KET3)
*!*	 USE 
*!*	 SELECT SMT
*!*	  mppap1=mppap1+(&mField*(mprosen/100))
*!*	 ELSE 
*!*	 N = 0
*!*	 ENDIF 
*!*	 ELSE 
*!*	 IF NOBERKAS = MNOBERKAS AND (EMPTY(TGLAMBIL) .OR. TGLAMBIL > MTGL)
*!*	 N = N - 1
*!*	 ELSE 
*!*	 MNILAIOLD = MNILAIOLD + (NILAI * 0.75)
*!*	 MTAKSASI = MTAKSASI + NILAI
*!*	 CSQL =  ;
*!*	      "select ket2,ket3 from setsandi where kode='P010' and sandi='" + PENGIKATAN + "'"
*!*	 LCEK = SQLEXEC(OODBC,CSQL,'SMT1')
*!*	 MFIELD = ALLTRIM(KET2)
*!*	 MFIELD = IIF(EMPTY(MFIELD),'NILAI',MFIELD)
*!*	 MPROSEN = VAL(KET3)
*!*	 USE 
*!*	 SELECT SMT
*!*	  mppap1=mppap1+(&mField*(mprosen/100))
*!*	 ENDIF 
*!*	 ENDIF 
*!*	 USE 
*!*	 CASE RTRIM(JENIS) = 'SIMPANAN'
*!*	 CSQL =  ;
*!*	      "select * from pinjaman_jaminan_simpanan where noberkas='" + ALLTRIM(MNOBERKAS) +  ;
*!*	"'"
*!*	 LCEK = SQLEXEC(OODBC,CSQL,'SMT')
*!*	 IF N = 1
*!*	 IF NOBERKAS = MNOBERKAS AND (EMPTY(TGLAMBIL) .OR. TGLAMBIL > MTGL)
*!*	 MJAMINAN =  ;
*!*	      ALLTRIM(JENIS) + ' AN.' + ALLTRIM(NAMA) + ' ' + TRANSFORM(JUMLAH,'999,999,999,999')
*!*	 MTAKSASI = MTAKSASI + JUMLAH
*!*	 MNILAIOLD = MNILAIOLD + JUMLAH
*!*	 CSQL =  ;
*!*	      "select ket2,ket3 from setsandi where kode='P011' and sandi='" + PENGIKATAN + "'"
*!*	 LCEK = SQLEXEC(OODBC,CSQL,'SMT1')
*!*	 MFIELD = ALLTRIM(KET2)
*!*	 MFIELD = IIF(EMPTY(MFIELD),'NOMINAL',MFIELD)
*!*	 MPROSEN = VAL(KET3)
*!*	 USE 
*!*	 SELECT SMT
*!*	  mppap1=mppap1+(&mField*(mprosen/100))
*!*	 ELSE 
*!*	 N = 0
*!*	 ENDIF 
*!*	 ELSE 
*!*	 IF NOBERKAS = MNOBERKAS AND (EMPTY(TGLAMBIL) .OR. TGLAMBIL > MTGL)
*!*	 N = N - 1
*!*	 ELSE 
*!*	 MTAKSASI = MTAKSASI + NOMINAL
*!*	 MNILAIOLD = MNILAIOLD + NOMINAL
*!*	 CSQL =  ;
*!*	      "select ket2,ket3 from setsandi where kode='P011' and sandi='" + PENGIKATAN + "'"
*!*	 LCEK = SQLEXEC(OODBC,CSQL,'SMT1')
*!*	 MFIELD = ALLTRIM(KET2)
*!*	 MFIELD = IIF(EMPTY(MFIELD),'NOMINAL',MFIELD)
*!*	 MPROSEN = VAL(KET3)
*!*	 USE 
*!*	 SELECT SMT
*!*	  mppap1=mppap1+(&mField*(mprosen/100))
*!*	 ENDIF 
*!*	 ENDIF 
*!*	 USE 
*!*	 OTHERWISE 
*!*	 CSQL =  ;
*!*	      "select * from pinjaman_jaminan_lainnya where noberkas='" + ALLTRIM(MNOBERKAS) +  ;
*!*	"'"
*!*	 LCEK = SQLEXEC(OODBC,CSQL,'SMT')
*!*	 IF N = 1
*!*	 IF NOBERKAS = MNOBERKAS AND (EMPTY(TGLAMBIL) .OR. TGLAMBIL > MTGL)
*!*	 MJAMINAN = ALLTRIM(KETERANGAN)
*!*	 MTAKSASI = MTAKSASI + NILAI
*!*	 CSQL =  ;
*!*	      "select ket2,ket3 from setsandi where kode='P012' and sandi='" + PENGIKATAN + "'"
*!*	 LCEK = SQLEXEC(OODBC,CSQL,'SMT1')
*!*	 MFIELD = ALLTRIM(KET2)
*!*	 MFIELD = IIF(EMPTY(MFIELD),'NILAI',MFIELD)
*!*	 MPROSEN = VAL(KET3)
*!*	 USE 
*!*	 SELECT SMT
*!*	  mppap1=mppap1+(&mField*(mprosen/100))
*!*	 ELSE 
*!*	 N = 0
*!*	 ENDIF 
*!*	 ELSE 
*!*	 IF NOBERKAS = MNOBERKAS AND (EMPTY(TGLAMBIL) .OR. TGLAMBIL > MTGL)
*!*	 N = N - 1
*!*	 ELSE 
*!*	 MTAKSASI = MTAKSASI + NILAI
*!*	 CSQL =  ;
*!*	      "select ket2,ket3 from setsandi where kode='P012' and sandi='" + PENGIKATAN + "'"
*!*	 LCEK = SQLEXEC(OODBC,CSQL,'SMT1')
*!*	 MFIELD = ALLTRIM(KET2)
*!*	 MFIELD = IIF(EMPTY(MFIELD),'NILAI',MFIELD)
*!*	 MPROSEN = VAL(KET3)
*!*	 USE 
*!*	 SELECT SMT
*!*	  mppap1=mppap1+(&mField*(mprosen/100))
*!*	 ENDIF 
*!*	 ENDIF 
*!*	 USE 
*!*	 ENDCASE 
*!*	  SELECT &cJAMINAN
*!*	 SKIP 
*!*	 ENDDO 
*!*	 MJAMINAN = ''
*!*	 IF N > 1
*!*	 MJAMINAN = ALLTRIM(MJAMINAN) + SPACE(50 - LEN(ALLTRIM(MJAMINAN)))
*!*	 MJAMINAN = LEFT(MJAMINAN,37)
*!*	 MJAMINAN = MJAMINAN + ' (' + STR(N,2) + ' Jaminan)'
*!*	 ELSE 
*!*	 MJAMINAN = ALLTRIM(MJAMINAN) + SPACE(50)
*!*	 MJAMINAN = LEFT(MJAMINAN,50)
*!*	 ENDIF 
 
 ** pegnisian nialai ppap
 
*!*	 DO CASE 
*!*	 CASE KOLEKTA = '1'
*!*	 MPPAP = 0.005 * MSISAPK
*!*	 MPPAPOLD = MPPAP
*!*	 CASE KOLEKTA = '2'
*!*	 MPPAP = IIF(MSISAPK - MPPAP1 < 0,0,0.1 * (MSISAPK - MPPAP1))
*!*	 MPPAPOLD = IIF(MSISAPK - MNILAIOLD < 0,0,0.1 * (MSISAPK - MNILAIOLD))
*!*	 CASE KOLEKTA = '3'
*!*	 MPPAP = IIF(MSISAPK - MPPAP1 < 0,0,0.5 * (MSISAPK - MPPAP1))
*!*	 MPPAPOLD = IIF(MSISAPK - MNILAIOLD < 0,0,0.5 * (MSISAPK - MNILAIOLD))
*!*	 CASE KOLEKTA = '4'
*!*	 MPPAP = IIF(MSISAPK - MPPAP1 < 0,0,1 * (MSISAPK - MPPAP1))
*!*	 MPPAPOLD = IIF(MSISAPK - MNILAIOLD < 0,0,1 * (MSISAPK - MNILAIOLD))
*!*	 ENDCASE 

MJAMINAN = SPACE(5)
MTAKSASI = 0
MPPAP = 0
MPPAP1 = 0
 SELECT SALDOKRD
 APPEND BLANK
  REPLACE norek WITH &KREDIT->norek
  REPLACE tgljtempo WITH &KREDIT->tgljtempo
 REPLACE KOL WITH KOLEKTA
  REPLACE plafon WITH &KREDIT->pokok
 REPLACE PKAWAL WITH MPKAWAL , BGAWAL WITH MBGAWAL
 REPLACE JUMJDWPK WITH JPK , JUMJDWBG WITH JBG
 REPLACE HRSPK WITH MHRSPK , HRSBG WITH MHRSBG
 REPLACE SISAJDWPK WITH MSISAJDWPK , SISAJDWBG WITH MSISAJDWBG
 REPLACE SISAPK WITH IIF(ISNULL(VSISAPK),0,VSISAPK) , SISABG WITH VSISABG , KALIPK WITH  ;
      VKALIPK
 REPLACE KALIBG WITH VKALIBG , ODPK WITH VODPK , ODBG WITH VODBG , TGLODPK WITH VTGLODPK
 REPLACE KALIBYRPK WITH MKLBYRPK , KALIBYRBG WITH MKLBYRBG
 REPLACE TGLODBG WITH VTGLODBG , WJBPK WITH VWJBPK , WJBBG WITH VWJBBG , JDWKE WITH  ;
      VJDWKE
 REPLACE ANGSKE WITH VANGSKE , HARUSPKKE WITH VHARUSPKKE , HARUSBGKE WITH VHARUSBGKE ,  ;
      NJDWPK WITH VNJDWPK
 REPLACE NJDWBG WITH VNJDWBG , MTGLKHBYR WITH VMTGLKHBYR , BYRPK WITH VBYRPK , BYRBG  ;
      WITH VBYRBG
 REPLACE JAMINAN WITH MJAMINAN , TAKSASI WITH MTAKSASI , PPAP WITH  ;
      IIF(ISNULL(MPPAP),0,MPPAP) , PPAP1 WITH IIF(ISNULL(MPPAP1),0,MPPAP1)
  SELECT &kredit
 USE 
  SELECT &ANGSUR
 USE 
  SELECT &JADWAL
 USE 
  SELECT &cJAMINAN
 USE 
 SELECT SALDOKRD
 MDATA = ALIAS()
 SELECT (OLDSELECT)

 RETURN MDATA
ENDPROC







*------saldokrd original
PROCEDURE orisaldokrd
 PARAMETER MNOREK , XXTGL
 LOCAL MBUNGA , JDWPK , JDWBG , BYRPK , BYRBG , SLDPK , SLDBG , MRATE , WJBPK , WJBBG ,  ;
      JDWKE , ANGSKE , HARUSKE
 LOCAL MSISAPK , MSISABG , KALIPK , KALIBG , ODPK , ODBG , TGLODPK , TGLODBG
 LOCAL NJDWPK , NJDWBG , MSISA , MTGLKHBYR , MHRSPK , MHRSBG , MSISAJDWPK , MSISAJDWBG
 OLDSELECT = SELECT()
 CREATE CURSOR SALDOKRD ( NOREK C ( 25 ) , TGLJTEMPO D , KOL C ( 1 ) , PLAFON N ( 15 ) ,  ;
      PKAWAL N ( 15 ) , BGAWAL N ( 15 ) , SISAPK N ( 15 ) , SISABG N ( 15 ) ,  ;
      HRSPK N ( 15 ) , HRSBG N ( 15 ) , SISAJDWPK N ( 15 ) , SISAJDWBG N  ;
      ( 15 ) , KALIPK N ( 6 , 3 ) , KALIBG N ( 5 , 1 ) , JUMJDWPK N ( 3 ) ,  ;
      JUMJDWBG N ( 3 ) , ODPK N ( 15 ) , ODBG N ( 15 ) , TGLODPK DATE ,  ;
      TGLODBG DATE , WJBPK N ( 15 ) , WJBBG N ( 15 ) , JDWKE INT ( 3 ) , ANGSKE  ;
      INT ( 3 ) , HARUSPKKE INT ( 3 ) , HARUSBGKE INT ( 3 ) , NJDWPK N ( 15  ;
      ) , NJDWBG N ( 15 ) , MTGLKHBYR DATE , BYRPK N ( 15 ) , BYRBG N ( 15 ) ,  ;
      DENDA N ( 10 ) , KALIBYRPK N ( 3 ) , KALIBYRBG N ( 3 ) , JAMINAN C  ;
      ( 100 ) , TAKSASI N ( 15 ) , PPAP N ( 15 ) , PPAP1 N ( 15 ) , BGAKRUAL  ;
      N ( 15 ) , KONTIJENSI N ( 15 ) , ADM N ( 15 ) , PROVISI N ( 15 ) ,  ;
      BIAYA N ( 15 ) )
 KREDIT = SYS(2015)
 ANGSUR = SYS(2015)
 JADWAL = SYS(2015)
 CJAMINAN = SYS(2015)
 CBPKB = SYS(2015)
 CSERTIFIKAT = SYS(2015)
 CSIMPANAN = SYS(2015)
 CLAIN = SYS(2015)
 CSQL = "select * from pinjaman where norek='" + MNOREK + "'"
 LCEK = SQLEXEC(OODBC,CSQL,KREDIT)
 
 IF ISNULL(NOREK)
 	USE 
 	SELECT (OLDSELECT)
 	RETURN 
 ENDIF 
 CSQL =  ;
      "select * from pinjaman_mutasi where norek='" + MNOREK + "' and tanggal<='" +  ;
	   SQLDATE(XXTGL) + "' order by tanggal"
 LCEK = SQLEXEC(OODBC,CSQL,ANGSUR)
 CSQL =  ;
      "select * from pinjaman_jadwal where norek='" + MNOREK + "' order by tanggal"
 LCEK = SQLEXEC(OODBC,CSQL,JADWAL)
 CSQL = "select * from pinjaman_jaminan where norek='" + MNOREK + "'"
 LCEK = SQLEXEC(OODBC,CSQL,CJAMINAN)
  SELECT &ANGSUR
 INDEX ON NOREK + DTOS(TANGGAL) TAG ANGSUR
  SELECT &JADWAL
 INDEX ON NOREK + DTOS(TANGGAL) TAG JADWAL
 SET NEAR ON
  SELECT &KREDIT
 XXTGL = IIF(XXTGL > TGLLUNAS .AND.  .NOT. EMPTY(TGLLUNAS),TGLLUNAS,XXTGL)
 MTGLREALISASI = TANGGAL
 
  SELECT &KREDIT
 STORE 0 TO MBUNGA , JDWPK , JDWBG , BYRPK , BYRBG , SLDPK , SLDBG , MRATE , WJBPK ,  ;
      WJBBG , JDWKE , ANGSKE , HARUSPKKE , HARUSBGKE , MSISAPK , MSISABG ,  ;
      KALIPK , KALIBG , ODPK , ODBG , NJDWPK , NJDWBG , MSISA
 STORE 0 TO VSISAPK
 STORE CTOD('  -  -    ') TO TGLODPK , TGLODBG , MTGLKHBYR
 STORE 0 TO JPK , JBG , MPKAWAL , MBGAWAL , MHRSPK , MHRSBG , MPKNOW , MBGNOW
 STORE 0 TO MKLBYRPK , MKLBYRBG , MSISAJDWPK , MSISAJDWBG
 MRATE = RATE
 
 DO CASE 
	CASE KDHIT = 'A' .OR. KDHIT = 'B' .OR. KDHIT = 'D' .OR. KDHIT = 'E' .OR. KDHIT = 'I' .OR.  ;
		 KDHIT = 'J' .OR. KDHIT = 'M'
  	  	 select &ANGSUR
 		 SUM TO BYRPK POKOK
 		 SUM TO BYRBG JASA
 	  	 GO TOP
 		 MTGLAKHIR = TANGGAL
 	   	 SCAN 
 			MTGLAKHIR = MAX(MTGLAKHIR,TANGGAL)
 		 ENDSCAN 
	 	 
	 	 JANGSURAN = BYRPK + BYRBG
	 	 SLDPK = BYRPK
	 	 SLDBG = BYRBG
	 	 TBUNGA = 0
		 select &JADWAL
 		 GO TOP
 		 MANGBG = JASA
 		 DO WHILE  .NOT. EOF()
 			IF XXTGL < TANGGAL
 				EXIT 
 			ENDIF 
 			IF .T.
 				JDWKE = JDWKE + 1
 				IF SLDPK < POKOK
 					TGLODPK = IIF(EMPTY(TGLODPK),TANGGAL,TGLODPK)
	 				IF SLDPK > 0
	    				KALIPK = KALIPK + ((POKOK - SLDPK) / POKOK)
	    				ODPK = ODPK + (POKOK - SLDPK)
	 				ELSE 
	    				KALIPK = KALIPK + 1
	    				ODPK = ODPK + POKOK
	 				ENDIF 
 				ELSE 
 				    MKLBYRPK = MKLBYRPK + 1
 				ENDIF 
 				SLDPK = SLDPK - (MIN(POKOK,SLDPK))
 			ENDIF 
 			IF .T.
 				IF SLDBG < JASA
 	       			TGLODBG = IIF(EMPTY(TGLODBG),TANGGAL,TGLODBG)
			 		IF SLDBG > 0
			    		KALIBG = KALIBG + ((JASA - SLDBG) / JASA)
			    		ODBG = ODBG + (JASA - SLDBG)
			 		ELSE 
			    		KALIBG = KALIBG + 1
			    		ODBG = ODBG + JASA
			 		ENDIF 
	    		ELSE 
 					MKLBYRBG = MKLBYRBG + 1
 	   			ENDIF 
 				SLDBG = SLDBG - MIN(JASA,SLDBG)
 			ENDIF 
	 		IF TANGGAL <= XXTGL
		 		JDWPK = JDWPK + POKOK
		 		JDWBG = JDWBG + JASA
		 		TBUNGA = TBUNGA + JASA
	 		ENDIF 
	 			JANGSURAN = JANGSURAN - (POKOK + JASA)
 			IF JANGSURAN >= 0
		 		ANGSKE = ANGSKE + 1
 			ENDIF 
 			IF TANGGAL <= AKHIRBLN(XXTGL)
	 			IF POKOK > 0
	 				HARUSPKKE = HARUSPKKE + 1
	 			ENDIF 
		 		IF JASA > 0
		 			HARUSBGKE 																																																																																																																																																																												= HARUSBGKE + 1
		 		ENDIF 
			ENDIF 
 			SKIP 
 		 ENDDO 
	 	 GO TOP
	   	 DO WHILE  .NOT. EOF()
		 	IF POKOK > 0
		 		JPK = JPK + 1
		 	ENDIF 
		 	IF JASA > 0
		 		JBG = JBG + 1
		 	ENDIF 
		 	MPKAWAL = MPKAWAL + POKOK
		 	MBGAWAL = MBGAWAL + JASA
		 	IF TANGGAL < AWALBLN(XXTGL)
		 		MHRSPK = MHRSPK + POKOK
		 		MHRSBG = MHRSBG + JASA
		 	ELSE 
		 		MSISAJDWPK = MSISAJDWPK + POKOK
		 		MSISAJDWBG = MSISAJDWBG + JASA
		 	ENDIF 
		 	IF XXTGL < TANGGAL AND TANGGAL < AKHIRBLN(XXTGL)
		 		NJDWPK = POKOK
		 		NJDWBG = JASA
		 	ENDIF 
		 	SKIP 
	 	 ENDDO 
	  	 SELECT &KREDIT
	  	 MSISAPK = POKOK - BYRPK
	  	 MSISABG = JASA - BYRBG
 CASE KDHIT = 'C'
	 select &ANGSUR
	 SUM TO BYRPK POKOK
	 SUM TO BYRBG JASA
	 GO TOP
	 MTGLAKHIR = TANGGAL
	 SCAN 
	 MTGLAKHIR = MAX(MTGLAKHIR,TANGGAL)
	 ENDSCAN 
	 JANGSURAN = BYRPK + BYRBG
	 SLDPK = BYRPK
	 SLDBG = BYRBG
	 TBUNGA = 0
	  select &JADWAL
	 GO TOP
	 MANGBG = JASA
	 DO WHILE  .NOT. EOF()
	 IF XXTGL < TANGGAL
	 EXIT 
	 ENDIF 
	 IF .T.
	 JDWKE = JDWKE + 1
	 IF SLDPK < POKOK
	 TGLODPK = IIF(EMPTY(TGLODPK),TANGGAL,TGLODPK)
	 IF SLDPK > 0
	    KALIPK = KALIPK + ((POKOK - SLDPK) / POKOK)
	    ODPK = ODPK + (POKOK - SLDPK)
	 ELSE 
	    KALIPK = KALIPK + 1
	    ODPK = ODPK + POKOK
	 ENDIF 
	 ELSE 
	 IF POKOK > 0
	    MKLBYRPK = MKLBYRPK + 1
	 ENDIF 
	 ENDIF 
	 SLDPK = SLDPK - (MIN(POKOK,SLDPK))
	 ENDIF 
	 IF .T.
	 IF SLDBG < JASA
	 TGLODBG = IIF(EMPTY(TGLODBG),TANGGAL,TGLODBG)
	 IF SLDBG > 0
	    KALIBG = KALIBG + ((JASA - SLDBG) / JASA)
	    ODBG = ODBG + (JASA - SLDBG)
	 ELSE 
	    KALIBG = KALIBG + 1
	    ODBG = ODBG + JASA
	 ENDIF 
	 ELSE 
	 IF JASA > 0
	    MKLBYRBG = MKLBYRBG + 1
	 ENDIF 
	 ENDIF 
	 SLDBG = SLDBG - MIN(JASA,SLDBG)
	 ENDIF 
	 IF TANGGAL <= XXTGL
	 JDWPK = JDWPK + POKOK
	 JDWBG = JDWBG + JASA
	 TBUNGA = TBUNGA + JASA
	 ENDIF 
	 JANGSURAN = JANGSURAN - (POKOK + JASA)
	 IF JANGSURAN >= 0
	 ANGSKE = ANGSKE + 1
	 ENDIF 
	 IF TANGGAL <= AKHIRBLN(XXTGL)
	 IF POKOK > 0
	 HARUSPKKE = HARUSPKKE + 1
	 ENDIF 
	 IF JASA > 0
	 HARUSBGKE = HARUSBGKE + 1
	 ENDIF 
	 ENDIF 
	 SKIP 
	 ENDDO 
	 GO TOP
	 DO WHILE  .NOT. EOF()
	 IF POKOK > 0
	 JPK = JPK + 1
	 ENDIF 
	 IF JASA > 0
	 JBG = JBG + 1
	 ENDIF 
	 MPKAWAL = MPKAWAL + POKOK
	 MBGAWAL = MBGAWAL + JASA
	 IF TANGGAL < AWALBLN(XXTGL)
	 MHRSPK = MHRSPK + POKOK
	 MHRSBG = MHRSBG + JASA
	 ELSE 
	 MSISAJDWPK = MSISAJDWPK + POKOK
	 MSISAJDWBG = MSISAJDWBG + JASA
	 ENDIF 
	 IF XXTGL < TANGGAL AND TANGGAL < AKHIRBLN(XXTGL)
	 NJDWPK = POKOK
	 NJDWBG = JASA
	 ENDIF 
	 SKIP 
	 ENDDO 
	  SELECT &KREDIT
	 MSISAPK = POKOK - BYRPK
	 MSISABG = JASA - BYRBG
	 CASE KDHIT = 'F' .OR. KDHIT = 'G'
	 PKPINJ = POKOK
	 TGLPINJ = TANGGAL
	 TGLANGSURPK = TANGGAL
	 TGLANGSURBG = TANGGAL
	 MRATE = RATE
	 MBG = 0
	 STORE 0 TO BYRPK , BYRBG , JMLMACRO
	  select &ANGSUR
	 GO TOP
	 DO WHILE .T.
	  tglpinj=maju1bln(tglpinj,&KREDIT->tanggal)
	 MBG = 0
	  select &ANGSUR
	 TGLHIT = TGLPINJ
	 IF  .NOT. EOF() AND NOREK = MNOREK AND TANGGAL <= TGLPINJ AND TANGGAL <= XXTGL
	 DO WHILE  .NOT. EOF()
	 IF NOREK <> MNOREK .OR. TANGGAL > TGLPINJ .OR. TANGGAL > XXTGL
	    EXIT 
	 ENDIF 
	 IF POKOK > 0
	    PKPINJ = PKPINJ - POKOK
	    TGLHIT = TANGGAL
	 ENDIF 
	 MBG = ROUND((MRATE / 100) * PKPINJ,0)
	 BYRPK = BYRPK + POKOK
	 BYRBG = BYRBG + JASA
	 SKIP 
	 ENDDO 
	 ELSE 
	 MBG = ROUND((MRATE / 100) * PKPINJ,0)
	 ENDIF 
	 IF TGLPINJ > AKHIRBLN(XXTGL)
	 EXIT 
	 ENDIF 
	 JMLMACRO = JMLMACRO + 1
	 V = ALLTRIM(STR(JMLMACRO))
	  jdwCtgl&v=tglpinj
	  jdwCpk&v=iif(&KREDIT->tgljtempo<=tglpinj,pkpinj,0)
	  jdwCbg&v=mbg
	 ENDDO 
	 JANGSURAN = BYRBG
	  select &ANGSUR
	 GO TOP
	 MJDWPK = 0
	 MJDWBG = 0
	 STORE 0 TO MBYRPK , MBYRBG
	 DO WHILE  .NOT. EOF()
	 IF NOREK <> MNOREK .OR. TANGGAL > XXTGL
	 EXIT 
	 ENDIF 
	 MBYRPK = MBYRPK + POKOK
	 MBYRBG = MBYRBG + JASA
	 MTGLKHBYR = TANGGAL
	 SKIP 
	 ENDDO 
	 VKD = 1
	 TGLANGSURPK = CTOD('  -  -    ')
	 TGLANGSURBG = CTOD('  -  -    ')
	 FOR AKE = 1 TO JMLMACRO
	 V = ALLTRIM(STR(AKE))
	  jAngsuran=jAngsuran-jdwCbg&v  
	 IF JANGSURAN >= 0
	 ANGSKE = ANGSKE + 1
	 ELSE 
	 MKLBYRBG = MKLBYRBG + 1
	 ENDIF 
	  if jdwCtgl&v<=akhirbln(xxtgl) 
	  IF jdwCpk&v>0 
	 HARUSPKKE = HARUSPKKE + 1
	 ENDIF 
	  IF jdwCbg&v>0
	 HARUSBGKE = HARUSBGKE + 1
	 ENDIF 
	 ENDIF 
	  if month(jdwCtgl&v)=month(xxtgl) .and. year(jdwCtgl&v)=year(xxtgl)
	  Njdwpk=jdwCpk&v  
	  Njdwbg=jdwCbg&v  
	  wjbbg=jdwCbg&v  
	  wjbbg=iif(day(xxtgl)<=day(jdwCtgl&v),wjbbg,0)
	 ENDIF 
	 JDWKE = JDWKE + 1
	  mjdwpk=mjdwpk+jdwCpk&v
	  mjdwbg=mjdwbg+jdwCbg&v
	  tglakhjdw=jdwCtgl&v
	  if round(mbyrbg,0)<round(jdwCbg&v,0) .and.empty(tglangsurbg)
	  tglangsurbg=jdwCtgl&v
	 ENDIF 
	  if round(mbyrbg,0)<round(jdwCbg&v,0)
	  tglodbg=iif(empty(tglodbg),jdwCtgl&v,tglodbg)
	 IF MBYRBG > 0
	  odbg=odbg+(round(jdwCbg&v,0)-mbyrbg)
	 ELSE 
	 KALIBG = KALIBG + 1
	  odbg=odbg+round(jdwCbg&v,0)
	 ENDIF 
	 ENDIF 
	  mbyrbg=mbyrbg-jdwCbg&v
	 ENDFOR 
	 ODBG = IIF(WJBBG > 0,MAX(ODBG - WJBBG,0),ODBG)
	  msisapk=&KREDIT->pokok-byrpk
	 MSISABG = MJDWBG - MBYRBG
	  if xxtgl>&KREDIT->tgljtempo
	 KALIPK = 1
	 ODPK = MSISAPK
	  tglodpk=&KREDIT->tgljtempo
	 WJBPK = 0
	 ELSE 
	 KALIPK = 0
	 ODPK = 0
	 ENDIF 
 CASE KDHIT = 'H'
	 pkpinj=&KREDIT->pokok
	 tglpinj=&KREDIT->tanggal
	 tglangsurpk=&KREDIT->tanggal
	 tglangsurbg =&KREDIT->tanggal
	 MBG = 0
	 JMLHR = 0
	 STORE 0 TO BYRPK , BYRBG , JMLMACRO , JDWC
	 CSQL =  ;
	      "select MAX(tanggal) as tanggal from pinjaman_mutasi where norek='" + MNOREK +  ;
			"' and tanggal<='" + SQLDATE(XXTGL) + "' and kode='" + DEFAPINJASA +  ;
			"' group by norek"
	 	LCEK = SQLEXEC(OODBC,CSQL,'smt')
	 MTGLBYRBG = IIF(ISNULL(TANGGAL),XXTGL,TANGGAL)
	 TGLANGSURBG = IIF(EMPTY(MTGLBYRBG),XXTGL,MTGLBYRBG)
	 CSQL =  ;
	      "select MAX(tanggal) as tanggal from pinjaman_mutasi where norek='" + MNOREK +  ;
			"' and tanggal<='" + SQLDATE(XXTGL) + "' and kode<>'" + DEFAPINJASA +  ;
			"' group by norek"
	 	LCEK = SQLEXEC(OODBC,CSQL,'smt')
	 MTGLBYRPK = IIF(ISNULL(TANGGAL),XXTGL,TANGGAL)
	 TGLANGSURPK = IIF(EMPTY(MTGLBYRPK),XXTGL,MTGLBYRPK)
	 CSQL =  ;
	      "select SUM(debet) as debet, SUM(kredit) as kredit from pinjaman_mutasi where norek='" +  ;
			MNOREK + "' and tanggal<='" + SQLDATE(XXTGL) + "'  group by norek"
	 	LCEK = SQLEXEC(OODBC,CSQL,'Smt')
	 MSALDORK = IIF(ISNULL(DEBET),0,DEBET) - IIF(ISNULL(KREDIT),0,KREDIT)
	 MSISAPK = MSALDORK
	 MSISABG = (XXTGL - MAX(MTGLBYRPK,MTGLBYRBG)) * (MRATE / 36500) * MSISAPK
	 MHARI = DAY(MTGLREALISASI)
	 DO WHILE .T.
		 MM =  ;
		      "CTOD('" + RIGHT('00' + ALLTRIM(STR(MHARI)),2) + '-' +  ;
				RIGHT('00' + ALLTRIM(STR(MONTH(TGLANGSURBG))),2) + '-' + ALLTRIM(STR(YEAR(TGLANGSURBG))) + "')"
		  mtgljdw=&mm
		 IF  .NOT. EMPTY(MTGLJDW)
		 EXIT 
		 ENDIF 
		 MHARI = MHARI - 1
	 ENDDO 
	 KALIBG = 0
	 DO WHILE .T.
		 MTGLJDW = MAJU1BLN(MTGLJDW)
		 IF XXTGL < MTGLJDW
		 EXIT 
		 ENDIF 
		 KALIBG = KALIBG + 1
	 ENDDO 
	 IF KALIBG > 0
		 ODBG = MSISABG
		 ELSE 
		 ODBG = 0
	 ENDIF 
	  	if xxtgl>&KREDIT->tgljtempo
		 KALIPK = 1
		 ODPK = MSISAPK
		  tglodpk=MIN(&KREDIT->tgljtempo,tglangsurpk)
		 WJBBG = 0
		ELSE 
		 KALIPK = 0
		 ODPK = 0
		 KALIPK = 0
		 ODPK = 0
		 TGLODPK = CTOD('  -  -    ')
		 WJBPK = 0
		ENDIF 
 ENDCASE 
 
  select &KREDIT
 KALIPK = IIF(KALIPK = 0 .AND. ODPK > 0,1,KALIPK)
 KALIBG = IIF(KALIBG = 0 .AND. ODBG > 0,1,KALIBG)
 IF ODPK < 0
 	ODPK = ODPK + WJBPK
 	WJBPK = 0
 ENDIF 
 IF ODBG < 0
 	ODBG = ODBG + WJBBG
 	WJBBG = 0
 ENDIF 
 IF WJBPK > MSISAPK
 	WJBPK = MSISAPK
 ENDIF 
 IF WJBBG > MSISABG
 	WJBBG = MSISABG
 ENDIF 
  vlama=jangkawaktu(&KREDIT->tglmulai,&KREDIT->tgljtempo)
 VSISAPK = MSISAPK
 VSISABG = MSISABG
 VKALIPK = KALIPK
 VKALIBG = KALIBG
 VODPK = ODPK
 VODBG = ODBG
 VTGLODPK = TGLODPK
 VTGLODBG = TGLODBG
 VWJBPK = WJBPK
 VWJBBG = WJBBG
 VJDWKE = JDWKE
 VANGSKE = ANGSKE
 VHARUSPKKE = HARUSPKKE
 VHARUSBGKE = HARUSBGKE
 VNJDWPK = NJDWPK
 VNJDWBG = NJDWBG
 VMTGLKHBYR = MTGLKHBYR
 VBYRPK = BYRPK
 VBYRBG = BYRBG
 VTAKSASI = 0
 VJAMINAN = ''
 KOLEKTA = '1'
 IF &KREDIT->tgljtempo > xxtgl
     MLEBIHJT = 0
 ELSE 
  	mtgljtempo=&KREDIT->tgljtempo     
	 IF XXTGL >= MTGLJTEMPO AND XXTGL <= MAJU1BLN(MTGLJTEMPO)
	 	MLEBIHJT = 1
	 ELSE 
		 IF XXTGL <= MAJU1BLN(MAJU1BLN(MTGLJTEMPO))
		 	MLEBIHJT = 2
		 ELSE 
		 	MLEBIHJT = 3
		 ENDIF 
	 ENDIF 
 ENDIF 
*!*	 IF mnorek='101227624' 
*!*	   MESSAGEBOX('jatuh tempo  : '+TRANSFORM(mlebihjt,'99'))
*!*	   MESSAGEBOX(' tunggak :'+TRANSFORM(vkalipk,'99.99'))
*!*	 endif
 ANGSBULANAN = 'Y'
  mkdhit=&KREDIT->kdhit
 IF MKDHIT = 'K' .OR. MKDHIT = 'L' .OR. MKDHIT = 'M' .OR. MKDHIT = 'F' .OR. MKDHIT = 'H'
 	DNGANGSURAN = 'T'
 ELSE 
	 IF MKDHIT = 'E' .OR. MKDHIT = 'I' .OR. MKDHIT = 'J'
		 ANGSBULANAN = 'T'
	 ENDIF 
	 DNGANGSURAN = 'Y'
 ENDIF 
 && dengan angsuran
 
 IF DNGANGSURAN = 'Y'
 	IF &KREDIT->kpr='T' OR EMPTY(&KREDIT->kpr)      
 		IF ANGSBULANAN = 'T'
 		** nilai tunggakannya
	 		IF VKALIPK <= 3.2 
	 			KOLEKTA = '1'
	 		ELSE 
 			   IF (VKALIPK <= 6.2 ) 
 				  KOLEKTA = '2'
	 		   ELSE 
 			      IF (VKALIPK <= 12.2 ) 
 				      KOLEKTA = '3'
 			      ELSE 
 				     KOLEKTA = '4'
 			      ENDIF 
 			   ENDIF 
	 		ENDIF 
 		ELSE
 		
*!*		 		  MESSAGEBOX('satu '+TRANSFORM(vkalipk,'99.99'))
	 
			IF VKALIPK <= 3.2  
			   KOLEKTA = '2'
			 ELSE 
				 IF (VKALIPK <= 6.2) 
					 KOLEKTA = '2'
				 ELSE 
					 IF  VKALIPK < 12.2
						 KOLEKTA = '3'
					 ELSE 
						 KOLEKTA = '4'
					 ENDIF 
				 ENDIF 
			ENDIF
			IF mlebihjt > 2
			 kolekta = '4'
			endif  
	 	ENDIF 
	 ELSE 
     	 
	* MESSAGEBOX('satu dua ')
	 
	 IF VKALIPK <= 3.2 AND LEBIHJT = 0
	 KOLEKTA = '1'
	 ELSE 
	 IF (VKALIPK <= 6.2) .OR. LEBIHJT = 1
	 KOLEKTA = '2'
	 ELSE 
	 IF (VKALIPK <= 12.2 ) .OR. LEBIHJT = 2
	 KOLEKTA = '3'
	 ELSE 
	 KOLEKTA = '4'
	 ENDIF 
	 ENDIF 
	 ENDIF 
	 ENDIF 
	 ELSE 
*!*		 MESSAGEBOX('satu dua tiga ')
	 IF VKALIBG <= 3.2 AND LEBIHJT = 0
	 KOLEKTA = '1'
	 ELSE 
	 IF VKALIBG <= 6.2  AND LEBIHJT = 1
	 KOLEKTA = '2'
	 ELSE 
	 IF VKALIBG <= 12.2  AND LEBIHJT = 2
	 KOLEKTA = '3'
	 ELSE 
	 KOLEKTA = '4'
	 ENDIF 
	 ENDIF 
	ENDIF 
ENDIF 

*!*	 IF mnorek='101219056' 
*!*	   MESSAGEBOX('kolekta  : '+kolekta)
*!*	 endif

*** DATA JAMINAN/AGUNAN
*!*	  select &cJAMINAN
*!*	 STORE 0 TO MNILAIOLD , MPPAP1
*!*	 GO TOP
*!*	 MTAKSASI = 0
*!*	 N = 0
*!*	 DO WHILE  .NOT. EOF()
*!*	 N = N + 1
*!*	 MNOBERKAS = NOBERKAS
*!*	 DO CASE 
*!*	 CASE RTRIM(JENIS) = 'KENDARAAN'
*!*	 CSQL =  ;
*!*	      "select * from pinjaman_jaminan_bpkb where noberkas='" + ALLTRIM(MNOBERKAS) + "'"
*!*	 LCEK = SQLEXEC(OODBC,CSQL,'SMT')
*!*	 IF N = 1
*!*	 IF NOBERKAS = MNOBERKAS AND (EMPTY(TGLAMBIL) .OR. TGLAMBIL > MTGL)
*!*	 MJAMINAN =  ;
*!*	      'KENDARAAN ' +  ;
*!*	ALLTRIM(ALLTRIM(MERK) + ' ' + ALLTRIM(TYPE) + ' ' + TAHUN + ' ' + ALLTRIM(NOBPKB) +  ;
*!*	TRANSFORM(NOPOLISI,'@R !!-!!!!-!!'))
*!*	 MNILAIOLD = MNILAIOLD + (NILAI * 0.75)
*!*	 MTAKSASI = MTAKSASI + NILAI
*!*	 CSQL =  ;
*!*	      "select ket2,ket3 from setsandi where kode='P009' and sandi='" + PENGIKATAN + "'"
*!*	 LCEK = SQLEXEC(OODBC,CSQL,'SMT1')
*!*	 MFIELD = ALLTRIM(KET2)
*!*	 MFIELD = IIF(EMPTY(MFIELD),'NILAI',MFIELD)
*!*	 MPROSEN = VAL(KET3)
*!*	 USE 
*!*	 SELECT SMT
*!*	  mppap1=mppap1+(&mField*(mprosen/100))
*!*	 ELSE 
*!*	 N = 0
*!*	 ENDIF 
*!*	 ELSE 
*!*	 IF NOBERKAS = MNOBERKAS AND (EMPTY(TGLAMBIL) .OR. TGLAMBIL > MTGL)
*!*	 N = N - 1
*!*	 ELSE 
*!*	 MNILAIOLD = MNILAIOLD + (NILAI * 0.75)
*!*	 MTAKSASI = MTAKSASI + NILAI
*!*	 CSQL =  ;
*!*	      "select ket2,ket3 from setsandi where kode='P009' and sandi='" + PENGIKATAN + "'"
*!*	 LCEK = SQLEXEC(OODBC,CSQL,'SMT1')
*!*	 MFIELD = ALLTRIM(KET2)
*!*	 MFIELD = IIF(EMPTY(MFIELD),'NILAI',MFIELD)
*!*	 MPROSEN = VAL(KET3)
*!*	 USE 
*!*	 SELECT SMT
*!*	  mppap1=mppap1+(&mField*(mprosen/100))
*!*	 ENDIF 
*!*	 ENDIF 
*!*	 USE 
*!*	 CASE RTRIM(JENIS) = 'TANAH'
*!*	 CSQL =  ;
*!*	      "select * from pinjaman_jaminan_sertifikat where noberkas='" + ALLTRIM(MNOBERKAS) +  ;
*!*	"'"
*!*	 LCEK = SQLEXEC(OODBC,CSQL,'SMT')
*!*	 IF N = 1
*!*	 IF NOBERKAS = MNOBERKAS AND (EMPTY(TGLAMBIL) .OR. TGLAMBIL > MTGL)
*!*	 MJAMINAN =  ;
*!*	      'TANAH ' + ALLTRIM(STATUS) + ' ' + ALLTRIM(NOSERTIFIKAT) + ' ' +  ;
*!*	ALLTRIM(STR(LUAS,12))
*!*	 MTAKSASI = MTAKSASI + NILAI
*!*	 MNILAIOLD = MNILAIOLD + (NILAI * 0.75)
*!*	 CSQL =  ;
*!*	      "select ket2,ket3 from setsandi where kode='P010' and sandi='" + PENGIKATAN + "'"
*!*	 LCEK = SQLEXEC(OODBC,CSQL,'SMT1')
*!*	 MFIELD = ALLTRIM(KET2)
*!*	 MFIELD = IIF(EMPTY(MFIELD),'NILAI',MFIELD)
*!*	 MPROSEN = VAL(KET3)
*!*	 USE 
*!*	 SELECT SMT
*!*	  mppap1=mppap1+(&mField*(mprosen/100))
*!*	 ELSE 
*!*	 N = 0
*!*	 ENDIF 
*!*	 ELSE 
*!*	 IF NOBERKAS = MNOBERKAS AND (EMPTY(TGLAMBIL) .OR. TGLAMBIL > MTGL)
*!*	 N = N - 1
*!*	 ELSE 
*!*	 MNILAIOLD = MNILAIOLD + (NILAI * 0.75)
*!*	 MTAKSASI = MTAKSASI + NILAI
*!*	 CSQL =  ;
*!*	      "select ket2,ket3 from setsandi where kode='P010' and sandi='" + PENGIKATAN + "'"
*!*	 LCEK = SQLEXEC(OODBC,CSQL,'SMT1')
*!*	 MFIELD = ALLTRIM(KET2)
*!*	 MFIELD = IIF(EMPTY(MFIELD),'NILAI',MFIELD)
*!*	 MPROSEN = VAL(KET3)
*!*	 USE 
*!*	 SELECT SMT
*!*	  mppap1=mppap1+(&mField*(mprosen/100))
*!*	 ENDIF 
*!*	 ENDIF 
*!*	 USE 
*!*	 CASE RTRIM(JENIS) = 'SIMPANAN'
*!*	 CSQL =  ;
*!*	      "select * from pinjaman_jaminan_simpanan where noberkas='" + ALLTRIM(MNOBERKAS) +  ;
*!*	"'"
*!*	 LCEK = SQLEXEC(OODBC,CSQL,'SMT')
*!*	 IF N = 1
*!*	 IF NOBERKAS = MNOBERKAS AND (EMPTY(TGLAMBIL) .OR. TGLAMBIL > MTGL)
*!*	 MJAMINAN =  ;
*!*	      ALLTRIM(JENIS) + ' AN.' + ALLTRIM(NAMA) + ' ' + TRANSFORM(JUMLAH,'999,999,999,999')
*!*	 MTAKSASI = MTAKSASI + JUMLAH
*!*	 MNILAIOLD = MNILAIOLD + JUMLAH
*!*	 CSQL =  ;
*!*	      "select ket2,ket3 from setsandi where kode='P011' and sandi='" + PENGIKATAN + "'"
*!*	 LCEK = SQLEXEC(OODBC,CSQL,'SMT1')
*!*	 MFIELD = ALLTRIM(KET2)
*!*	 MFIELD = IIF(EMPTY(MFIELD),'NOMINAL',MFIELD)
*!*	 MPROSEN = VAL(KET3)
*!*	 USE 
*!*	 SELECT SMT
*!*	  mppap1=mppap1+(&mField*(mprosen/100))
*!*	 ELSE 
*!*	 N = 0
*!*	 ENDIF 
*!*	 ELSE 
*!*	 IF NOBERKAS = MNOBERKAS AND (EMPTY(TGLAMBIL) .OR. TGLAMBIL > MTGL)
*!*	 N = N - 1
*!*	 ELSE 
*!*	 MTAKSASI = MTAKSASI + NOMINAL
*!*	 MNILAIOLD = MNILAIOLD + NOMINAL
*!*	 CSQL =  ;
*!*	      "select ket2,ket3 from setsandi where kode='P011' and sandi='" + PENGIKATAN + "'"
*!*	 LCEK = SQLEXEC(OODBC,CSQL,'SMT1')
*!*	 MFIELD = ALLTRIM(KET2)
*!*	 MFIELD = IIF(EMPTY(MFIELD),'NOMINAL',MFIELD)
*!*	 MPROSEN = VAL(KET3)
*!*	 USE 
*!*	 SELECT SMT
*!*	  mppap1=mppap1+(&mField*(mprosen/100))
*!*	 ENDIF 
*!*	 ENDIF 
*!*	 USE 
*!*	 OTHERWISE 
*!*	 CSQL =  ;
*!*	      "select * from pinjaman_jaminan_lainnya where noberkas='" + ALLTRIM(MNOBERKAS) +  ;
*!*	"'"
*!*	 LCEK = SQLEXEC(OODBC,CSQL,'SMT')
*!*	 IF N = 1
*!*	 IF NOBERKAS = MNOBERKAS AND (EMPTY(TGLAMBIL) .OR. TGLAMBIL > MTGL)
*!*	 MJAMINAN = ALLTRIM(KETERANGAN)
*!*	 MTAKSASI = MTAKSASI + NILAI
*!*	 CSQL =  ;
*!*	      "select ket2,ket3 from setsandi where kode='P012' and sandi='" + PENGIKATAN + "'"
*!*	 LCEK = SQLEXEC(OODBC,CSQL,'SMT1')
*!*	 MFIELD = ALLTRIM(KET2)
*!*	 MFIELD = IIF(EMPTY(MFIELD),'NILAI',MFIELD)
*!*	 MPROSEN = VAL(KET3)
*!*	 USE 
*!*	 SELECT SMT
*!*	  mppap1=mppap1+(&mField*(mprosen/100))
*!*	 ELSE 
*!*	 N = 0
*!*	 ENDIF 
*!*	 ELSE 
*!*	 IF NOBERKAS = MNOBERKAS AND (EMPTY(TGLAMBIL) .OR. TGLAMBIL > MTGL)
*!*	 N = N - 1
*!*	 ELSE 
*!*	 MTAKSASI = MTAKSASI + NILAI
*!*	 CSQL =  ;
*!*	      "select ket2,ket3 from setsandi where kode='P012' and sandi='" + PENGIKATAN + "'"
*!*	 LCEK = SQLEXEC(OODBC,CSQL,'SMT1')
*!*	 MFIELD = ALLTRIM(KET2)
*!*	 MFIELD = IIF(EMPTY(MFIELD),'NILAI',MFIELD)
*!*	 MPROSEN = VAL(KET3)
*!*	 USE 
*!*	 SELECT SMT
*!*	  mppap1=mppap1+(&mField*(mprosen/100))
*!*	 ENDIF 
*!*	 ENDIF 
*!*	 USE 
*!*	 ENDCASE 
*!*	  SELECT &cJAMINAN
*!*	 SKIP 
*!*	 ENDDO 
*!*	 MJAMINAN = ''
*!*	 IF N > 1
*!*	 MJAMINAN = ALLTRIM(MJAMINAN) + SPACE(50 - LEN(ALLTRIM(MJAMINAN)))
*!*	 MJAMINAN = LEFT(MJAMINAN,37)
*!*	 MJAMINAN = MJAMINAN + ' (' + STR(N,2) + ' Jaminan)'
*!*	 ELSE 
*!*	 MJAMINAN = ALLTRIM(MJAMINAN) + SPACE(50)
*!*	 MJAMINAN = LEFT(MJAMINAN,50)
*!*	 ENDIF 
 
 ** pegnisian nialai ppap
 
*!*	 DO CASE 
*!*	 CASE KOLEKTA = '1'
*!*	 MPPAP = 0.005 * MSISAPK
*!*	 MPPAPOLD = MPPAP
*!*	 CASE KOLEKTA = '2'
*!*	 MPPAP = IIF(MSISAPK - MPPAP1 < 0,0,0.1 * (MSISAPK - MPPAP1))
*!*	 MPPAPOLD = IIF(MSISAPK - MNILAIOLD < 0,0,0.1 * (MSISAPK - MNILAIOLD))
*!*	 CASE KOLEKTA = '3'
*!*	 MPPAP = IIF(MSISAPK - MPPAP1 < 0,0,0.5 * (MSISAPK - MPPAP1))
*!*	 MPPAPOLD = IIF(MSISAPK - MNILAIOLD < 0,0,0.5 * (MSISAPK - MNILAIOLD))
*!*	 CASE KOLEKTA = '4'
*!*	 MPPAP = IIF(MSISAPK - MPPAP1 < 0,0,1 * (MSISAPK - MPPAP1))
*!*	 MPPAPOLD = IIF(MSISAPK - MNILAIOLD < 0,0,1 * (MSISAPK - MNILAIOLD))
*!*	 ENDCASE 

MJAMINAN = SPACE(5)
MTAKSASI = 0
MPPAP = 0
MPPAP1 = 0
 SELECT SALDOKRD
 APPEND BLANK
  REPLACE norek WITH &KREDIT->norek
  REPLACE tgljtempo WITH &KREDIT->tgljtempo
 REPLACE KOL WITH KOLEKTA
  REPLACE plafon WITH &KREDIT->pokok
 REPLACE PKAWAL WITH MPKAWAL , BGAWAL WITH MBGAWAL
 REPLACE JUMJDWPK WITH JPK , JUMJDWBG WITH JBG
 REPLACE HRSPK WITH MHRSPK , HRSBG WITH MHRSBG
 REPLACE SISAJDWPK WITH MSISAJDWPK , SISAJDWBG WITH MSISAJDWBG
 REPLACE SISAPK WITH IIF(ISNULL(VSISAPK),0,VSISAPK) , SISABG WITH VSISABG , KALIPK WITH  ;
      VKALIPK
 REPLACE KALIBG WITH VKALIBG , ODPK WITH VODPK , ODBG WITH VODBG , TGLODPK WITH VTGLODPK
 REPLACE KALIBYRPK WITH MKLBYRPK , KALIBYRBG WITH MKLBYRBG
 REPLACE TGLODBG WITH VTGLODBG , WJBPK WITH VWJBPK , WJBBG WITH VWJBBG , JDWKE WITH  ;
      VJDWKE
 REPLACE ANGSKE WITH VANGSKE , HARUSPKKE WITH VHARUSPKKE , HARUSBGKE WITH VHARUSBGKE ,  ;
      NJDWPK WITH VNJDWPK
 REPLACE NJDWBG WITH VNJDWBG , MTGLKHBYR WITH VMTGLKHBYR , BYRPK WITH VBYRPK , BYRBG  ;
      WITH VBYRBG
 REPLACE JAMINAN WITH MJAMINAN , TAKSASI WITH MTAKSASI , PPAP WITH  ;
      IIF(ISNULL(MPPAP),0,MPPAP) , PPAP1 WITH IIF(ISNULL(MPPAP1),0,MPPAP1)
  SELECT &kredit
 USE 
  SELECT &ANGSUR
 USE 
  SELECT &JADWAL
 USE 
  SELECT &cJAMINAN
 USE 
 SELECT SALDOKRD
 MDATA = ALIAS()
 SELECT (OLDSELECT)

 RETURN MDATA
ENDPROC
*------saldokrd original




* buat jadwal pinjaman
PROCEDURE buatjdw
 PARAMETER MNOREK
 LOCAL N , XPOKOK , XBUNGA
 

 OLDSELECT = SELECT()

 CSQL =  ;
      "select norek,a.kdhit,a.pokok,a.jasa,a.rate as rate,a.lama,a.tanggal,a.tglmulai,a.tgljtempo,b.pembulatan as pembulatan from pinjaman as a left join setsandi_pinj as b on a.jenis=b.sandi where norek='" +  ;
      ALLTRIM(MNOREK) +  ;
		"'"
 LCEK = SQLEXEC(OODBC,CSQL,'SMT')

 
 MNOREK = NOREK
 MKDHIT = KDHIT
 MPOKOK = POKOK
 MJASA = JASA
 MRATE = RATE
 MLAMA = LAMA
 MTANGGAL = TANGGAL
 MTGLANGSUR = TGLMULAI
 MTGLJTEMPO = TGLJTEMPO
 BULATKE = IIF(ISNULL(PEMBULATAN),0,PEMBULATAN)
 USE 
 SELECT (OLDSELECT)
 MMINGGU = ((MTGLJTEMPO - MTGLANGSUR) / 7) + 1
 MTGLANG = MTGLANGSUR
 MBUNGA = MJASA
 MANGSURAN = ROUND((MPOKOK + MBUNGA) / MLAMA,0)
 VERSI = MKDHIT
 MSISA = MPOKOK
 DO CASE 
 CASE VERSI = 'A'
 N = 1
 JMLBUNGA = 0
 JMLPOKOK = 0
 XPOKOK = ROUND(MPOKOK / MLAMA,0)
 MANGSURAN = PEMBULATAN(MANGSURAN,BULATKE)
 XBUNGA = MANGSURAN - XPOKOK
 JMLBUNGA = 0
 DO WHILE N <= MLAMA
 IF N = MLAMA
 XBUNGA = MBUNGA - JMLBUNGA
 XPOKOK = MPOKOK - JMLPOKOK
 ENDIF 
 JMLBUNGA = JMLBUNGA + XBUNGA
 JMLPOKOK = JMLPOKOK + XPOKOK
 CSQL =  ;
      "insert ignore into pinjaman_jadwal (kantor,norek,tanggal,pokok,jasa,opt) value ('" +  ;
DEFAKANTOR + "','" + MNOREK + "','" + SQLDATE(MTGLANG) + "','" +  ;
STR(XPOKOK) + "','" + STR(XBUNGA) + "','" + 'OPT' + "')"
 LCEK = SQLEXEC(OODBC,CSQL)
 MTGLANG = MAJU1BLN(MTGLANG,MTANGGAL)
 N = N + 1
 ENDDO 
 RETURN 
 CASE VERSI = 'B' AND  .NOT. (EMPTY(MTGLANGSUR) .OR. EMPTY(MTGLJTEMPO))
 N = 1
 JMLBUNGA = 0
 JMLPOKOK = 0
 MTGLANG1 = MTGLANG
 MANGSURAN = PEMBULATAN(MANGSURAN,BULATKE)
 DO WHILE N <= MLAMA
 IF N = MLAMA
 XPOKOK = MPOKOK - JMLPOKOK
 XBUNGA = MANGSURAN - XPOKOK
 CSQL =  ;
      "insert into pinjaman_jadwal (norek,tanggal,pokok,jasa,opt) value ('" + MNOREK +  ;
"','" + SQLDATE(MTGLANG) + "','" + STR(XPOKOK) + "','" + STR(XBUNGA) + "','" +  ;
'OPT' + "')"
 LCEK = SQLEXEC(OODBC,CSQL)
 ELSE 
 XBUNGA = ROUND((((MLAMA + 1 - N) * 2) / (MLAMA * (MLAMA + 1))) * MBUNGA,0)
 XPOKOK = MANGSURAN - XBUNGA
 JMLBUNGA = JMLBUNGA + XBUNGA
 JMLPOKOK = JMLPOKOK + XPOKOK
 CSQL =  ;
      "insert into pinjaman_jadwal (norek,tanggal,pokok,jasa,opt) value ('" + MNOREK +  ;
"','" + SQLDATE(MTGLANG) + "','" + STR(XPOKOK) + "','" + STR(XBUNGA) + "','" +  ;
'OPT' + "')"
 LCEK = SQLEXEC(OODBC,CSQL)
 ENDIF 
 IF MONTH(MTGLANG) <> IIF(MONTH(MTGLANG1) = 12,1,MONTH(MTGLANG1) + 1)
 MTGLANG = MTGLANG - 1
 ENDIF 
 MTGLANG1 = MTGLANG
 MTGLANG = MAJU1BLN(MTGLANG,MTGLANGSUR)
 N = N + 1
 ENDDO 
 CASE VERSI = 'C'
 N = 1
 XPOKOK = MPOKOK
 XBUNGA = ROUND((MRATE * MPOKOK) / 100,0)
 XBUNGA = PEMBULATAN(XBUNGA,BULATKE)
 DO WHILE .T.
 IF MTGLANG >= MTGLJTEMPO
 CSQL =  ;
      "insert into pinjaman_jadwal (norek,tanggal,pokok,jasa,opt) value ('" + MNOREK +  ;
"','" + SQLDATE(MTGLANG) + "','" + STR(XPOKOK) + "','" + STR(XBUNGA) + "','" +  ;
'OPT' + "')"
 LCEK = SQLEXEC(OODBC,CSQL)
 EXIT 
 ELSE 
 CSQL =  ;
      "insert into pinjaman_jadwal (norek,tanggal,pokok,jasa,opt) value ('" + MNOREK +  ;
"','" + SQLDATE(MTGLANG) + "','" + STR(0) + "','" + STR(XBUNGA) + "','" +  ;
'OPT' + "')"
 LCEK = SQLEXEC(OODBC,CSQL)
 ENDIF 
 MTGLANG = MAJU1BLN(MTGLANG)
 N = N + 1
 ENDDO 
 CASE VERSI = 'D'
 CSQL =  ;
      "insert into pinjaman_jadwal (norek,tanggal,pokok,jasa,opt) value ('" + MNOREK +  ;
"','" + SQLDATE(MTGLANG) + "','" + STR(MPOKOK) + "','" + STR(MBUNGA) + "','" +  ;
'OPT' + "')"
 LCEK = SQLEXEC(OODBC,CSQL)
 CASE VERSI = 'E'
 MTGLANG = MTGLANGSUR
 XPOKOK = ROUND(MPOKOK / ((MTGLJTEMPO - MTGLANGSUR) + 1),0)
 XBUNGA = ROUND(MBUNGA / ((MTGLJTEMPO - MTGLANGSUR) + 1),0)
 JMLBUNGA = 0
 JMLPOKOK = 0
 MANGSURAN = (MPOKOK + MBUNGA) / ((MTGLJTEMPO - MTGLANGSUR) + 1)
 MANGSURAN = PEMBULATAN(MANGSURAN,BULATKE)
 N = 1
 DO WHILE N <= ((MTGLJTEMPO - MTGLANGSUR) + 1)
 IF MTGLANG >= MTGLJTEMPO
 XBUNGA = MBUNGA - JMLBUNGA
 XPOKOK = MPOKOK - JMLPOKOK
 CSQL =  ;
      "insert into pinjaman_jadwal (norek,tanggal,pokok,jasa,opt) value ('" + MNOREK +  ;
"','" + SQLDATE(MTGLANG) + "','" + STR(XPOKOK) + "','" + STR(XBUNGA) + "','" +  ;
'OPT' + "')"
 LCEK = SQLEXEC(OODBC,CSQL)
 EXIT 
 ENDIF 
 JMLBUNGA = JMLBUNGA + XBUNGA
 JMLPOKOK = JMLPOKOK + XPOKOK
 CSQL =  ;
      "insert into pinjaman_jadwal (norek,tanggal,pokok,jasa,opt) value ('" + MNOREK +  ;
"','" + SQLDATE(MTGLANG) + "','" + STR(XPOKOK) + "','" + STR(XBUNGA) + "','" +  ;
'OPT' + "')"
 LCEK = SQLEXEC(OODBC,CSQL)
 N = N + 1
 MTGLANG = MTGLANG + 1
 ENDDO 
 CASE VERSI = 'F'
 N = 1
 XPOKOK = ROUND(MPOKOK / MLAMA,0)
 XPOKOK = PEMBULATAN(XPOKOK,BULATKE)
 XBUNGA = ROUND((MRATE * MPOKOK) / 100,0)
 XBUNGA = PEMBULATAN(XBUNGA,BULATKE)
 MSISA = MPOKOK
 DO WHILE .T.
 IF N = MLAMA
 XPOKOK = MSISA
 ENDIF 
 CSQL =  ;
      "insert into pinjaman_jadwal (norek,tanggal,pokok,jasa,opt) value ('" + MNOREK +  ;
"','" + SQLDATE(MTGLANG) + "','" + STR(XPOKOK) + "','" + STR(XBUNGA) + "','" +  ;
'OPT' + "')"
 LCEK = SQLEXEC(OODBC,CSQL)
 IF N = MLAMA
 EXIT 
 ENDIF 
 MSISA = MSISA - XPOKOK
 XBUNGA = ROUND((MRATE * MSISA) / 100,0)
 XBUNGA = PEMBULATAN(XBUNGA,BULATKE)
 MTGLANG = MAJU1BLN(MTGLANG)
 N = N + 1
 ENDDO 
 CASE VERSI = 'I'
 N = 1
 JMLBUNGA = 0
 JMLPOKOK = 0
 XPOKOK = ROUND(MPOKOK / MMINGGU,0)
 XBUNGA = ROUND(MBUNGA / MMINGGU,0)
 DO WHILE N <= MMINGGU
 IF N = MMINGGU
 XBUNGA = MBUNGA - JMLBUNGA
 XPOKOK = MPOKOK - JMLPOKOK
 ENDIF 
 JMLBUNGA = JMLBUNGA + XBUNGA
 JMLPOKOK = JMLPOKOK + XPOKOK
 CSQL =  ;
      "insert into pinjaman_jadwal (norek,tanggal,pokok,jasa,opt) value ('" + MNOREK +  ;
"','" + SQLDATE(MTGLANG) + "','" + STR(XPOKOK) + "','" + STR(XBUNGA) + "','" +  ;
'OPT' + "')"
 LCEK = SQLEXEC(OODBC,CSQL)
 MTGLANG = MTGLANG + 7
 N = N + 1
 ENDDO 
 ENDCASE 
 RETURN 
ENDPROC
*------

*Perhitungan Denda
PROCEDURE HITDENDA
 PARAMETER MNOREK , PTGLHITLUNAS , MFILE
 CURKRD = 'KRD'
 CURJDW = 'JDW'
 CURANGS = 'ANGS'
 LOCAL XTGL , OLDSELECT
 OLDSELECT = SELECT()
 XPARA = 'Y'
 CSQL = "select * from pinjaman where norek='" + MNOREK + "'"
 LCEK = SQLEXEC(OODBC,CSQL,CURKRD)
 CSQL =  ;
      "select * from pinjaman_mutasi where norek='" + MNOREK + "' order by tanggal"
 LCEK = SQLEXEC(OODBC,CSQL,CURANGS)
 CSQL =  ;
      "select * from pinjaman_jadwal where norek='" + MNOREK + "' order by tanggal"
 LCEK = SQLEXEC(OODBC,CSQL,CURJDW)
 PDENDA = DEFAPROSENDENDA
 PHARI = DEFATENORDENDA
 PPENAL = 0
 PBIAYATT = 0
 MCIF = KRD.CIF
 CSQL = 'select nama from anggota where cif=?mcif'
 LCEK = SQLEXEC(OODBC,CSQL,'SMT')
 MNAMA = NAMA
 USE 
 SELECT (CURKRD)
 MPOKOKPINJ = KRD.POKOK
 MTGLMULAI = KRD.TGLMULAI
 MTGLJTEMPO = KRD.TGLJTEMPO
 CREATE CURSOR PELUNASAN ( NO N ( 3 ) , KDDATA C ( 3 ) , TGLJDW D , JDWPOKOK N ( 15 ) ,  ;
      JDWBUNGA N ( 15 ) , JDWJUMLAH N ( 15 ) , TGLBAYAR D , BKTBAYAR C ( 10  ;
      ) , BYRPOKOK N ( 15 ) , BYRBUNGA N ( 15 ) , BYRDENDA N ( 15 ) ,  ;
      BYRJUMLAH N ( 15 ) , KURANGBYR N ( 15 ) , LAMA N ( 8 ) , DENDA N ( 15 ) ,  ;
      KURANGDENDA N ( 15 ) , TEST N ( 10 ) )
 NOMORCTK = 0
 BGNOW = 0
 MBYRPK = 0
 SELECT (CURKRD)
 MNOREK = NOREK
 MTANGGAL = TANGGAL
 MTGLJTEMPO = TGLJTEMPO
 MLAMA = LAMA
 MBUNGAAWAL = JASA
 MPOKOKAWAL = POKOK
 JMLANGSURAN = (POKOK + JASA) / MLAMA
 MKDHIT = KDHIT
 BPTGLANALI = PTGLHITLUNAS
 SELECT (CURJDW)
 GO TOP
 MTOTANGS = POKOK + JASA
 SELECT (CURKRD)
 STORE 0 TO MTOTAL , MDENDA , BDENDA , MTOTJML , MTOTPOKOK , MTOTBUNGA , MTOTBUNGA ,  ;
      MTOTDENDA , MMAJU , JDWPK , JDWBG
 STORE 0 TO MTOTPOKOK1 , MTOTBUNGA1 , MTOTJML1 , MDENDA1 , MTOTDENDA1
 LIN = .F.
 HABIS = .T.
 ANGHABIS = .F.
 JDWHABIS = .F.
 MSISA = 0
 MKURANG = 0
 PID = 'A'
 SELECT (CURJDW)
 GO TOP
 SELECT (CURANGS)
 GO TOP
 SELECT (CURJDW)
 MTGLJADWAL = TANGGAL
 MPOKOK = POKOK
 MBUNGA = JASA
 MJDWPERBULAN = MPOKOK + MBUNGA
 MJADWAL = 0
 MSELESAI = .F.
 BRS = .T.
 DO WHILE  .NOT. EOF()
 SELECT (CURJDW)
 IF PTGLHITLUNAS - TANGGAL > 0
 IF MTOTAL <= 0
 MTGLJADWAL = TANGGAL
 MJADWAL = (POKOK + JASA)
 MTOTAL = MTOTAL + MJADWAL
 SELECT PELUNASAN
 NOMORCTK = NOMORCTK + 1
 APPEND BLANK
 REPLACE NO WITH NOMORCTK , KDDATA WITH 'HIT' , TGLJDW WITH JDW.TANGGAL
 REPLACE JDWPOKOK WITH JDW.POKOK , JDWBUNGA WITH JDW.JASA
 REPLACE JDWJUMLAH WITH JDW.POKOK + JDW.JASA
 MSISA = MSISA + MJADWAL
 BRS = .F.
 ELSE 
 MJADWAL = 0
 MTOTAL = MSISA
 NOMORCTK = NOMORCTK + 1
 SELECT PELUNASAN
 APPEND BLANK
 REPLACE NO WITH NOMORCTK , KDDATA WITH 'HIT' , TGLJDW WITH CTOD('  -  -   ')
 REPLACE JDWPOKOK WITH 0 , JDWBUNGA WITH 0
 REPLACE JDWJUMLAH WITH 0
 BRS = .F.
 ENDIF 
 SELECT (CURANGS)
 DO WHILE .T.
 IF EOF() .OR. TANGGAL > PTGLHITLUNAS
 MSELESAI = .T.
 EXIT 
 ENDIF 
 MTGLANGSUR = TANGGAL
 MBUKTI = BUKTI
 IF MTOTAL > MJADWAL
 MLAMBAT = MAX(MAX(MTGLANGSUR,MTANGGAL) - MTGLJADWAL,0)
 MKURANG = MKURANG + (IIF(MJADWAL > (0 - MKURANG),(0 - MKURANG),MJADWAL))
 SELECT PELUNASAN
 REPLACE TGLBAYAR WITH MTGLANGSUR , BKTBAYAR WITH MBUKTI
 REPLACE BYRPOKOK WITH 0 , BYRBUNGA WITH 0
 REPLACE BYRDENDA WITH 0
 REPLACE BYRJUMLAH WITH 0
 REPLACE TEST WITH MTOTAL
 CDENDA = 0
 IF (MLAMBAT > PHARI)
 CDENDA = (MLAMBAT / 30) * (PDENDA / 100) * MTOTAL
 MDENDA = MDENDA + CDENDA
 MTGLJADWAL = ANGS.TANGGAL
 ENDIF 
 REPLACE KURANGBYR WITH MKURANG , LAMA WITH MLAMBAT
 REPLACE DENDA WITH CDENDA , KURANGDENDA WITH MDENDA
 ELSE 
 IF BRS
 SELECT PELUNASAN
 APPEND BLANK
 REPLACE NO WITH NOMORCTK , KDDATA WITH 'HIT' , TGLJDW WITH CTOD('  -  -   ')
 REPLACE JDWPOKOK WITH 0 , JDWBUNGA WITH 0
 REPLACE JDWJUMLAH WITH 0
 MJADWAL = 0
 ENDIF 
 SELECT (CURANGS)
 MTGLANGSUR = TANGGAL
 MLAMBAT = MAX(MTGLANGSUR - MTGLJADWAL,0)
 MBUKTI = BUKTI
 MKURANG = MKURANG + MJADWAL
 SELECT PELUNASAN
 REPLACE TGLBAYAR WITH ANGS.TANGGAL , BKTBAYAR WITH ANGS.BUKTI
 REPLACE BYRPOKOK WITH ANGS.POKOK , BYRBUNGA WITH ANGS.JASA
 REPLACE BYRDENDA WITH ANGS.DENDA
 REPLACE BYRJUMLAH WITH ANGS.POKOK + ANGS.JASA
 CDENDA = 0
 IF (MLAMBAT > PHARI)
 CDENDA = (MLAMBAT / 30) * (PDENDA / 100) * MTOTAL
 MDENDA = MDENDA + CDENDA
 MTGLJADWAL = ANGS.TANGGAL
 ENDIF 
 MKURANG = MKURANG - (ANGS.POKOK + ANGS.JASA)
 REPLACE KURANGBYR WITH MKURANG , LAMA WITH MLAMBAT
 REPLACE DENDA WITH CDENDA , KURANGDENDA WITH MDENDA
 REPLACE TEST WITH MTOTAL
 MTOTAL = MTOTAL - (ANGS.POKOK + ANGS.JASA)
 BRS = .T.
 SELECT (CURANGS)
 IF MTOTAL <= 0
 SKIP 
 EXIT 
 ENDIF 
 ENDIF 
 SELECT (CURANGS)
 SKIP 
 ENDDO 
 ELSE 
 MSELESAI = .T.
 ENDIF 
 IF MSELESAI
 IF MKURANG < 0
 NOMORCTK = NOMORCTK + 1
 SELECT PELUNASAN
 IF BRS
 APPEND BLANK
 REPLACE NO WITH NOMORCTK , KDDATA WITH 'HIT' , TGLJDW WITH CTOD('  -  -   ')
 REPLACE JDWPOKOK WITH 0 , JDWBUNGA WITH 0
 REPLACE JDWJUMLAH WITH 0
 ENDIF 
 MLAMBAT = MAX(MAX(MTGLANGSUR,TGLJDW) - MTGLJADWAL,0)
 MKURANG = MKURANG + MJADWAL
 MTOTAL = MTOTAL - MKURANG + MJADWAL
 CDENDA = 0
 IF (MLAMBAT > PHARI)
 CDENDA = (MLAMBAT / 30) * (PDENDA / 100) * MTOTAL
 MDENDA = MDENDA + CDENDA
 MTGLJADWAL = ANGS.TANGGAL
 ENDIF 
 REPLACE TGLBAYAR WITH MTGLANGSUR , BKTBAYAR WITH MBUKTI
 REPLACE BYRPOKOK WITH 0 , BYRBUNGA WITH 0
 REPLACE BYRDENDA WITH 0
 REPLACE BYRJUMLAH WITH 0
 REPLACE KURANGBYR WITH MKURANG , LAMA WITH MLAMBAT
 REPLACE DENDA WITH CDENDA , KURANGDENDA WITH 0
 REPLACE TEST WITH MTOTAL
 BRS = .T.
 ENDIF 
 IF MKURANG > 0
 MLAMBAT = MAX(PTGLHITLUNAS - MTGLJADWAL,0)
 NOMORCTK = NOMORCTK + 1
 SELECT PELUNASAN
 IF BRS
 APPEND BLANK
 REPLACE NO WITH NOMORCTK , KDDATA WITH 'HIT' , TGLJDW WITH CTOD('  -  -   ')
 REPLACE JDWPOKOK WITH 0 , JDWBUNGA WITH 0
 REPLACE JDWJUMLAH WITH 0
 MJADWAL = 0
 ENDIF 
 MTOTAL = MKURANG
 MKURANG = MKURANG + (IIF(MJADWAL > (0 - MKURANG),(0 - MKURANG),MJADWAL))
 CDENDA = 0
 IF (MLAMBAT > PHARI)
 CDENDA = (MLAMBAT / 30) * (PDENDA / 100) * MTOTAL
 MDENDA = MDENDA + CDENDA
 ENDIF 
 REPLACE TGLBAYAR WITH PTGLHITLUNAS , BKTBAYAR WITH ''
 REPLACE BYRPOKOK WITH 0 , BYRBUNGA WITH 0
 REPLACE BYRDENDA WITH 0
 REPLACE BYRJUMLAH WITH 0
 REPLACE KURANGBYR WITH MKURANG , LAMA WITH MLAMBAT
 REPLACE DENDA WITH CDENDA , KURANGDENDA WITH 0 , TEST WITH MTOTAL
 ENDIF 
 SELECT (CURJDW)
 SKIP 
 DO WHILE  .NOT. EOF()
 IF TANGGAL > PTGLHITLUNAS
 EXIT 
 ENDIF 
 NOMORCTK = NOMORCTK + 1
 SELECT PELUNASAN
 APPEND BLANK
 REPLACE NO WITH NOMORCTK , KDDATA WITH 'HIT' , TGLJDW WITH JDW.TANGGAL
 REPLACE JDWPOKOK WITH JDW.POKOK , JDWBUNGA WITH JDW.JASA
 REPLACE JDWJUMLAH WITH JDW.POKOK + JDW.JASA
 MJADWAL = (JDW.POKOK + JDW.JASA)
 MTGLJADWAL = JDW.TANGGAL
 MTOTAL = JDW.POKOK + JDW.JASA
 MLAMBAT = MAX(PTGLHITLUNAS - MTGLJADWAL,0)
 CDENDA = 0
 IF (MLAMBAT > PHARI)
 CDENDA = (MLAMBAT / 30) * (PDENDA / 100) * MTOTAL
 MDENDA = MDENDA + CDENDA
 ENDIF 
 MKURANG = MKURANG + (IIF(MJADWAL > (0 - MKURANG),(0 - MKURANG),MJADWAL))
 REPLACE TGLBAYAR WITH PTGLHITLUNAS , BKTBAYAR WITH ''
 REPLACE BYRPOKOK WITH 0 , BYRBUNGA WITH 0
 REPLACE BYRDENDA WITH 0
 REPLACE BYRJUMLAH WITH 0
 REPLACE KURANGBYR WITH MKURANG
 REPLACE LAMA WITH MLAMBAT
 REPLACE DENDA WITH CDENDA , KURANGDENDA WITH 0 , TEST WITH MTOTAL
 SELECT (CURJDW)
 SKIP 
 ENDDO 
 EXIT 
 ENDIF 
 SELECT (CURJDW)
 IF MTOTAL <= 0
 SKIP 
 ENDIF 
 ENDDO 
 SELECT (CURJDW)
 DO WHILE  .NOT. EOF()
 SELECT PELUNASAN
 NOMORCTK = NOMORCTK + 1
 APPEND BLANK
 REPLACE NO WITH NOMORCTK , KDDATA WITH 'JDW' , TGLJDW WITH JDW.TANGGAL
 REPLACE JDWPOKOK WITH JDW.POKOK , JDWBUNGA WITH JDW.JASA
 REPLACE JDWJUMLAH WITH JDW.POKOK + JDW.JASA
 SELECT (CURJDW)
 SKIP 
 ENDDO 
 SELECT PELUNASAN
 SUM FOR KDDATA = 'HIT' TO CJDWJUMLAH JDWJUMLAH
 SUM FOR KDDATA = 'HIT' TO CBYRPOKOK BYRPOKOK
 SUM FOR KDDATA = 'HIT' TO CBYRBUNGA BYRBUNGA
 SUM FOR KDDATA = 'HIT' TO CBYRDENDA BYRDENDA
 SUM FOR KDDATA = 'HIT' TO CDENDA DENDA
 SUM FOR KDDATA = 'JDW' TO CJDWPOKOK JDWPOKOK
 SUM FOR KDDATA = 'JDW' TO CJDWBUNGA JDWBUNGA
 MDENDA = CDENDA - CBYRDENDA
 MLUNAS =  ;
      CJDWJUMLAH - (CBYRPOKOK + CBYRBUNGA) + CJDWPOKOK + MDENDA + (CJDWBUNGA * 0.25)
 SELECT (CURKRD)
 USE 
 SELECT (CURJDW)
 USE 
 SELECT (CURANGS)
 USE 
 SELECT PELUNASAN
 IF  .NOT. (VARTYPE(MFILE) = 'X' .OR. EMPTY(MFILE))
 SET CONSOLE OFF
  SET ALTERNATE TO &mFile 
 SET ALTERNATE ON
 ? 
 ? '                                                         PERHITUNGAN PELUNASAN                                                          '
 ? '----------------------------------------------------------------------------------------------------------------------------------------'
 ? 'Tanggal Perhitungan : ' + DTOC(PTGLHITLUNAS) + '            No.Debitur : ' +  ;
MNOREK
 ? 'Denda/Bln.      (%) : ' + TRANSFORM(PDENDA,'99.999') +  ;
'                Nama       : ' + MNAMA
 ? '----------------------------------------------------------------------------------------------------------------------------------------'
 ? 'Pinjaman Pokok      : ' + TRANSFORM(MPOKOKPINJ,'999,999,999,999')
 ? 'Angsuran /Bln.      : ' + TRANSFORM(MJDWPERBULAN,'999,999,999,999')
 ? 'Mulai Tanggal       : ' + DTOC(MTGLMULAI) + ' s/d. ' + DTOC(MTGLJTEMPO)
 ? '----------------------------------------------------------------------------------------------------------------------------------------'
 ? 'Perhitungan angsuran :'
 ? 'Tgl.Jadwal        Jumlah  Tgl.Ang.   Bukti            Pokok         Bunga         Denda        Jumlah   Kurang Ang.   Lama   Khrs. Denda'
 ? '----------------------------------------------------------------------------------------------------------------------------------------'
 SELECT PELUNASAN
 LOCAL TJDWJUMLAH , TBYRPOKOK , TBYRBUNGA , TBYRDENDA , TKURANGBYR , TDENDA
 STORE 0 TO TJDWJUMLAH , TBYRPOKOK , TBYRBUNGA , TBYRDENDA , TKURANGBYR , TDENDA
 GO TOP
 DO WHILE  .NOT. EOF()
 IF KDDATA = 'JDW'
 EXIT 
 ENDIF 
 ? DTOC(TGLJDW) + ' ' + TRANSFORM(JDWJUMLAH,'9,999,999,999') + ' ' + DTOC(TGLBAYAR) +  ;
' ' + BKTBAYAR + '' + TRANSFORM(BYRPOKOK,'9,999,999,999') + ' ' +  ;
TRANSFORM(BYRBUNGA,'9,999,999,999') + ' ' + TRANSFORM(BYRDENDA,'9,999,999,999') + ' ' +  ;
TRANSFORM(BYRPOKOK + BYRBUNGA + BYRDENDA,'9,999,999,999') + ' ' +  ;
TRANSFORM(KURANGBYR,'9,999,999,999') + ' ' + TRANSFORM(LAMA,'99,999') + ' ' +  ;
TRANSFORM(DENDA,'9,999,999,999')
 TJDWJUMLAH = TJDWJUMLAH + JDWJUMLAH
 TBYRPOKOK = TBYRPOKOK + BYRPOKOK
 TBYRBUNGA = TBYRBUNGA + BYRBUNGA
 TBYRDENDA = TBYRDENDA + BYRDENDA
 TKURANGBYR = TKURANGBYR + KURANGBYR
 TDENDA = TDENDA + DENDA
 SKIP 
 ENDDO 
 ? '----------------------------------------------------------------------------------------------------------------------------------------'
 ? 'Total :    ' + TRANSFORM(TJDWJUMLAH,'9,999,999,999') + '            ' +  ;
'          ' + '' + TRANSFORM(TBYRPOKOK,'9,999,999,999') + ' ' +  ;
TRANSFORM(TBYRBUNGA,'9,999,999,999') + ' ' + TRANSFORM(TBYRDENDA,'9,999,999,999') + ' ' +  ;
TRANSFORM(TBYRPOKOK + TBYRBUNGA + TBYRDENDA,'9,999,999,999') + ' ' +  ;
'             ' + ' ' + '      ' + ' ' + TRANSFORM(TDENDA,'9,999,999,999')
 ? 
 ? 'Jadwal yg masih harus dibayar :'
 ? 'Tgl.Jadwal         Pokok            Jasa           Jumlah '
 ? '----------------------------------------------------------------------------------------------------------------------------------------'
 LOCAL TJDWPOKOK , TJDWBUNGA
 STORE 0 TO TJDWPOKOK , TJDWBUNGA
 DO WHILE  .NOT. EOF()
 ? DTOC(TGLJDW) + ' ' + TRANSFORM(JDWPOKOK,'9,999,999,999') + '    ' +  ;
TRANSFORM(JDWBUNGA,'9,999,999,999') + '   ' +  ;
TRANSFORM(JDWPOKOK + JDWBUNGA,'9,999,999,999')
 TJDWPOKOK = TJDWPOKOK + JDWPOKOK
 TJDWBUNGA = TJDWBUNGA + JDWBUNGA
 SKIP 
 ENDDO 
 ? '----------------------------------------------------------------------------------------------------------------------------------------'
 ? 'Total :    ' + TRANSFORM(TJDWPOKOK,'9,999,999,999') + '    ' +  ;
TRANSFORM(TJDWBUNGA,'9,999,999,999') + '   ' + TRANSFORM(TJDWPOKOK + TJDWBUNGA,'9,999,999,999')
 ? 
 MKEWAJIBAN = TJDWJUMLAH - (TBYRPOKOK + TBYRBUNGA)
 ? 'Kewajiban Ang. yg belum dibayar:                                  ' +  ;
TRANSFORM(MKEWAJIBAN,'9,999,999,999')
 ? 'Kekurangan Pokok Pinjaman      :                                  ' +  ;
TRANSFORM(TJDWPOKOK,'9,999,999,999')
 ? 'Tambahan Bunga ( 25% x)        :                                  ' +  ;
TRANSFORM(CJDWBUNGA * 0.25,'9,999,999,999')
 ? 'Denda angsuran                 :  ' + TRANSFORM(TDENDA,'9,999,999,999') + ' - ' +  ;
TRANSFORM(TBYRDENDA,'9,999,999,999') + ' = ' +  ;
TRANSFORM(TDENDA - TBYRDENDA,'9,999,999,999')
 ? '                                ----------------------------------------------- +'
 ? '                               :                                  ' +  ;
TRANSFORM(MKEWAJIBAN + TJDWPOKOK + TDENDA - TBYRDENDA + (CJDWBUNGA * 0.25),'9,999,999,999')
 ? 'Biaya tagih / tarik            :                                              0'
 ? '                                ----------------------------------------------- +'
 ? 'Jumlah yang harus dibayar      :                                  ' +  ;
TRANSFORM(MKEWAJIBAN + TJDWPOKOK + TDENDA - TBYRDENDA + (CJDWBUNGA * 0.25),'9,999,999,999')
 ? 
 SET CONSOLE ON
 SET ALTERNATE TO
  BUKAFILE(MFILE, ,'open')
 ENDIF 
 SELECT PELUNASAN
 USE 
 SELECT (OLDSELECT)
 RETURN MDENDA
ENDPROC
*------


* Bayar angsuran
PROCEDURE bayarangsur
 PARAMETER MKAS , MNOREK , MTANGGAL , MBUKTI , MXPOKOK , MBUNGA , MDENDA , MKDANGS , MSISABG, ykantor,mopt
 MJASARK = 0
 
 mopt =IIF (empty(mopt),defauserid,mopt)
 
 OLDSELE = SELECT()
  


 MCUR = SALDOKRD(MNOREK,MTANGGAL)
 SELECT (MCUR)
 MKOL_AWAL = KOL
 USE 
 CSQL = "select kdhit,rate,kantor from pinjaman where norek='" + MNOREK + "'"
 LCEK = SQLEXEC(OODBC,CSQL,'smt001')

 MKDHIT = KDHIT
 MRATE = RATE
 xkantor = ykantor
 MKANTOR = IIF(EMPTY(XKANTOR),DEFAKANTOR,XKANTOR)
 USE 
 SELECT (OLDSELE)
 
 && jika jenis pinjaman rekening koran
 IF MKDHIT = 'H'
    CSQL =  ;
     	 "select MAX(tanggal) as tanggal from pinjaman_mutasi where norek='" + MNOREK + "' and tanggal<='" + SQLDATE(TGLNOW) + "' group by norek"
 	LCEK = SQLEXEC(OODBC,CSQL,'smt')
 	MTGLMUTASI = IIF(ISNULL(TANGGAL),TGLNOW,TANGGAL)
 	
 	CSQL ="select SUM(debet) as debet, SUM(kredit) as kredit from pinjaman_mutasi where norek='" + MNOREK + "'"
    LCEK = SQLEXEC(OODBC,CSQL,'smt001')
    MSALDO = DEBET - KREDIT
    MJASARK = ROUND((TGLNOW - MTGLMUTASI) * (MRATE / 36500) * MSALDO,0)
    && ada pembayaran jasa/bunga
    IF MJASARK > 0
 	   CSQL = 'insert into pinjaman_mutasi (kantor,norek,tanggal,tglmutasi,bukti,kode,debet,kredit,saldo,opt) value ' +  ;
		"('" + MKANTOR + "'," + "'" + MNOREK + "'," + "'" +  ;
		SQLDATE(MTANGGAL) + "'," + "'" + SQLDATE(MTANGGAL) + "'," + "'" + MBUKTI +  ;
		"'," + "'" + DEFAPINJASA + "'," + "'" + STR(MJASARK) + "'," + "'" + STR(0) +  ;
		"'," + "'" + STR(MSALDO + MJASARK) + "'," + "'" + DEFAUSERID + "')"
		 LCEK = SQLEXEC(OODBC,CSQL)
 	ENDIF 
  	  CSQL =  ;
      'insert into pinjaman_mutasi (kantor,norek,tanggal,tglmutasi,bukti,kode,debet,kredit,saldo,opt) value ' +  ;
		"('" + MKANTOR + "'," + "'" + MNOREK + "'," + "'" +  ;
		SQLDATE(MTANGGAL) + "'," + "'" + SQLDATE(MTANGGAL) + "'," + "'" + MBUKTI +  ;
		"'," + "'" + IIF(MKAS = 'KAS',DEFAPINSTOR,DEFAPINPBK) + "'," + "'" + STR(0) +  ;
		"'," + "'" + STR(MPOKOK) + "'," + "'" + STR(MSALDO + MJASARK - MPOKOK) +  ;
		"'," + "'" + DEFAUSERID + "')"
		 LCEK = SQLEXEC(OODBC,CSQL)
 ELSE 

 CSQL =  ;
    	  'insert into pinjaman_mutasi (kantor,norek,tanggal,tglmutasi,bukti,kode,pokok,jasa,denda,opt) value ' +  ;
		"('" + MKANTOR +"'," + "'" + MNOREK + "'," + "'" +  ;
 		SQLDATE(MTANGGAL) + "'," + "'" + SQLDATE(MTANGGAL) + "'," + "'" + MBUKTI +  ;
		"'," + "'" + IIF(MKAS = 'KAS',DEFAPINSTOR,DEFAPINPBK) + "'," + "'" +  ;
		STR(MXPOKOK) + "'," + "'" + STR(MBUNGA) + "'," + "'" + STR(MDENDA) + "'," + "'" +  ;
		mopt + "')"
 LCEK = SQLEXEC(OODBC,CSQL)
     IF lcek < 1
        
         MESSAGEBOX('gagal insert pinjaman mutasi '+csql)
     ENDIF
 
     
 ENDIF 
 && jika ada pelunasan pinjaman
 IF MKDANGS = 'L'
 	CSQL =  ;
      'insert into pinjaman_mutasi (kantor,norek,tanggal,tglmutasi,bukti,kode,pokok,jasa,denda,opt) value ' +  ;
		"('" + MKANTOR + "'," + "'" + MNOREK + "'," + "'" +  ;
		SQLDATE(MTANGGAL) + "'," + "'" + SQLDATE(MTANGGAL) + "'," + "'" + MBUKTI +  ;
		"'," + "'" + IIF(MKAS = 'KAS',DEFAPINPOT,DEFAPINPOT) + "'," + "'0'," + "'" +  ;
		STR(MSISABG - MBUNGA) + "'," + "'0'," + "'" + mopt + "')"
 	LCEK = SQLEXEC(OODBC,CSQL)
 
 	CSQL =  ;
      "update pinjaman set tgllunas='" + SQLDATE(MTANGGAL) + "' where norek='" + MNOREK +  ;
	"'"
	 LCEK = SQLEXEC(OODBC,CSQL)
 ENDIF 
 OLDSELE = SELECT()
 MCUR = SALDOKRD(MNOREK,MTANGGAL)
 SELECT (MCUR)
 MKOLECT = KOL
 MSISAPOKOK = SISAPK
 MSISABUNGA = SISABG
 MKALIPK = KALIPK
 MKALIBG = KALIBG
 MODPK = ODPK
 MODBG = ODBG
 MHARIPK = IIF(EMPTY(TGLODPK),0,MTANGGAL - TGLODPK)
 MHARIBG = IIF(EMPTY(TGLODBG),0,MTANGGAL - TGLODBG)
 MTGLOD = MAX(TGLODPK,TGLODBG)
 MPPAP = PPAP
 USE 
 SELECT (OLDSELE)
 CSQL =  ;
      "select norek from pinjaman_saldo where kantor='" + DEFAKANTOR + "' and norek='" +  ;
        MNOREK + "' and tanggal='" + SQLDATE(MTANGGAL) + "'"
 LCEK = SQLEXEC(OODBC,CSQL,'smt')
 
 IF NOREK = MNOREK
 CSQL =  ;
      'UPDATE pinjaman_saldo set ' + "sisapokok='" + STR(MSISAPOKOK) + "'," +  ;
"sisabunga='" + STR(MSISABUNGA) + "'," + "denda='" + '0' + "'," + "tunggpk='" +  ;
STR(MODPK) + "', " + "kalipk='" + STR(MKALIPK) + "', " + "haripk='" + STR(MHARIPK) +  ;
"', " + "tunggbg='" + STR(MODBG) + "', " + "kalibg='" + STR(MKALIBG) +  ;
"', " + "haribg='" + STR(MHARIBG) + "', " + "tglod='" + SQLDATE(MTGLOD) + "', " +  ;
"tglmacet='0000-00-00', " + "kol_awal='" + ALLTRIM(MKOL_AWAL) + "', " +  ;
"kol='" + ALLTRIM(MKOLECT) + "', " + "dpk='" + '0' + "', " + "ppap='" +  ;
STR(MPPAP) + "', " + "bgakrual='" + '0' + "', " + "kontijensi='" + '0' + "', " +  ;
"adm='" + '0' + "', " + "provisi='" + '0' + "', " + "biaya='" + '0' + "', " +  ;
"opt='" + DEFAUSERID + "' " + "where kantor='" + DEFAKANTOR +  ;
"' and norek='" + MNOREK + "' and tanggal='" + SQLDATE(MTANGGAL) + "'"
 ELSE 
 CSQL =  ;
      'insert into pinjaman_saldo (kantor,norek,tanggal,sisapokok,sisabunga,denda,' +  ;
'tunggpk,kalipk,haripk,tunggbg,kalibg,haribg,tglod,tglmacet,kol_awal,kol,dpk,' +  ;
"ppap,bgakrual,kontijensi,adm,provisi,biaya,opt) value ('" + MKANTOR +  ;
"','" + MNOREK + "','" + SQLDATE(MTANGGAL) + "','" + STR(MSISAPOKOK) + "','" +  ;
STR(MSISABUNGA) + "','" + '0' + "','" + STR(MODPK) + "','" + STR(MKALIPK) +  ;
"','" + STR(MHARIPK) + "','" + STR(MODBG) + "','" + STR(MKALIBG) + "','" +  ;
STR(MHARIBG) + "','" + SQLDATE(MTGLOD) + "','" + '0000-00-00' + "','" +  ;
ALLTRIM(MKOL_AWAL) + "','" + ALLTRIM(MKOLECT) + "','" + '0' + "','" +  ;
STR(MPPAP) + "','" + '0' + "','" + '0' + "','" + '0' + "','" + '0' + "','" + '0' +  ;
"','" + mopt + "')"
 ENDIF 
 LCEK = SQLEXEC(OODBC,CSQL)
 IF LCEK < 1
  MESSAGEBOX('Gagal baca pinjaman saldo')
 ENDIF
  * guntur 111220
  
  	 IF mKALIPK <= 3.2 
	 	KOLEKTA = '1'
	 	ELSE 
	 	IF (mKALIPK <= 6.2) 
			 KOLEKTA = '2'
	 		ELSE 
	 		KOLEKTA = '3'
			
	 	ENDIF 
	 ENDIF 
	
 CSQL =  ;
      'UPDATE pinjaman set ' + "sisapokok='" + STR(MSISAPOKOK) + "'," +  ;
      " tgltransaksi = '"+SQLDATE(Mtanggal)+"',"+;  
       "tungpokok='" + STR(MODPK)+ "',"+;    
       "tungxpk='" + TRANSFORM(mkalipk,'99.99')  + "',"+;
       "kol ='"+(kolekta)+"',"+;
      "sisabunga='" + STR(MSISABUNGA)+ "'  where kantor='" + DEFAKANTOR +  ;
      "' and norek='" + MNOREK + "'" 
 LCEK = SQLEXEC(OODBC,CSQL)
 IF LCEK < 1
  MESSAGEBOX('Gagal baca pinjaman '+csql)
  
*!*	  ELSE
*!*	  MESSAGEBOX('berhasil '+csql)
 ENDIF
  
  
  
 RETURN 
ENDPROC
*------*
*" tgltransaksi = '"+SQLDATE(Mtglmutasi)+"',"tungpokok='" + STR(MODPK)+ "',"tungxpl='" + (MkaliPK)+ "',"+;       
