* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
*  FileName SQL_LAPORAN.PRG <-- This file create by UnFoxAll
* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


 MKANTOR = 1
 DO CASE 
 CASE MKANTOR = 1
 MSQL = ''
 CSQL =  ;
      'insert into set_laporan (dept,nama,perintah,penjelasan) value ' +  ;
"('AKT','LAPORAN NERACA','" + MSQL +  ;
"','KHUSUS KPRI ABDI HUSADA, perkiraan akuntansi yg tidak setandar')"
 LCEK = SQLEXEC(OODBC,CSQL)
 OTHERWISE 
 ENDCASE 
*
