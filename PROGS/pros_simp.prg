* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
*  FileName PROS_SIMP.PRG <-- This file create by UnFoxAll
* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-



PROCEDURE saldosimp
 PARAMETER MNOREK , MTANGGAL
 LOCAL OLDSELECT
 OLDSELECT = SELECT()
 CSQL =  ;
      "select saldo from simpanan_mutasi where norek='" + MNOREK +  ;
"' and iddata=(select MAX(iddata) from simpanan_mutasi where norek='" + MNOREK +  ;
"' and tanggal<='" + SQLDATE(MTANGGAL) + "')"
 LCEK = SQLEXEC(OODBC,CSQL,'SMT')
 IF LCEK < 1
  MESSAGEBOX('gagal baca saldo')
 RETURN 
 ENDIF 
 MSALDO = SALDO
 USE 
 SELECT (OLDSELECT)
 RETURN MSALDO
ENDPROC

*------
PROCEDURE cetakhead
 IF MYPRINT('ON','century gothic',10)
 MBRS = 3
 MKOL = 10
 @ MBRS + 0 , MKOL SAY NAMA
 @ MBRS + 1 , MKOL SAY NOREK
 @ MBRS + 2 , MKOL SAY ALAMAT
 @ MBRS + 3 , MKOL SAY KOTA
 ENDIF 
  MYPRINT('OFF')
 RETURN 
ENDPROC

*------
* cetak header smb ibm fersi kantor jogja buku lama
PROCEDURE cetakhead1y
 PARAMETER MNOREK
 OLDSELECT = SELECT()

 CSQL =  ;
      'select a.norek,a.tanggal,b.nama,b.alamat,b.rt,b.desa,b.kecamatan,b.kota,b.noktp,b.pekerjaan from simpanan as a, anggota as b where a.cif=b.cif and a.norek=?mnorek'
 LCEK = SQLEXEC(OODBC,CSQL,'HEAD1')




 MFRX = SYS(2023) + '\HEAD.FRX'
 MFRT = STRTRAN(MFRX,'.FRX','.FRT')
 
 SELECT 0
 USE ctk_buku_headery.frx ALIAS CTK
  Select * From ctk Into Table &mfrx
  
  
 USE 
 SELECT CTK
 USE 
  USE &mfrx ALIAS test
 SELECT 0
 CSQL = "select * from set_cetakfrx where namafrx='BUKU_TAB_HEAD'"
 LCEK = SQLEXEC(OODBC,CSQL,'smt')
 MHPOS = HPOS
 MVPOS = VPOS
 MVPOS1 = VPOS + 2500
 MVPOS2 = VPOS + 2500 + 2187
 MVPOS3 = VPOS + 2500 + 2185 + 2500

  USE 
 SELECT TEST
 

 
 USE 
 
 SELECT HEAD1
 SET CONSOLE OFF
 
* DO FORM print_setup WITH thisform.frxname 
 
  LCOLDPRINTER = SET('PRINTER',3)
 
 SET PRINTER TO NAME (LCOLDPRINTER)
 
  REPORT FORM (MFRX) TO PRINTER PROMPT NODIALOG 
*!*	  
*!*	 IF DEFAUSERID = 'GUN'
*!*	 REPORT FORM (MFRX) PREVIEW 
*!*	 ELSE 
*!*	 REPORT FORM (MFRX) TO PRINTER
*!*	 ENDIF 
 
 USE 
 SET CONSOLE ON
 SELECT (OLDSELECT)
  ERASE &mfrx 
  ERASE &mfrt
ENDPROC

