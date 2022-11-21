* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
*  FileName A_CEK_INSTANSI.PRG <-- This file create by UnFoxAll
* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


 CREATE CURSOR cek ( PERIODE C ( 6 ) , KODE C ( 2 ) , NOANGG C ( 10 ) , NAMA C ( 30 ) ,  ;
      KET C ( 20 ) , NOMI1 N ( 12 ) , NOMI2 N ( 12 ) , SELISIH N ( 12 ) )
 TEXT 
    select a.kode,a.bln,a.tahun,a.noangg,a.nama,simpokok, simwajib,lain,a.simpanan,sum(c.jumlah) as simpanan1, 
       a.angpokok,sum(b.angpokok) as angpokok1,a.angbunga,sum(b.angbunga) as angbunga1,a.angdenda,sum(b.angdenda) as AngDenda1 
       from col_instansi as a left join col_instansi_pinj as b on a.instansi=b.instansi and a.kode=b.kode and a.tahun=b.tahun and a.bln=b.bln and a.noangg=b.noangg 
       left join col_instansi_simp as c on a.instansi=c.instansi and a.kode=c.kode and a.tahun=c.tahun and a.bln=c.bln and a.noangg=c.noangg 
       where a.kantor='0001' and a.tahun='2016' and a.bln<>'1' group by a.noangg 
 ENDTEXT 
 LCEK = SQLEXEC(OODBC,STR1,'smt')
 IF LCEK < 1
  MESSAGEBOX(STR1)
 RETURN 
 ENDIF 
 GO TOP
 MNOANGG = ''
 MNAMA = ''
 MKODE = ''
 MPERIODE = ''
 DO WHILE  .NOT. EOF()
 IF SIMPANAN <> SIMPANAN1 .OR. ANGPOKOK <> ANGPOKOK1 .OR. ANGBUNGA <> ANGBUNGA1 .OR.  ;
ANGDENDA <> ANGDENDA1
 MNOANGG = NOANGG
 MNAMA = NAMA
 MKODE = KODE
 MPERIODE = ALLTRIM(STR(TAHUN)) + ALLTRIM(STR(BLN))
 DO CASE 
 CASE SIMPANAN <> SIMPANAN1
 MKET = 'SIMPANAN'
 MNOMI1 = SIMPANAN
 MNOMI2 = SIMPANAN1
 CASE ANGPOKOK <> ANGPOKOK1
 MKET = 'ANGS. POKOK'
 MNOMI1 = ANGPOKOK
 MNOMI2 = ANGPOKOK1
 CASE ANGBUNGA <> ANGBUNGA1
 MKET = 'ANGS. BUNGA'
 MNOMI1 = ANGBUNGA
 MNOMI2 = ANGBUNGA1
 CASE ANGDENDA <> ANGDENDA1
 MKET = 'DENDA'
 MNOMI1 = ANGDENDA
 MNOMI2 = ANGDENDA1
 ENDCASE 
 SELECT CEK
 APPEND BLANK
 REPLACE PERIODE WITH MPERIODE , KODE WITH MKODE , NOANGG WITH MNOANGG , NAMA WITH MNAMA ,  ;
      KET WITH MKET , NOMI1 WITH MNOMI1 , NOMI2 WITH MNOMI2 , SELISIH  ;
      WITH MNOMI2 - MNOMI1
 SELECT SMT
 ENDIF 
 SKIP 
 ENDDO 
 SELECT CEK
 INDEX ON PERIODE + KODE TO kode1
*
