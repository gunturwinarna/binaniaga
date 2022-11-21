* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
*  FileName AA2.PRG <-- This file create by UnFoxAll
* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


 CSQL =  ;
      "select * from anggota_mutasi_x1 where tanggal>'2016-01-01' and tanggal<'2016-03-01'"
 LCEK = SQLEXEC(OODBC,CSQL,'smt')
 DO WHILE  .NOT. EOF()
 MKANTOR = KANTOR
 MCIF = CIF
 MTANGGAL = TANGGAL
 MBUKTI = ALLTRIM(BUKTI) + '.'
 MJNS = JNS
 MKD = KD
 MMTSPOKOK = MTSPOKOK
 MSLDPOKOK = SLDPOKOK
 MMTSSMK = MTSSMK
 MSALDOSMK = SALDOSMK
 MMTSWAJIB = MTSWAJIB
 MSLDWAJIB = SLDWAJIB
 MOPT = OPT
 CSQL =  ;
      'select * from anggota_mutasi where cif=?mcif and tanggal=?mtanggal and mtspokok=?mmtspokok and mtswajib=?mmtswajib'
 LCEK = SQLEXEC(OODBC,CSQL,'x')
 IF LCEK < 1
  MESSAGEBOX('gagal baca')
 RETURN 
 ENDIF 
 IF EMPTY(CIF)
 CSQL =  ;
      'INSERT INTO anggota_mutasi (kantor,cif,tanggal,bukti,jns,kd,mtspokok,sldpokok,mtswajib,sldwajib,opt) value ' +  ;
'(?mkantor,?mcif,?mtanggal,?mbukti,?mjns,?mkd,?mMtspokok,?msldpokok,?mmtswajib,?msldwajib,?mopt)'
 LCEK = SQLEXEC(OODBC,CSQL)
 IF LCEK < 1
  MESSAGEBOX('gagal')
 RETURN 
 ENDIF 
 ENDIF 
 SELECT SMT
 SKIP 
 ENDDO 
*