PROCEDURE cetakhead1
 PARAMETER MNOREK
 OLDSELECT = SELECT()

 CSQL =  ;
      'select a.norek,a.tanggal,b.nama,b.alamat,b.rt,b.desa,b.kecamatan,b.kota,b.noktp,b.pekerjaan from simpanan as a, anggota as b where a.cif=b.cif and a.norek=?mnorek'
 LCEK = SQLEXEC(OODBC,CSQL,'HEAD1')




 MFRX = SYS(2023) + '\HEAD.FRX'
 MFRT = STRTRAN(MFRX,'.FRX','.FRT')
 
 SELECT 0
 IF defanama='KSP BHAKTI YOGYAKARTA' 
     USE ctk_buku_headerY.frx ALIAS CTK
     ELSE
     USE ctk_buku_header.frx ALIAS CTK
 ENDIF
  Select * From ctk Into Table &mfrx
  
  
 USE 
 SELECT CTK
 USE 
  USE &mfrx ALIAS test
 SELECT 0
 CSQL = "select * from set_cetakfrx where namafrx='BUKU_TAB_HEAD'"
 LCEK = SQLEXEC(OODBC,CSQL,'smt')
 MHPOS = HPOS
 MVPOS = VPOS
 MVPOS1 = VPOS + 2500
 MVPOS2 = VPOS + 2500 + 2187
 MVPOS3 = VPOS + 2500 + 2185 + 2500

  USE 
 SELECT TEST
 

 
 USE 
 
 SELECT HEAD1
 SET CONSOLE OFF
 
* DO FORM print_setup WITH thisform.frxname 
 
  LCOLDPRINTER = SET('PRINTER',3)
 
 SET PRINTER TO NAME (LCOLDPRINTER)
 
  REPORT FORM (MFRX) TO PRINTER PROMPT NODIALOG 
*!*	  
*!*	 IF DEFAUSERID = 'GUN'
*!*	 REPORT FORM (MFRX) PREVIEW 
*!*	 ELSE 
*!*	 REPORT FORM (MFRX) TO PRINTER
*!*	 ENDIF 
 
 USE 
 SET CONSOLE ON
 SELECT (OLDSELECT)
  ERASE &mfrx 
  ERASE &mfrt
ENDPROC

*------
* cetak head smb olivetty

PROCEDURE cetakhead10
 PARAMETER MNOREK
 OLDSELECT = SELECT()

 CSQL =  ;
      'select a.norek,a.tanggal,b.nama,b.alamat,b.rt,b.pekerjaan,b.desa,b.kecamatan,b.kota,b.noktp from simpanan as a, anggota as b where a.cif=b.cif and a.norek=?mnorek'
 LCEK = SQLEXEC(OODBC,CSQL,'HEAD1')

 MFRX = SYS(2023) + '\HEAD.FRX'
 MFRT = STRTRAN(MFRX,'.FRX','.FRT')
 
 SELECT 0
  IF defanama='KSP BHAKTI YOGYAKARTA' 
      xx = ' yogya '
     USE ctk_buku_headol1.frx ALIAS CTK
     ELSE
      xx = ' bukan '
     USE ctk_buku_headol.frx ALIAS CTK
 ENDIF
 
 
 
 
  Select * From ctk Into Table &mfrx
 
  
 USE 
 SELECT CTK
 USE 
  USE &mfrx ALIAS test
 SELECT 0
 CSQL = "select * from set_cetakfrx where namafrx='BUKU_TAB_HEAD'"
 LCEK = SQLEXEC(OODBC,CSQL,'smt')
 MHPOS = HPOS
 MVPOS = VPOS 
 MVPOS1 = VPOS  + 2500
 MVPOS2 = VPOS  + 2500 + 2187
 MVPOS3 = VPOS  + 2500 + 2185 + 2500

  USE 
 SELECT TEST
 USE 
 
 SELECT HEAD1
 SET CONSOLE OFF
 brow
* DO FORM print_setup WITH thisform.frxname 
 
  LCOLDPRINTER = SET('PRINTER',3)
 
 SET PRINTER TO NAME (LCOLDPRINTER)
 
  REPORT FORM (MFRX) TO PRINTER PROMPT NODIALOG 
  
