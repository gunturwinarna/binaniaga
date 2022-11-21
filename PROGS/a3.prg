* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
*  FileName A3.PRG <-- This file create by UnFoxAll
* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


 CLOSE DATABASES 
 CLEAR 
 CREATE CURSOR tempcursor ( NOREK C ( 25 ) , NAMA C ( 25 ) , ALAMAT C ( 40 ) )
 APPEND BLANK
 REPLACE NOREK WITH '130.01.000001' , NAMA WITH 'COBA NAMA' , ALAMAT WITH  ;
      'ALAAAAAAAAAMAAAAAAAAAAATTT'
 LCTMPFRX = 'Test.frx'
 CREATE REPORT (LCTMPFRX) FROM (DBF())
 SELECT 0
 USE ctk_buku_header.frx
 SELECT 0
 USE EXCLUSIVE (LCTMPFRX)
 ZAP 
 APPEND FROM ctk_buku_header.frx
 SELECT * INTO TABLE temp.frx FROM (LCTMPFRX)
 USE 
 SELECT TEMPCURSOR
 REPORT FORM temp PREVIEW 
 RETURN 
*
