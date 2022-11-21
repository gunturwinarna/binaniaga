* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
*  FileName A_CEK_KREDIT.PRG <-- This file create by UnFoxAll
* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


 CSQL = "select * from kasir where kode='05' "
 LCEK = SQLEXEC(OODBC,CSQL,'smt')
 IF LCEK < 1
  MESSAGEBOX(STR1)
 RETURN 
 ENDIF 
 GO TOP
 DO WHILE  .NOT. EOF()
 MKANTOR = KANTOR
 MTANGGAL = TANGGAL
 MBLN = MONTH(MTANGGAL)
 MTHN = YEAR(MTANGGAL)
 MBUKTI = BUKTI
 MTOTAL = DEBET - KREDIT
 MCOL = NOREK
 CSQL =  ;
      'select * from col_instansi_pinj where kode=?mCol and instansi=?mcol and bln=?mbln and tahun=?mthn'
 LCEK = SQLEXEC(OODBC,CSQL,'COL')
 DO WHILE  .NOT. EOF()
 MNOANGG = NOANGG
 MNOREK = NOREK
 MPRODUK = PRODUK
 MANGPOKOK = ANGPOKOK
 MANGBUNGA = ANGBUNGA
 CSQL =  ;
      'select * from pinjaman_mutasi where tanggal=?mtanggal and bukti=?mbukti and norek=?mnorek'
 LCEK = SQLEXEC(OODBC,CSQL,'krd')
 IF POKOK <> MANGPOKOK .OR. JASA <> MANGBUNGA
  MESSAGEBOX('Jumlah Tidak sama ' + CHR(13) + 'Di Colektor :' + CHR(13) +  ;
'              Tanggal : ' +  ;
DTOC(MTANGGAL) +  ;
CHR(13) +  ;
'              Bukti   : ' +  ;
MBUKTI +  ;
CHR(13) +  ;
'              Norek   : ' +  ;
MNOREK +  ;
CHR(13) +  ;
'              Ang Pokok : ' +  ;
TRANSFORM(MANGPOKOK,'999,999,999,999') +  ;
CHR(13) +  ;
'              Ang Bunga : ' +  ;
TRANSFORM(MANGBUNGA,'999,999,999,999') +  ;
CHR(13) +  ;
'Di Kredit :' +  ;
CHR(13) +  ;
'              Tanggal : ' +  ;
DTOC(TANGGAL) +  ;
CHR(13) +  ;
'              Bukti   : ' +  ;
BUKTI +  ;
CHR(13) +  ;
'              Norek   : ' +  ;
NOREK +  ;
CHR(13) +  ;
'              AngPokok: ' +  ;
TRANSFORM(POKOK,'999,999,999,999') +  ;
CHR(13) +  ;
'              AngBunga: ' +  ;
TRANSFORM(POKOK,'999,999,999,999') +  ;
CHR(13))
 IF LASTKEY() = 27
  MESSAGEBOX('escape')
 RETURN 
 ENDIF 
 ENDIF 
 SELECT COL
 SKIP 
 ENDDO 
 SELECT SMT
 SKIP 
 ENDDO 
*
