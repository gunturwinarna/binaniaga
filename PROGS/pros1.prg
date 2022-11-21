* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
*  FileName PROS1.PRG <-- This file create by UnFoxAll
* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


PROCEDURE bacaTempWord
 PARAMETER CTEKS
 LOCAL I , J , NFIELDLEN , CFIELDNAME , NTEXTLEN
 NTEXTLEN = LEN(CTEKS)
 J = 0
 NFIELDLEN = 0
 FOR I = 1 TO NTEXTLEN
 IF J = 0
 IF SUBSTR(CTEKS,I,1) = '['
 J = I
 NFIELDLEN = 1
 ENDIF 
 ELSE 
 NFIELDLEN = NFIELDLEN + 1
 IF SUBSTR(CTEKS,I,1) = ']'
 CFIELDNAME = SUBSTR(CTEKS,J + 1,NFIELDLEN - 2)
 CFIELDVALUE = ALLTRIM(EVALUATE(CFIELDNAME))
 CTEKS = STUFF(CTEKS,J,NFIELDLEN,CFIELDVALUE)
 J = 0
 NFIELDLEN = 0
 ENDIF 
 ENDIF 
 ENDFOR 
 RETURN CTEKS
ENDPROC
*------
PROCEDURE cetaktemp
 PARAMETER MTEMPLATE_ID , MNAMA_MENU , MKEY
 MNOREK = MKEY
 OLDSELECT1 = SELECT()
 CSQL =  ;
      "select * from set_print where template_id='" + MTEMPLATE_ID + "' and nama_menu='" +  ;
MNAMA_MENU + "' and dept<>''"
 LCEK = SQLEXEC(OODBC,CSQL,'SMT1')
 
 ctemplate1=CAST(template1 as w)
 MDEPT = DEPT
 MKEL = KEL
 MTEMPLATE_ID = TEMPLATE_ID
 MOPT_TYPE = OPT_TYPE
 MFILE0 = ''
 IF OPT_TYPE = 1
 MFILE1 = SYS(2023) + '\' + ALLTRIM(MTEMPLATE_ID) + '.FRX'
 ELSE 
 MFILE1 = SYS(2023) + '\' + ALLTRIM(MTEMPLATE_ID) + '.DOC'
 ENDIF 
 NHANDLE = FCREATE(MFILE1)
 IF NHANDLE > 0
  FWRITE(NHANDLE,CTEMPLATE1)
  FCLOSE(NHANDLE)
 ELSE 
  MESSAGEBOX('Tidak dapat membuat file dummy')
 RETURN .F.
 ENDIF 
 IF MOPT_TYPE = 1
 ctemplate2=CAST(template2 as w)
 
 MFILE0 = SYS(2023) + '\' + ALLTRIM(MTEMPLATE_ID) + '.FRT'
 NHANDLE = FCREATE(MFILE0)
 IF NHANDLE > 0
  FWRITE(NHANDLE,CTEMPLATE2)
  FCLOSE(NHANDLE)
 ELSE 
  MESSAGEBOX('Tidak dapat membuat file dummy')
 RETURN .F.
 ENDIF 
 REPORT FORM (MFILE1) PREVIEW 
 ENDIF 
 USE 
 IF MOPT_TYPE = 2
 NHANDLE = FCREATE(MFILE1)
 IF NHANDLE > 0
  FWRITE(NHANDLE,CTEMPLATE1)
  FCLOSE(NHANDLE)
 ELSE 
  MESSAGEBOX('Tidak dapat membuat file dummy')
 RETURN .F.
 ENDIF 
 WORD1 = NEWOBJECT('word')
  WORD1.OPENWORD()
  WORD1.OPENDOCUMENT(MFILE1)
  WORD1.ACTIVATEDOCUMENT(MFILE1)
 DO CASE 
 CASE MDEPT = 'KRD' .OR. MDEPT = 'PIN'
 OLDSELECT = SELECT()
 CSQL =  ;
      "select a.*,nama,tanggallhr,tempatlhr,alamat,desa,kecamatan,kota,pekerjaan,ibu,agama from pinjaman as a, anggota as b where a.cif=b.cif and norek='" +  ;