*!*	  
*!*	 IF DEFAUSERID = 'GUN'
*!*	 REPORT FORM (MFRX) PREVIEW 
*!*	 ELSE 
*!*	 REPORT FORM (MFRX) TO PRINTER
*!*	 ENDIF 
 
 USE 
 SET CONSOLE ON
 SELECT (OLDSELECT)
  ERASE &mfrx 
  ERASE &mfrt
ENDPROC
*------



PROCEDURE cetaktabungan
 LPARAMETER MIDDATA , MURUT, tgl2
 LOCAL OLDDBF
 OLDDBF = SELECT()
 MFRX = 'd:\TAB.FRX'
 MFRT = STRTRAN(MFRX,'.FRX','.FRT')
 SELECT 0
 CSQL = "select * from set_cetakfrx where namafrx='BUKU_TAB_MUTASI'"
 LCEK = SQLEXEC(OODBC,CSQL,'smt')
 STORE 0 TO MBARIS , MBRSHAL1 , MHEIGHT , MANTARA , LNOMOR , LTANGGAL , LKODE , LDEBET ,  ;
      LKREDIT , LSALDO , LOPT
      
 DO WHILE  .NOT. EOF()
	 DO CASE 
	 	CASE OBJCODE = 1
	 		MBARIS = BARIS
	 		MBRSHAL1 = BRSHAL1
	 		MHEIGHT = HEIGHT
	 		MANTARA = ANTARA
	 		
	 	CASE ALLTRIM(EXPR) = 'nomor'
	 		LNOMOR = HPOS
	 	CASE ALLTRIM(EXPR) = 'tanggal'
	 		LTANGGAL = HPOS
	 	CASE ALLTRIM(EXPR) = 'kode'
	 		LKODE = HPOS
	 	CASE ALLTRIM(EXPR) = 'debet'
	 		LDEBET = HPOS
	 	CASE ALLTRIM(EXPR) = 'kredit'
	 		LKREDIT = HPOS
	 	CASE ALLTRIM(EXPR) = 'saldo'
	 		LSALDO = HPOS
	 	CASE ALLTRIM(EXPR) = 'opt'
	 		LOPT = HPOS
	 ENDCASE 
	 SKIP 
 ENDDO 
 USE 
 SELECT 0
 USE ctk_buku_mutasi.frx ALIAS CTK
  Select * From ctk Into Table &mfrx
 USE 
 SELECT CTK
 USE 
  USE &mfrx ALIAS test
  
 LOCATE FOR OBJCODE = 1
 REPLACE HEIGHT WITH MHEIGHT
 LOCATE FOR ALLTRIM(EXPR) = 'nomor'
 REPLACE HPOS WITH LNOMOR
 LOCATE FOR ALLTRIM(EXPR) = 'tanggal'
 REPLACE HPOS WITH LTANGGAL
 LOCATE FOR ALLTRIM(EXPR) = 'kode'
 REPLACE HPOS WITH LKODE
 LOCATE FOR ALLTRIM(EXPR) = 'debet'
 REPLACE HPOS WITH LDEBET
 LOCATE FOR ALLTRIM(EXPR) = 'kredit'
 REPLACE HPOS WITH LKREDIT
 LOCATE FOR ALLTRIM(EXPR) = 'saldo'
 REPLACE HPOS WITH LSALDO
 LOCATE FOR ALLTRIM(EXPR) = 'opt'
 REPLACE HPOS WITH LOPT
 
 USE 
 SELECT (OLDDBF)
 LOCATE FOR IDDATA = MIDDATA
 
