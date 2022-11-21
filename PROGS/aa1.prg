* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
*  FileName AA1.PRG <-- This file create by UnFoxAll
* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


 CSQL = 'select * from anggota_mutasi order by cif,tanggal,bukti'
 LCEK = SQLEXEC(OODBC,CSQL,'mutasi')
 MTANGGAL = CTOD('  -  -    ')
 MBUKTI = 'x'
 SAMA = 0
 MMTSPOKOK = 999999999999
 MMTSWAJIB = 999999999999
 MCIF = CIF
 DO WHILE  .NOT. EOF()
 IF MCIF = CIF AND MTANGGAL = TANGGAL AND MMTSPOKOK = MTSPOKOK AND MMTSWAJIB = MTSWAJIB
 MIDDATA = IDDATA
 CSQL = 'delete from anggota_mutasi where iddata=?middata'
 LCEK = SQLEXEC(OODBC,CSQL)
 SAMA = SAMA + 1
 ELSE 
 MTANGGAL = TANGGAL
 MCIF = CIF
 MMTSPOKOK = MTSPOKOK
 MMTSWAJIB = MTSWAJIB
 ENDIF 
 SKIP 
 ENDDO 
  MESSAGEBOX(SAMA)
  MESSAGEBOX(RECCOUNT())
*