MNOREK +  ;
"'"
 LCEK = SQLEXEC(OODBC,CSQL,'SMT1')
 FOR I = 1 TO FCOUNT()
 A = FIELD(I)
 DO CASE 
  CASE VARTYPE(&a)="D"
  mvar=DTOC(&a)
  CASE VARTYPE(&a)="N"
  mvar=ALLTRIM(TRANSFORM(&a,'999,999,999,999'))
 OTHERWISE 
  mvar=&a
 ENDCASE 
 *KATA = "word1.findreplace('<<" + A + ">>','" + ALLTRIM(MVAR) + "')"
 KATA = "word1.findreplace('<<nama>>','" + ALLTRIM(MVAR) + "')"
  &kata
 ENDFOR 
 KATA = "word1.findreplace('<<defapimpinan>>','" + ALLTRIM(DEFAPIMPINAN) + "')"
  &kata
 KATA = "word1.findreplace('<<hari>>','" + TRANSFORM(DAY(TANGGAL),'99') + "')"
  &kata
 KATA = "word1.findreplace('<<namahari>>','" + NAMAHARI(TANGGAL) + "')"
  &kata
 KATA = "word1.findreplace('<<uraitgl(tanggal)>>','" + URAITGL(TANGGAL) + "')"
  &kata
 KATA =  ;
      "word1.findreplace('<<uraitgl(tgljtempo)>>','" + URAITGL(TGLJTEMPO) + "')"
  &kata
 KATA = "word1.findreplace('<<terbilang(pokok)>>','" + TERBILANG(POKOK) + "')"
  &kata
 KATA = "word1.findreplace('<<terbilang(lama)>>','" + TERBILANG(LAMA) + "')"
  &kata
 KATA = "word1.findreplace('<<terbilang(rate)>>','" + TERBILANG(RATE) + "')"
  &kata
 KATA = "word1.findreplace('<<terbilang(adm)>>','" + TERBILANG(ADM) + "')"
  &kata
 KATA =  ;
      "word1.findreplace('<<terbilang(provisi)>>','" + TERBILANG(PROVISI) + "')"
  &kata
 CSQL =  ;
      "select pokok as jdwpokok, jasa as jdwjasa from pinjaman_jadwal where norek='" +  ;
MNOREK + "' limit 1"
 LCEK = SQLEXEC(OODBC,CSQL,'smt')
 KATA =  ;
      "word1.findreplace('<<jdwpokok>>','" +  ;
ALLTRIM(TRANSFORM(JDWPOKOK,'999,999,999,999')) + "')"
  &kata
 KATA =  ;
      "word1.findreplace('<<jdwjasa>>','" + ALLTRIM(TRANSFORM(JDWJASA,'999,999,999,999')) +  ;
"')"
  &kata
 KATA =  ;
      "word1.findreplace('<<jdwpokok+jdwjasa>>','" +  ;
ALLTRIM(TRANSFORM(JDWPOKOK + JDWJASA,'999,999,999,999')) + "')"
  &kata
 KATA =  ;
      "word1.findreplace('<<terbilang(jdwpokok)>>','" + TERBILANG(JDWPOKOK) + "')"
  &kata
 KATA =  ;
      "word1.findreplace('<<terbilang(jdwjasa)>>','" + TERBILANG(JDWJASA) + "')"
  &kata
 KATA =  ;
      "word1.findreplace('<<terbilang(jdwpokok+jdwjasa)>>','" +  ;
