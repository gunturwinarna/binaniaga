* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
*  FileName AA.PRG <-- This file create by UnFoxAll
* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


 CSQL = "select * from kasir where kode='05' "
 LCEK = SQLEXEC(OODBC,CSQL,'kasir')
 IF LCEK < 1
  MESSAGEBOX(CSQL)
 ENDIF 
 DO WHILE  .NOT. EOF()
 MTANGGAL = TANGGAL
 MBUKTI = BUKTI
 MCOL = NOREK
 MDEBET = DEBET
 MKREDIT = KREDIT
 MJUMLAH = MDEBET - MKREDIT
 MBLN = MONTH(MTANGGAL)
 MTHN = YEAR(TANGGAL)
 CSQL =  ;
      'select SUM(simpokok) as pokok, SUM(simwajib) as wajib, SUM(simpanan) as tabungan, SUM(lain) as lain, ' +  ;
'sum(angpokok) as angpokok, SUM(angbunga) as angbunga, SUM(angdenda) as denda from col_instansi ' +  ;
'where kode=?mcol and instansi=?mcol and bln=?mbln and tahun=?mthn group by kode,instansi,bln,tahun'
 LCEK = SQLEXEC(OODBC,CSQL,'KOL')
 IF POKOK + WAJIB + TABUNGAN + LAIN + ANGPOKOK + ANGBUNGA + DENDA <> MJUMLAH
  MESSAGEBOX('tidak sama antara kasir dengan kolektor' + CHR(13) + 'kasir :' +  ;
TRANSFORM(MJUMLAH,'999,999,999,999') +  ;
' Kolektor :' +  ;
TRANSFORM(POKOK + WAJIB + TABUNGAN + LAIN + ANGPOKOK + ANGBUNGA + DENDA,'999,999,999,999'))
 RETURN 
 ENDIF 
 STORE 0 TO TMANASUKA , TMAPAN , TPENSIUN
 CSQL =  ;
      'select * from col_instansi where kode=?mcol and instansi=?mcol and bln=?mbln and tahun=?mthn'
 LCEK = SQLEXEC(OODBC,CSQL,'KOL')
 DO WHILE  .NOT. EOF()
 MNOANGG = NOANGG
 MTABUNGAN = SIMPANAN
 MANGPOKOK = ANGPOKOK
 MANGBUNGA = ANGBUNGA
 CSQL =  ;
      'select * from col_instansi_simp where kode=?mcol and instansi=?mcol and bln=?mbln and tahun=?mthn and noangg=?mnoangg'
 LCEK = SQLEXEC(OODBC,CSQL,'RINCI')
 STORE 0 TO MMANASUKA , MMAPAN , MPENSIUN
 DO WHILE  .NOT. EOF()
 DO CASE 
 CASE SANDI = '4'
 MMANASUKA = MMANASUKA + JUMLAH
 TMANASUKA = TMANASUKA + JUMLAH
 CASE SANDI = '5'
 MMAPAN = MMAPAN + JUMLAH
 TMAPAN = TMAPAN + JUMLAH
 CASE SANDI = '6'
 MPENSIUN = MPENSIUN + JUMLAH
 TPENSIUN = TPENSIUN + JUMLAH
 ENDCASE 
 SKIP 
 ENDDO 
 MMTS = MMANASUKA + MMAPAN + MPENSIUN
 IF MMTS <> MTABUNGAN
  MESSAGEBOX(MMTS)
 RETURN 
 ENDIF 
 CSQL =  ;
      'select * from col_instansi_pinj where kode=?mcol and instansi=?mcol and bln=?mbln and tahun=?mthn and noangg=?mnoangg'
 LCEK = SQLEXEC(OODBC,CSQL,'RINCI')
 STORE 0 TO MANGPK , MANGBG
 DO WHILE  .NOT. EOF()
 MANGPK = MANGPK + ANGPOKOK
 MANGBG = MANGBG + ANGBUNGA
 SKIP 
 ENDDO 
 IF MANGPK <> MANGPOKOK .OR. MANGBG <> MANGBUNGA
  MESSAGEBOX('terjadi selisih angsuran')
 RETURN 
 ENDIF 
 SELECT KOL
 SKIP 
 ENDDO 
 CSQL = 'select * from jurnal where tanggal=?mtanggal and bukti=?mbukti'
 LCEK = SQLEXEC(OODBC,CSQL,'jurnal')
 STORE 0 TO AKTMANASUKA , AKTMAPAN , AKTPENSIUN , AKTPINJ , AKTBUNGA
 DO WHILE  .NOT. EOF()
 DO CASE 
 CASE NOPER = '21021'
 AKTMANASUKA = AKTMANASUKA + (0 - JUMLAH)
 CASE NOPER = '21022'
 AKTMAPAN = AKTMAPAN + (0 - JUMLAH)
 CASE NOPER = '21026'
 AKTPENSIUN = AKTPENSIUN + (0 - JUMLAH)
 CASE NOPER = '11042'
 AKTPINJ = AKTPINJ + (0 - JUMLAH)
 CASE NOPER = '3102'
 AKTBUNGA = AKTBUNGA + (0 - JUMLAH)
 ENDCASE 
 SKIP 
 ENDDO 
 IF AKTMANASUKA <> TMANASUKA
  MESSAGEBOX('Jurnal dan Tabungan MANASUKA tidak sama' + CHR(13) + 'Instansi :' + MCOL + CHR(13) +  ;
'Jurnal   : ' +  ;
TRANSFORM(AKTMANASUKA,'999,999,999,999') +  ;
'      Kolektor: ' +  ;
TRANSFORM(TMANASUKA,'999,999,999,999'))
 ENDIF 
 IF AKTMAPAN <> TMAPAN
  MESSAGEBOX('Jurnal dan Tabungan MAPAN tidak sama' + CHR(13) + 'Instansi :' + MCOL + CHR(13) +  ;
'Jurnal   : ' +  ;
TRANSFORM(AKTMAPAN,'999,999,999,999') +  ;
'      Kolektor: ' +  ;
TRANSFORM(TMAPAN,'999,999,999,999'))
 ENDIF 
 IF AKTPENSIUN <> TPENSIUN
  MESSAGEBOX('Jurnal dan Tabungan PENSIUN tidak sama' + CHR(13) + 'Instansi :' + MCOL + CHR(13) +  ;
'Jurnal   : ' +  ;
TRANSFORM(AKTPENSIUN,'999,999,999,999') +  ;
'      Kolektor: ' +  ;
TRANSFORM(TPENSIUN,'999,999,999,999'))
 BROWSE 
 RETURN 
 ENDIF 
 SELECT KASIR
 SKIP 
 ENDDO 
*