* BROWSE
MESSAGEBOX(tgl2)
 
 DO WHILE  .NOT. EOF() 
 
     
	 
	 SELECT 0
	 CREATE CURSOR ctkbuku2 (  TANGGAL D , KODE C ( 2 ) , DEBET INT ( 15 ) ,  ;
	      KREDIT INT ( 15 ) , SALDO INT ( 15 ) , OPT C ( 4 ),nomor INT(2)  )
	 SELECT CTKBUKU2
	 FOR AA = 1 TO MURUT + IIF(MURUT > MBRSHAL1,MANTARA,0)
	 APPEND BLANK
	 ENDFOR 
	 SELECT (OLDDBF)
	 
	* IF  
	 DO WHILE  .NOT. EOF()
		 IF  .NOT. EMPTY(IDDATA) AND tanggal <= tgl2
		 MTANGGAL = TANGGAL
		 MKODE = KODE
		 MDEBET = DEBET
		 MKREDIT = KREDIT
		 MSALDO = SALDO
		 MOPT = OPT
		 REPLACE CETAKBUKU WITH '*'
		 CSQL =  ;
		      "update simpanan_mutasi set cetakbuku='*' where iddata='" + STR(IDDATA) + "'"
		 LCEK = SQLEXEC(OODBC,CSQL)
		 SELECT CTKBUKU2
		 APPEND BLANK
		 
		 *REPLACE NOMOR WITH MURUT , TANGGAL WITH MTANGGAL , KODE WITH MKODE
		 REPLACE  TANGGAL WITH MTANGGAL , KODE WITH MKODE
		 
		 REPLACE DEBET WITH MDEBET , KREDIT WITH MKREDIT , SALDO WITH MSALDO , OPT WITH MOPT, nomor WITH murut
		 IF MURUT = MBRSHAL1
			 FOR AA = 1 TO MANTARA
			 APPEND BLANK
			 ENDFOR 
		 ENDIF 
		 IF MURUT = MBARIS
		 	MURUT = 1
			EXIT 
		 ENDIF 
		 MURUT = MURUT + 1
		 ENDIF 
		 SELECT (OLDDBF)
		 SKIP 
	 ENDDO 
	 SELECT CTKBUKU2
	 GO TOP

	 LCOLDPRINTER = SET('PRINTER',3)
	 SET PRINTER TO NAME (LCOLDPRINTER)
	 IF DEFAUSERID = 'GUN'
	 REPORT FORM ctk_buku_mutasi PREVIEW 
	 ELSE 
	 REPORT FORM ctk_buku_mutasi TO PRINTER
	 ENDIF 
	 USE 
	 SELECT (OLDSELE)
	 IF EOF()
	 	EXIT 
	 ENDIF 
	 JWB = MESSAGEBOX('Cetak Halaman Berikutnya',36,'')
		 IF JWB = 7
		 	 EXIT 
		 ENDIF 
 * endif		 
 ENDDO 
 SELECT (OLDDBF)
 RETURN MURUT
ENDPROC