TERBILANG(JDWPOKOK + JDWJASA) + "')"
  &kata
 CSQL = "select * from pinjaman_jaminan where norek='" + MNOREK + "'"
 LCEK = SQLEXEC(OODBC,CSQL,'JMN')
 IF NOREK = MNOREK
 DO WHILE  .NOT. EOF()
 MNOBERKAS = NOBERKAS
 DO CASE 
 CASE JENIS = 'KENDARAAN'
    CSQL = "select * from pinjaman_jaminan_bpkb where noberkas='" + MNOBERKAS + "'"
    LCEK = SQLEXEC(OODBC,CSQL,'smt')
    KATA = "word1.findreplace('<<BPKB.MERK>>','" + ALLTRIM(MERK) + "')"
     &kata 
    KATA = "word1.findreplace('<<BPKB.TYPE>>','" + ALLTRIM(TYPE) + "')"
     &kata 
    KATA = "word1.findreplace('<<BPKB.TAHUN>>','" + ALLTRIM(TAHUN) + "')"
     &kata 
    KATA = "word1.findreplace('<<BPKB.NOMESIN>>','" + ALLTRIM(NOMESIN) + "')"
     &kata 
    KATA = "word1.findreplace('<<BPKB.NORANGKA>>','" + ALLTRIM(NORANGKA) + "')"
     &kata 
    KATA = "word1.findreplace('<<BPKB.NOBPKB>>','" + ALLTRIM(NOBPKB) + "')"
     &kata 
    KATA =  ;
         "word1.findreplace('<<BPKB.NOPOLISI>>','" + TRANSFORM(NOPOLISI,'@R !!-!!!!-!!!!') +  ;
   "')"
     &kata 
    KATA = "word1.findreplace('<<BPKB.WARNA>>','" + ALLTRIM(WARNA) + "')"
     &kata 
    KATA = "word1.findreplace('<<BPKB.NAMA>>','" + ALLTRIM(ATASNAMA) + "')"
     &kata 
    KATA = "word1.findreplace('<<BPKB.ALAMAT>>','" + ALLTRIM(ALAMAT) + "')"
     &kata 
 CASE JENIS = 'SERTIFIKAT'
    CSQL =  ;
         "select * from pinjaman_jaminan_sertifikat where noberkas='" + MNOBERKAS + "'"
    LCEK = SQLEXEC(OODBC,CSQL,'smt')
    KATA = "word1.findreplace('<<SERTIFIKAT.STATUS>>','" + ALLTRIM(STATUS) + "')"
     &kata 
    KATA =  ;
         "word1.findreplace('<<SERTIFIKAT.NOSERTIFIKAT>>','" + ALLTRIM(NOSERTIFIKAT) + "')"
     &kata 
    KATA =  ;
         "word1.findreplace('<<SERTIFIKAT.TGLSERTIFIKAT>>','" + DTOC(TGLSERTIFIKAT) + "')"
     &kata 
    KATA =  ;
         "word1.findreplace('<<SERTIFIKAT.NOSURATUKUR>>','" + ALLTRIM(NOSURATUKUR) + "')"
     &kata 
    KATA =  ;
         "word1.findreplace('<<SERTIFIKAT.TGLSURATUKUR>>','" + DTOC(TGLSURATUKUR) + "')"
     &kata 
    KATA =  ;
         "word1.findreplace('<<SERTIFIKAT.LUAS>>','" +  ;
   ALLTRIM(TRANSFORM(LUAS,'999,999,999,999')) + "')"
     &kata 
    KATA = "word1.findreplace('<<SERTIFIKAT.NAMA>>','" + ALLTRIM(NAMA) + "')"
     &kata 
    KATA = "word1.findreplace('<<SERTIFIKAT.ALAMAT>','" + ALLTRIM(ALAMAT) + "')"
     &kata 
 CASE JENIS = 'SIMPANAN'
    CSQL =  ;
         "select * from pinjaman_jaminan_simpanan where noberkas='" + MNOBERKAS + "'"
    LCEK = SQLEXEC(OODBC,CSQL,'smt')
 CASE JENIS = 'LAIN'
    CSQL = "select * from pinjaman_jaminan_lain where noberkas='" + MNOBERKAS + "'"
    LCEK = SQLEXEC(OODBC,CSQL,'smt')
 ENDCASE 
 SELECT JMN
 SKIP 
 ENDDO 
 USE 
 ENDIF 
 SELECT SMT
 USE 
 SELECT (OLDSELECT)
 CASE MDEPT = 'SIM'
 OLDSELECT = SELECT()
 CSQL =  ;
      "select a.*,nama,b.tanggal as tglanggota,alamat,desa,kecamatan,kota,ibu,agama from simpanan as a, anggota as b where a.cif=b.cif and norek='" +  ;