PROCEDURE cetaktaboliv
 LPARAMETER MIDDATA , MURUT, tgl2
 LOCAL OLDDBF
 OLDDBF = SELECT()
 MFRX = 'd:\TAB.FRX'
 MFRT = STRTRAN(MFRX,'.FRX','.FRT')
 SELECT 0
 CSQL = "select * from set_cetakfrx where namafrx='BUKU_TAB_MUTASI'"
 LCEK = SQLEXEC(OODBC,CSQL,'smt')
 STORE 0 TO MBARIS , MBRSHAL1 , MHEIGHT , MANTARA , LNOMOR , LTANGGAL , LKODE , LDEBET ,  ;
      LKREDIT , LSALDO , LOPT
      
 DO WHILE  .NOT. EOF()
	 DO CASE 
	 	CASE OBJCODE = 1
	 		MBARIS = BARIS
	 		MBRSHAL1 = BRSHAL1
	 		MHEIGHT = HEIGHT
	 		MANTARA = ANTARA
	 		
	 	CASE ALLTRIM(EXPR) = 'nomor'
	 		LNOMOR = HPOS
	 	CASE ALLTRIM(EXPR) = 'tanggal'
	 		LTANGGAL = HPOS
	 	CASE ALLTRIM(EXPR) = 'kode'
	 		LKODE = HPOS
	 	CASE ALLTRIM(EXPR) = 'debet'
	 		LDEBET = HPOS
	 	CASE ALLTRIM(EXPR) = 'kredit'
	 		LKREDIT = HPOS
	 	CASE ALLTRIM(EXPR) = 'saldo'
	 		LSALDO = HPOS
	 	CASE ALLTRIM(EXPR) = 'opt'
	 		LOPT = HPOS
	 ENDCASE 
	 SKIP 
 ENDDO 
 USE 
 SELECT 0
 
 USE ctk_buku_mutasi_oliv.frx ALIAS CTK
  Select * From ctk Into Table &mfrx
 USE 
 SELECT CTK
 USE 
  USE &mfrx ALIAS test
  
 LOCATE FOR OBJCODE = 1
 REPLACE HEIGHT WITH MHEIGHT
 LOCATE FOR ALLTRIM(EXPR) = 'nomor'
 REPLACE HPOS WITH LNOMOR
 LOCATE FOR ALLTRIM(EXPR) = 'tanggal'
 REPLACE HPOS WITH LTANGGAL
 LOCATE FOR ALLTRIM(EXPR) = 'kode'
 REPLACE HPOS WITH LKODE
 LOCATE FOR ALLTRIM(EXPR) = 'debet'
 REPLACE HPOS WITH LDEBET
 LOCATE FOR ALLTRIM(EXPR) = 'kredit'
 REPLACE HPOS WITH LKREDIT
 LOCATE FOR ALLTRIM(EXPR) = 'saldo'
 REPLACE HPOS WITH LSALDO
 LOCATE FOR ALLTRIM(EXPR) = 'opt'
 REPLACE HPOS WITH LOPT
 
 USE 
 SELECT (OLDDBF)
 LOCATE FOR IDDATA = MIDDATA
 
 * BROWSE
MESSagebox(tgl2)

 
 DO WHILE  .NOT. EOF()
	 
	 SELECT 0
	 CREATE CURSOR ctkbuku2 (  TANGGAL D , KODE C ( 2 ) , DEBET INT ( 15 ) ,  ;
	      KREDIT INT ( 15 ) , SALDO INT ( 15 ) , OPT C ( 4 ),nomor INT(2)  )
	 SELECT CTKBUKU2
	 FOR AA = 1 TO MURUT + IIF(MURUT > MBRSHAL1,MANTARA,0)
	 APPEND BLANK
	 ENDFOR 
	 SELECT (OLDDBF)
	 
	 DO WHILE  .NOT. EOF()
		 IF  .NOT. EMPTY(IDDATA) AND tanggal <= tgl2
		 MTANGGAL = TANGGAL
		 MKODE = KODE
		 MDEBET = DEBET
		 MKREDIT = KREDIT
		 MSALDO = SALDO
		 MOPT = OPT
		 REPLACE CETAKBUKU WITH '*'
		 CSQL =  ;
		      "update simpanan_mutasi set cetakbuku='*' where iddata='" + STR(IDDATA) + "'"
		 LCEK = SQLEXEC(OODBC,CSQL)
		 SELECT CTKBUKU2
		 APPEND BLANK
		 
		 *REPLACE NOMOR WITH MURUT , TANGGAL WITH MTANGGAL , KODE WITH MKODE
		 REPLACE  TANGGAL WITH MTANGGAL , KODE WITH MKODE
		 
		 REPLACE DEBET WITH MDEBET , KREDIT WITH MKREDIT , SALDO WITH MSALDO , OPT WITH MOPT, nomor WITH murut
		 IF MURUT = MBRSHAL1
			 FOR AA = 1 TO MANTARA
			 APPEND BLANK
			 ENDFOR 
		 ENDIF 
		 IF MURUT = MBARIS
		 	MURUT = 1
			EXIT 
		 ENDIF 
		 MURUT = MURUT + 1
		 ENDIF 
		 SELECT (OLDDBF)
		 SKIP 
	 ENDDO 
	 SELECT CTKBUKU2
	 GO TOP

	 LCOLDPRINTER = SET('PRINTER',3)
	 SET PRINTER TO NAME (LCOLDPRINTER)
	 IF DEFAUSERID = 'GUN'
	 REPORT FORM ctk_buku_mutasi_oliv PREVIEW 
	 ELSE 
	 REPORT FORM ctk_buku_mutasi_oliv TO PRINTER
	 ENDIF 
	 USE 
	 SELECT (OLDSELE)
	 IF EOF()
	 	EXIT 
	 ENDIF 
	 JWB = MESSAGEBOX('Cetak Halaman Berikutnya',36,'')
		 IF JWB = 7
		 	 EXIT 
		 ENDIF 
 ENDDO 
 SELECT (OLDDBF)
 RETURN MURUT