MKEY + "'"
 LCEK = SQLEXEC(OODBC,CSQL,'SMT1')
 FOR I = 1 TO FCOUNT()
 A = FIELD(I)
 DO CASE 
  CASE VARTYPE(&a)="D"
  mvar=DTOC(&a)
  CASE VARTYPE(&a)="N"
  mvar=ALLTRIM(TRANSFORM(&a,'999,999,999,999'))
 OTHERWISE 
  mvar=IIF(ISNULL(&a),'',&a)
 ENDCASE 
 KATA = "word1.findreplace('<<" + A + ">>','" + MVAR + "')"
  &kata
 ENDFOR 
 KATA = "word1.findreplace('<<defapimpinan>>','" + ALLTRIM(DEFAPIMPINAN) + "')"
  &kata
 KATA =  ;
      "word1.findreplace('<<terbilang(pokok)>>','" + TERBILANG(POKOK) + ' Rupiah' + "')"
  &kata
 KATA = "word1.findreplace('<<uraitgl(tanggal)>>','" + URAITGL(TANGGAL) + "')"
  &kata
 KATA = "word1.findreplace('<<defakota>>','" + ALLTRIM(DEFAKOTA) + "')"
  &kata
 MNOREK = NOREK
 USE 
 CSQL = 'select * from simpanan_bilyet where norek=?mnorek'
 LCEK = SQLEXEC(OODBC,CSQL,'smt1')
 FOR I = 1 TO FCOUNT()
 A = FIELD(I)
 DO CASE 
  CASE VARTYPE(&a)="D"
  mvar=DTOC(&a)
  CASE VARTYPE(&a)="N"
  mvar=ALLTRIM(TRANSFORM(&a,'999,999,999,999'))
 OTHERWISE 
  mvar=IIF(ISNULL(&a),'',&a)
 ENDCASE 
 KATA = "word1.findreplace('<<" + A + ">>','" + MVAR + "')"
  &kata
 ENDFOR 
 USE 
 SELECT (OLDSELECT)
 CASE MDEPT = 'JMN'
 CASE MDEPT = 'AGT'
 OLDSELECT = SELECT()
 CSQL = "select * from anggota where cif='" + MKEY + "'"
 LCEK = SQLEXEC(OODBC,CSQL,'SMT1')
 FOR I = 1 TO FCOUNT()
 A = FIELD(I)
 DO CASE 
  CASE VARTYPE(&a)="D"
  mvar=DTOC(&a)
  CASE VARTYPE(&a)="N"
  mvar=ALLTRIM(TRANSFORM(&a,'999,999,999,999'))
 OTHERWISE 
  mvar=&a
 ENDCASE 
 KATA = "word1.findreplace('<<" + A + ">>','" + MVAR + "')"
  &kata
 ENDFOR 
 USE 
 SELECT (OLDSELECT)
 CASE MDEPT = 'KAS'
 OLDSELECT = SELECT()
 CSQL = "select * from kasir where tanggal='" + MKEY + "'"
 LCEK = SQLEXEC(OODBC,CSQL,'SMT1')
 FOR I = 1 TO FCOUNT()
 A = FIELD(I)
 DO CASE 
  CASE VARTYPE(&a)="D"
  mvar=DTOC(&a)
  CASE VARTYPE(&a)="N"
  mvar=ALLTRIM(TRANSFORM(&a,'999,999,999,999'))
 OTHERWISE 
  mvar=&a
 ENDCASE 
 KATA = "word1.findreplace('<<" + A + ">>','" + MVAR + "')"
  &kata
 ENDFOR 
 USE 
 SELECT (OLDSELECT)
 CASE MDEPT = 'ANG'
 CASE MDEPT = 'JDW'
 ENDCASE 
  WORD1.SETWINDOWSTATE(1)
  WORD1.EDITDOCUMENT()
  WORD1.SAVEASDOCUMENT(MFILE1)
 IF  .NOT. DEFAUSERID = 'IMR'
  WORD1.PRINTDOCUMENT()
  WORD1.CLOSEDOCUMENT(MFILE1)
  WORD1.CLOSEWORD()
 ENDIF 
 ELSE 
 DO CASE 
 CASE MDEPT = 'KRD' .OR. MDEPT = 'PIN'
 OLDSELECT = SELECT()
 CSQL = "select * from pinjaman where norek='" + MNOREK + "'"
 LCEK = SQLEXEC(OODBC,CSQL,'PINJAMAN')
 MCIF = CIF
 CSQL = "select * from anggota where cif='" + MCIF + "'"
 LCEK = SQLEXEC(OODBC,CSQL,'ANGGOTA')
 CSQL = "select * from pinjaman_jadwal where norek='" + MNOREK + "'"
 LCEK = SQLEXEC(OODBC,CSQL,'JADWAL')
 CSQL = "select * from pinjaman_mutasi where norek='" + MNOREK + "'"
 LCEK = SQLEXEC(OODBC,CSQL,'ANGSUR')
 IF DEFAUSERID = 'IMR'
 REPORT FORM (MFILE1) PREVIEW 
 ELSE 
 REPORT FORM (MFILE1) TO PRINTER
 ENDIF 
 SELECT PINJAMAN
 USE 
 SELECT ANGGOTA
 USE 
 SELECT JADWAL
 USE 
 SELECT ANGSUR
 USE 
 SELECT (OLDSELECT)
 CASE MDEPT = 'SIM'
 CASE MDEPT = 'JMN'
 CASE MDEPT = 'AGT'
 CASE MDEPT = 'KAS'
 CASE MDEPT = 'ANG'
 CASE MDEPT = 'JDW'
 ENDCASE 
 ENDIF 
 IF MOPT_TYPE = 1
 DELETE File (MFILE0)
 ENDIF 
 SELECT (OLDSELECT1)
ENDPROC
*------
PROCEDURE noanggnext
 LOCAL OLDSELECT , NOAKHIR , MTAHUN , MNOANGG , MNOMOR
 OLDSELECT = SELECT()
 MCARA = '1'
 DO CASE 
 CASE MCARA = '1'
 CSQL = 'select MAX(cif) as nomer from anggota'
 LCEK = SQLEXEC(OODBC,CSQL,'SMT')
 IF LCEK < 1
 RETURN ''
 ENDIF 
 NOAKHIR = NOMER
 USE 
 SELECT (OLDSELECT)
 MNOANGG = VAL(ALLTRIM(NOAKHIR))
 PANJANG = LEN(ALLTRIM(NOAKHIR))
 MNOANGG = MNOANGG + 1
 MNOMOR = RIGHT('0000000000000' + ALLTRIM(STR(MNOANGG)),PANJANG)
 MNOANGG = MNOMOR
 CASE MCARA = '2'
 CSQL = 'select MAX(cif) as nomer from anggota'
 LCEK = SQLEXEC(OODBC,CSQL,'SMT')
 IF LCEK < 1
 RETURN ''
 ENDIF 
 NOAKHIR = NOMER
 USE 
 SELECT (OLDSELECT)
 MTAHUN = LEFT(NOAKHIR,2)
 IF MTAHUN <> RIGHT(ALLTRIM(STR(YEAR(DATE()))),2)
 MNOANGG = RIGHT(ALLTRIM(STR(YEAR(DATE()))),2) + '.0000001'
 ELSE 
 MNOANGG = VAL(SUBSTR(NOAKHIR,4,7))
 PANJANG = LEN(ALLTRIM(NOAKHIR)) - 3
 MNOANGG = MNOANGG + 1
 MNOMOR = RIGHT('0000000000000' + ALLTRIM(STR(MNOANGG)),PANJANG)
 MNOANGG = MTAHUN + '.' + MNOMOR
 ENDIF 
 CASE MCARA = '3'
 ENDCASE 
 RETURN MNOANGG
ENDPROC
*------
PROCEDURE setperkiraan
&&----No event!
ENDPROC