ENDPROC

*------
PROCEDURE simpanan_cetak_bilyet
 PARAMETER MNOREK
 RETURN 
ENDPROC
*------*


PROCEDURE saldoapkk
 PARAMETER Mcif , MTANGGAL
 LOCAL OLDSELECT
 OLDSELECT = SELECT()
 CSQL =  ;
      "select sldpokok from anggota_mutasi where cif='" + Mcif +  ;
"' and iddata=(select MAX(iddata) from anggota_mutasi where cif='" + Mcif +  ;
"' and tanggal<='" + SQLDATE(MTANGGAL) + "')"
 LCEK = SQLEXEC(OODBC,CSQL,'SMT01')
 IF LCEK < 1
  MESSAGEBOX('gagal baca saldo')
 RETURN 
 ENDIF 
 MSALDO = Sldpokok
 USE 
 SELECT (OLDSELECT)
 RETURN MSALDO
ENDPROC


PROCEDURE saldoaswk
 PARAMETER Mcif , MTANGGAL
 LOCAL OLDSELECT
 OLDSELECT = SELECT()
 CSQL =  ;
      "select sldswk from anggota_mutasi where cif='" + Mcif +  ;
"' and iddata=(select MAX(iddata) from anggota_mutasi where cif='" + Mcif +  ;
"' and tanggal<='" + SQLDATE(MTANGGAL) + "')"
 LCEK = SQLEXEC(OODBC,CSQL,'SMT02')
 IF LCEK < 1
  MESSAGEBOX('gagal baca saldo')
 RETURN 
 ENDIF 
 MSALDO = Sldswk
 USE 
 SELECT (OLDSELECT)
 RETURN MSALDO
ENDPROC

PROCEDURE saldoawjb
 PARAMETER Mcif , MTANGGAL
 LOCAL OLDSELECT
 OLDSELECT = SELECT()
 CSQL =  ;
      "select sldwajib from anggota_mutasi where cif='" + Mcif +  ;
"' and iddata=(select MAX(iddata) from anggota_mutasi where cif='" + Mcif +  ;
"' and tanggal<='" + SQLDATE(MTANGGAL) + "')"
 LCEK = SQLEXEC(OODBC,CSQL,'SMT04')
 IF LCEK < 1
  MESSAGEBOX('gagal baca saldo')
 RETURN 
 ENDIF 
 MSALDO = Sldwajib
 USE 
 SELECT (OLDSELECT)
 RETURN MSALDO
ENDPROC

PROCEDURE saldoalain
 PARAMETER Mcif , MTANGGAL
 LOCAL OLDSELECT
 OLDSELECT = SELECT()
 CSQL =  ;
      "select sldlain from anggota_mutasi where cif='" + Mcif +  ;
"' and iddata=(select MAX(iddata) from anggota_mutasi where cif='" + Mcif +  ;
"' and tanggal<='" + SQLDATE(MTANGGAL) + "')"
 LCEK = SQLEXEC(OODBC,CSQL,'SMT03')
 IF LCEK < 1
  MESSAGEBOX('gagal baca saldo')
 RETURN 
 ENDIF 
 MSALDO = Sldlain
 USE 
 SELECT (OLDSELECT)
 RETURN MSALDO
ENDPROC











