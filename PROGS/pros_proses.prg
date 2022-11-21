* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
*  FileName PROS_PROSES.PRG <-- This file create by UnFoxAll
* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-



PROCEDURE pros_inv
 PARAMETER MTGL1 , MBUKTI
 CSQL = "select * from gl_inventaris where nilaibuku>'0'"
 LCEK = SQLEXEC(OODBC,CSQL,'SMT')
 LOCAL MNOMOR , MTANGGAL , MHARGA , MLAMA , MTGLAWAL , MTGLAKHIR , MKE , MPERBULAN ,  ;
      MHARUS , MSEKARANG
 GO TOP
 DO WHILE  .NOT. EOF()
 MNOMOR = NOMOR
 MTANGGAL = TGLPEROLEHAN
 MHARGA = VAL(HARGA)
 MLAMA = LAMA
 MTGLAWAL = AWALBLN(MTANGGAL)
 MTGLAKHIR = AWALBLN(MTGL1)
 MKE =  ;
      ((YEAR(MTGLAKHIR) - YEAR(MTGLAWAL)) * 12) + (MONTH(MTGLAKHIR) - MONTH(MTGLAWAL)) +  ;
1
 MPERBULAN = PENYUSUTAN
 MHARUS = MKE * MPERBULAN
 MSEKARANG = VAL(NILAIBUKU) - (MHARGA - MHARUS)
 IF MSEKARANG <> 0
 CSQL =  ;
      'insert into gl_inventaris_mutasi (nobuku,tanggal, bukti, keterangan, debet, kredit) value ' +  ;
"('" + ALLTRIM(STR(MNOMOR)) + "'," + "'" + SQLDATE(MTGL1) + "'," +  ;
"'" + MBUKTI + "'," + "'" + 'PENYUSUTAN BY SYSTEM' + "'," + "'" +  ;
STR(IIF(MSEKARANG > 0,MSEKARANG,0)) + "'," + "'" +  ;
STR(IIF(MSEKARANG < 0,0 - MSEKARANG,0)) + "')"
 LCEK = SQLEXEC(OODBC,CSQL)
 IF LCEK < 1
  MESSAGEBOX(CSQL)
 ENDIF 
 ENDIF 
 SELECT SMT
 SKIP 
 ENDDO 
 SELECT SMT
 USE 
ENDPROC
*------
PROCEDURE pros_BDD
 PARAMETER MTGL1 , MBUKTI
 CSQL = "select * from gl_biayadimuka where sisa>'0'"
 LCEK = SQLEXEC(OODBC,CSQL,'SMT')
 LOCAL MNOMOR , MNAMA , MTANGGAL , MHARGA , MLAMA , MTGLAWAL , MTGLAKHIR , MKE ,  ;
      MPERBULAN , MHARUS , MSEKARANG
 GO TOP
 DO WHILE  .NOT. EOF()
 MNOMOR = NOMOR
 MNAMA = NAMA
 MKETERANGAN = KETERANGAN
 MTANGGAL = TANGGAL
 MBIAYA = VAL(BIAYA)
 MLAMA = LAMA
 MTGLAWAL = MTANGGAL
 MAMORPERHARI = INT(MBIAYA / (TGLAKHIR - TANGGAL))
 MLAMAHARI = MTGL1 - MTANGGAL
 MPERBULAN = PENYUSUTAN
 MHARUS = MLAMAHARI * MAMORPERHARI
 MSEKARANG = VAL(SISA) - (MBIAYA - MHARUS)
 IF MSEKARANG <> 0
 CSQL =  ;
      'insert into gl_biayadimuka_mutasi (nobuku,tanggal, bukti, keterangan, debet, kredit) value ' +  ;
"('" + ALLTRIM(STR(MNOMOR)) + "'," + "'" + SQLDATE(MTGL1) +  ;
"'," + "'" + MBUKTI + "'," + "'" + 'AMORTISASI BY SYSTEM' + "'," + "'" +  ;
STR(IIF(MSEKARANG > 0,MSEKARANG,0)) + "'," + "'" +  ;
STR(IIF(MSEKARANG < 0,0 - MSEKARANG,0)) + "')"
 LCEK = SQLEXEC(OODBC,CSQL)
 IF LCEK < 1
  MESSAGEBOX(CSQL)
 ENDIF 
 ENDIF 
 SELECT SMT
 SKIP 
 ENDDO 
 SELECT SMT
 USE 
ENDPROC
*------
PROCEDURE pros_Akrual_ABA
 PARAMETER MTGL1 , MBUKTI
 CSQL =  ;
      'select *,' +  ;
"@sldaw=(SELECT saldo from gl_antarbank_akrual where nomorbuku=a.nomorbuku and tanggal='" + SQLDATE(MTGL1 - 1) + "') as sldawal " +  ;
"@ppap1=(SELECT SUM(ppap_debet)-SUM(ppap_kredit) from gl_antarbank_akrual where nomorbuku=a.nomorbuku and tanggal>='" +  ;
SQLDATE(AWALBLN(MTGL1)) + "' and tanggal<'" +  ;
SQLDATE(MTGL1) + "') as jumppap " + ' from gl_antarbank'
 LCEK = SQLEXEC(OODBC,CSQL,'SMT')
 GO TOP
 DO WHILE  .NOT. EOF()
 MSALDO = VAL(SALDO)
 MJUMMTS = MSALDO - SLDAWAL
 MBUNGA = MJUMMTS * (RATE / 365)
 MPAJAK = IIF(MSALDO > 7500000,MBUNGA * 0.2,0)
 MPPAP = JUMPPAP
 MHRSPPAP = MSALDO * 0.005
 MPPAPNOW = MHRSPPAP - MPPAP
 IF MBUNGA <> 0 .OR. MPPAPNOW <> 0
 CSQL =  ;
      'insert into gl_antarbank_akrual (nomorbuku,tanggal,bukti,keterangan,saldo,bg_debet,' +  ;
'bg_kredit,pj_debet,pj_kredit,ppap_debet,ppap_kredit) value ' + "('" +  ;
ALLTRIM(STR(MNOMOR)) + "'," + "'" + SQLDATE(MTGL1) + "'," + "'" + MBUKTI +  ;
"'," + "'" + 'AKRUAL ABA BY SYSTEM' + "'," + "'" + STR(MSALDO) + "'," + "'" +  ;
STR(IIF(MBUNGA > 0,MBUNGA,0)) + "'," + "'" + STR(0) + "'," + "'" +  ;
STR(IIF(MPAJAK > 0,MPAJAK,0)) + "'," + "'" + STR(0) + "'," + "'" +  ;
STR(IIF(MPPAPNOW > 0,MPPAPNOW,0)) + "'," + "'" + STR(IIF(MPPAPNOW < 0,0 - MPPAPNOW,0)) + "')"
 LCEK = SQLEXEC(OODBC,CSQL)
 IF LCEK < 1
  MESSAGEBOX(CSQL)
 ENDIF 
 ENDIF 
 SELECT SMT
 SKIP 
 ENDDO 
 SELECT SMT
 USE 
ENDPROC
*------
PROCEDURE pros_Akrual_PINJ
 PARAMETER MTGL1 , MBUKTI
 CSQL =  ;
      'select *,' +  ;
"@sldaw=(SELECT saldo from pinjaman_akrual where nomorbuku=a.nomorbuku and tanggal='" + SQLDATE(MTGL1 - 1) + "') as sldawal " +  ;
"@ppap1=(SELECT SUM(ppap_debet)-SUM(ppap_kredit) from gl_antarbank_akrual where nomorbuku=a.nomorbuku and tanggal>='" +  ;
SQLDATE(AWALBLN(MTGL1)) + "' and tanggal<'" +  ;
SQLDATE(MTGL1) + "') as jumppap " + ' from pinjaman_akrual'
 LCEK = SQLEXEC(OODBC,CSQL,'SMT')
 GO TOP
 DO WHILE  .NOT. EOF()
 MSALDO = VAL(SALDO)
 MJUMMTS = MSALDO - SLDAWAL
 MBUNGA = MJUMMTS * (RATE / 365)
 MPAJAK = IIF(MSALDO > 7500000,MBUNGA * 0.2,0)
 MPPAP = JUMPPAP
 MHRSPPAP = MSALDO * 0.005
 MPPAPNOW = MHRSPPAP - MPPAP
 IF MBUNGA <> 0 .OR. MPPAPNOW <> 0
 CSQL =  ;
      'insert into gl_antarbank_akrual (nomorbuku,tanggal,bukti,keterangan,saldo,bg_debet,' +  ;
'bg_kredit,pj_debet,pj_kredit,ppap_debet,ppap_kredit) value ' + "('" +  ;
ALLTRIM(STR(MNOMOR)) + "'," + "'" + SQLDATE(MTGL1) + "'," + "'" + MBUKTI +  ;
"'," + "'" + 'AKRUAL ABA BY SYSTEM' + "'," + "'" + STR(MSALDO) + "'," + "'" +  ;
STR(IIF(MBUNGA > 0,MBUNGA,0)) + "'," + "'" + STR(0) + "'," + "'" +  ;
STR(IIF(MPAJAK > 0,MPAJAK,0)) + "'," + "'" + STR(0) + "'," + "'" +  ;
STR(IIF(MPPAPNOW > 0,MPPAPNOW,0)) + "'," + "'" + STR(IIF(MPPAPNOW < 0,0 - MPPAPNOW,0)) + "'," +  ;
"')"
 LCEK = SQLEXEC(OODBC,CSQL)
 IF LCEK < 1
  MESSAGEBOX(CSQL)
 ENDIF 
 ENDIF 
 SELECT SMT
 SKIP 
 ENDDO 
 SELECT SMT
 USE 
ENDPROC
*------
PROCEDURE pros_Akrual_ABA
 PARAMETER MTGL1 , MBUKTI
 CSQL =  ;
      'select *,' +  ;
"@sldaw=(SELECT saldo from gl_antarbank where nomorbuku=a.nomorbuku and tanggal='" + SQLDATE(MTGL1 - 1) + "') as sldawal " +  ;
"@ppap1=(SELECT SUM(ppap_debet)-SUM(ppap_kredit) from gl_antarbank where nomorbuku=a.nomorbuku and tanggal>='" +  ;
SQLDATE(AWALBLN(MTGL1)) + "' and tanggal<'" +  ;
SQLDATE(MTGL1) + "') as jumppap " + ' from gl_antarbank'
 CSQL = SQLEXEC(OODBC,CSQL,'SMT')
 GO TOP
 DO WHILE  .NOT. EOF()
 MSALDO = VAL(SALDO)
 MJUMMTS = MSALDO - SLDAWAL
 MBUNGA = MJUMMTS * (RATE / 365)
 MPAJAK = IIF(MSALDO > 7500000,MBUNGA * 0.2,0)
 MPPAP = JUMPPAP
 MHRSPPAP = MSALDO * 0.005
 MPPAPNOW = MHRSPPAP - MPPAP
 IF MBUNGA <> 0 .OR. MPPAPNOW <> 0
 CSQL =  ;
      'insert into gl_antarbank_akrual (nomorbuku,tanggal,bukti,keterangan,saldo,bg_debet,' +  ;
'bg_kredit,pj_debet,pj_kredit,ppap_debet,ppap_kredit) value ' + "('" +  ;
ALLTRIM(STR(MNOMOR)) + "'," + "'" + SQLDATE(MTGL1) + "'," + "'" + MBUKTI +  ;
"'," + "'" + 'AKRUAL ABA BY SYSTEM' + "'," + "'" + STR(MSALDO) + "'," + "'" +  ;
STR(IIF(MBUNGA > 0,MBUNGA,0)) + "'," + "'" + STR(0) + "'," + "'" +  ;
STR(IIF(MPAJAK > 0,MPAJAK,0)) + "'," + "'" + STR(0) + "'," + "'" +  ;
STR(IIF(MPPAPNOW > 0,MPPAPNOW,0)) + "'," + "'" + STR(IIF(MPPAPNOW < 0,0 - MPPAPNOW,0)) + "'," +  ;
"')"
 LCEK = SQLEXEC(OODBC,CSQL)
 IF LCEK < 1
  MESSAGEBOX(CSQL)
 ENDIF 
 ENDIF 
 SELECT SMT
 SKIP 
 ENDDO 
 SELECT SMT
 USE 
ENDPROC
*------
PROCEDURE pros_neraca
 PARAMETER MTGL1
 CSQL = "delete from neraca where tanggal='" + SQLDATE(MTGL1) + "'"
 LCEK = SQLEXEC(OODBC,CSQL)
 MSQL = 'insert into neraca (tanggal,noper,saldoawal) value '
 CSQL =  ;
      'select noper,@msld:=(select saldo from neraca where noper=a.noper ' +  ;
" and tanggal<'" + SQLDATE(MTGL1) + "' order by tanggal desc limit 0,1) as saldo " +  ;
'from perkiraan as a'
 LCEK = SQLEXEC(OODBC,CSQL,'SMT')
 DO WHILE  .NOT. EOF()
 MSALDO = IIF(ISNULL(SALDO),0,VAL(SALDO))
 MSQL =  ;
      MSQL + "('" + SQLDATE(MTGL1) + "','" + ALLTRIM(NOPER) + "','" + STR(MSALDO) + "'),"
 SKIP 
 ENDDO 
 MSQL = LEFT(MSQL,LEN(MSQL) - 1)
 USE 
 LCEK = SQLEXEC(OODBC,MSQL)
 CSQL =  ;
      "select noper from jurnal where tanggal='" + SQLDATE(MTGL) + "' group by noper "
 LCEK = SQLEXEC(OODBC,CSQL,'SMT')
 DO WHILE  .NOT. EOF()
 MNOPER = NOPER
 CSQL =  ;
      "select SUM(jumlah) as jml from jurnal where noper='" + MNOPER + "' and tanggal='" +  ;
SQLDATE(MTGL1) + "' and jumlah>0"
 LCEK = SQLEXEC(OODBC,CSQL,'SMT1')
 MJUMDEBET = JML
 CSQL =  ;
      "select SUM(jumlah) as jml from jurnal where noper='" + MNOPER + "' and tanggal='" +  ;
SQLDATE(MTGL1) + "' and jumlah<0"
 LCEK = SQLEXEC(OODBC,CSQL,'SMT1')
 MJUMKREDIT = JML
 USE 
 CSQL =  ;
      "UPDATE neraca set debet='" + STR(MJUMDEBET) + "', kredit='" + STR(MJUMKREDIT) +  ;
"' where noper='" + MNOPER + "' and tanggal='" + SQLDATE(MTGL) + "'"
 LCEK = SQLEXEC(OODBC,CSQL)
 SELECT SMT
 SKIP 
 ENDDO 
 RETURN 
ENDPROC
*------
PROCEDURE hit_posneraca
 PARAMETER MNOPER , MTGL1 , MTGL2
 MTGL = MTGL1
 DO WHILE .T.
 IF MTGL > MTGL2
 EXIT 
 ENDIF 
 CSQL =  ;
      "select saldo from neraca where noper='" + MNOPER + "' " + "and tanggal<'" +  ;
SQLDATE(MTGL) + "' order by tanggal desc limit 1"
 LCEK = SQLEXEC(OODBC,CSQL,'SMT')
 MSALDO = IIF(ISNULL(SALDO) .OR. EMPTY(SALDO),0,SALDO)
 CSQL =  ;
      "UPDATE neraca set saldoawal='" + STR(MSALDO) + "' where noper='" + MNOPER +  ;
"' and tanggal='" + SQLDATE(MTGL) + "'"
 LCEK = SQLEXEC(OODBC,CSQL)
 MTGL = MTGL + 1
 ENDDO 
 RETURN 
ENDPROC

*------ hitberaca

PROCEDURE hitneraca
 PARAMETER MKANTOR , MNOPER , MTANGGAL
 IF EMPTY(MNOPER) .OR. EMPTY(MTANGGAL)
    RETURN 
 ENDIF 
 CSQL = "select * from perkiraan where noper='" + MNOPER + "' "
 LCEK = SQLEXEC(OODBC,CSQL)
 IF MTANGGAL <> TGLNOW
 CSQL =  ;
      'insert into log_memo (bag,tanggal,bukti,keterangan,jumlah,opt,catatan) value ' +  ;
	  "('AKT','" + SQLDATE(MTANGGAL) + "','" + 'bukti' +  ;
      "','KETERANGAN','0','opt','catatan')"
  LCEK = SQLEXEC(OODBC,CSQL)
  IF LCEK < 1
     MESSAGEBOX('Gagal Beri keterangan log')
  ENDIF 
 ENDIF 
 CSQL =  ;
      'select sum(case when jumlah>0 then jumlah else 0 end) as jdebet, ' +  ;
		"SUM(case when jumlah<0 then jumlah else 0 end) as jkredit from jurnal where tanggal='" +  ;
		SQLDATE(MTANGGAL) + "' and noper='" + ALLTRIM(MNOPER) + "' and kantor='" +  ;
		MKANTOR + "'"
 LCEK = SQLEXEC(OODBC,CSQL,'SMT')
 IF LCEK < 1
  MESSAGEBOX('Gagal Proses hitung neraca')
 ENDIF 
 
 MDEBET = IIF(ISNULL(JDEBET),0,JDEBET)
 MKREDIT = IIF(ISNULL(JKREDIT),0,JKREDIT)
 USE 
 MSALDOAWAL = BACANERACA(MKANTOR,MNOPER,MTANGGAL,'AWAL')
 CSQL =  ;
      'select noper,saldo from neraca where noper=?mNoper and kantor=?mKantor and tanggal=?mtanggal'
 LCEK = SQLEXEC(OODBC,CSQL,'SMT')
 IF LCEK < 1
  MESSAGEBOX('cek jurnal gagal')
 ENDIF 
 IF ALLTRIM(NOPER) = ALLTRIM(MNOPER)
	 CSQL =  ;
	      "update neraca set saldoawal='" + TRANSFORM(MSALDOAWAL,'9999999999999') +  ;
			"',debet='" + TRANSFORM(MDEBET,'9999999999999') + "',kredit='" +  ;
			TRANSFORM(MKREDIT,'9999999999999') + "', saldo='" +  ;
			TRANSFORM(MSALDOAWAL + MDEBET + MKREDIT,'9999999999999') + "' where noper='" + ALLTRIM(MNOPER) + "' and tanggal='" +  ;
			SQLDATE(MTANGGAL) + "' and kantor='" + MKANTOR + "'"
	 LCEK = SQLEXEC(OODBC,CSQL)
	 IF LCEK < 1
	  MESSAGEBOX('Gagal Update Neraca')
	 ENDIF 
 ELSE 
	 IF MDEBET <> 0 .OR. MKREDIT <> 0
	   *  MESSAGEBOX(MSALDOAWAL)
		 CSQL =  ;
		      'insert ignore into neraca (kantor,noper,tanggal,saldoawal,debet,kredit,saldo) value ' +  ;
	 	"('" + MKANTOR + "','" + ALLTRIM(MNOPER) + "','" + SQLDATE(MTANGGAL) +  ;
		"','" + TRANSFORM(MSALDOAWAL,'9999999999999') + "','" +  ;
		TRANSFORM(MDEBET,'9999999999999') + "','" + TRANSFORM(MKREDIT,'9999999999999') + "','" +  ;
		TRANSFORM(MSALDOAWAL + MDEBET + MKREDIT,'9999999999999') + "')"
		LCEK = SQLEXEC(OODBC,CSQL)
		 IF LCEK < 1
		  MESSAGEBOX('Gagal Insert neraca')
		 ENDIF 
	 ENDIF 
 ENDIF 
ENDPROC

*------
PROCEDURE hitlaba
 PARAMETER MTGL
 FORMULALABA = ALLTRIM(DEFANOPERFORMULA)
* MESSAGEBOX(FORMULALABA)
 IF OCCURS('+',FORMULALABA) > 0
 	MFORMULA = STRTRAN(FORMULALABA,'+',"%' or noper like '")
 	MFORMULA = "noper like '" + MFORMULA + "%'"
 ELSE 
	MFORMULA = "noper like '" + FORMULALABA + "%'"
 ENDIF 
* MESSAGEBOX(mFORMULA)
 CSQL =  ;
      "select SUM(debet+kredit) as sld from neraca where tanggal='" + SQLDATE(MTGL) +  ;
"' and (" + MFORMULA + ')'
 LCEK = SQLEXEC(OODBC,CSQL,'xx')
 
  *MESSAGEBOX(csql)
 
 MSALDO1 = IIF(ISNULL(SLD),0,SLD)
 MSALDOAWAL = BACANERACA(DEFAKANTOR,DEFANOPERPHUNOW,MTGL,'AWAL')
 CSQL =  ;
      "select noper from neraca where noper='" + DEFANOPERPHUNOW + "' and tanggal='" +  ;
SQLDATE(MTGL) + "'"
 LCEK = SQLEXEC(OODBC,CSQL,'smt')
 IF LCEK < 1
  MESSAGEBOX(CSQL)
 ENDIF 
 
 IF NOPER = ALLTRIM(DEFANOPERPHUNOW)
 
*!*	  MESSAGEBOX('UPDATE')
*!*	  MESSAGEBOX(DEFANOPERPHUNOW)
*!*	  MESSAGEBOX(MSALDOAWAL)
*!*	  MESSAGEBOX(MSALDO1)
  
 CSQL =  ;
      "update neraca set saldoawal='" + TRANSFORM(MSALDOAWAL,'9999999999999') +  ;
"', debet='" + TRANSFORM(IIF(MSALDO1 > 0,MSALDO1,0),'9999999999999') + "', kredit='" +  ;
TRANSFORM(IIF(MSALDO1 < 0,MSALDO1,0),'9999999999999') + "', saldo='" +  ;
TRANSFORM(MSALDOAWAL + MSALDO1,'9999999999999') + "' " + " where noper='" +  ;
DEFANOPERPHUNOW + "' and tanggal='" + SQLDATE(MTGL) + "'"
 LCEK = SQLEXEC(OODBC,CSQL)
 IF LCEK < 1
  MESSAGEBOX(CSQL)
 ENDIF 
 ELSE 
 CSQL =  ;
      'insert into neraca (kantor,noper,tanggal,saldoawal,debet,kredit,saldo) value ' +  ;
"('" + DEFAKANTOR + "','" + ALLTRIM(DEFANOPERPHUNOW) + "','" + SQLDATE(MTGL) +  ;
"','" + TRANSFORM(MSALDOAWAL,'9999999999999') + "','" +  ;
TRANSFORM(IIF(MSALDO1 > 0,MSALDO1,0),'9999999999999') + "','" +  ;
TRANSFORM(IIF(MSALDO1 < 0,MSALDO1,0),'9999999999999') + "','" +  ;
TRANSFORM(MSALDOAWAL + MSALDO1,'9999999999999') + "')"
 LCEK = SQLEXEC(OODBC,CSQL)
 IF LCEK < 1
  MESSAGEBOX(CSQL)
 ENDIF 
 ENDIF 
ENDPROC

*------
PROCEDURE pros_vld_inv
 PARAMETER MTGL1
 CSQL = "select * from gl_inventaris where nilaibuku>'0'"
 CSQL = SQLEXEC(OODBC,CSQL,'SMT')
 LOCAL MNOMOR , MTANGGAL , MHARGA , MLAMA , MTGLAWAL , MTGLAKHIR , MKE , MPERBULAN ,  ;
      MHARUS , MSEKARANG
 GO TOP
 DO WHILE  .NOT. EOF()
 MNOMOR = NOMOR
 MTANGGAL = TGLPEROLEHAN
 MHARGA = VAL(HARGA)
 MLAMA = LAMA
 MTGLAWAL = AWALBLN(MTANGGAL)
 MTGLAKHIR = AWALBLN(MTGL1)
 MKE =  ;
      ((YEAR(MTGLAKHIR) - YEAR(MTGLAWAL)) * 12) + (MONTH(MTGLAKHIR) - MONTH(MTGLAWAL)) +  ;
1
 MPERBULAN = PENYUSUTAN
 MHARUS = MKE * MPERBULAN
 MSEKARANG = VAL(NILAIBUKU) - (MHARGA - MHARUS)
 IF MSEKARANG <> 0
 CSQL =  ;
      'insert into log_valid (modul,keterangan) value ' + "('" + 'INVENTARIS' + "'," +  ;
"'" + 'KETERANGAN' + "')"
 LCEK = SQLEXEC(OODBC,CSQL)
 IF LCEK < 1
  MESSAGEBOX(CSQL)
 ENDIF 
 ENDIF 
 SELECT SMT
 SKIP 
 ENDDO 
 SELECT SMT
 USE 
ENDPROC
*------
PROCEDURE validasi
 PARAMETER MTGL
 CSQL =  ;
      "select * from anggota where MONTH(tanggallhr)='" + STR(MONTH(MTGL)) +  ;
" and DAY(tanggallhr)='" + STR(DAY(MTGL)) + "'"
 LCEK = SQLEXEC(OODBC,CSQL,'SMT')
 IF RECCOUNT() > 0
 ? '-----------------------------------------------------------'
 ? ' DAFTAR NASABAH ULANG TAHUN '
 ? '==========================================================='
 ENDIF 
 DO WHILE  .NOT. EOF()
 ? CIF , ' ' , NAMA , ' ' , ALAMAT , ' ' , DESA , ' ' , KECAMATAN , ' ' , PHONE
 SKIP 
 ENDDO 
 CSQL =  ;
      "select * from simpanan_blokir where (tglcabut='0000-00-00' or tglcabut>'" +  ;
SQLDATE(MTGL) + "') and " + "tglakhirblokir='" + SQLDATE(MTGL) + "'"
 LCEK = SQLEXEC(OODBC,CSQL,'SMT')
 DO WHILE  .NOT. EOF()
 ? '------------------------------------------------------'
 ? 'SURAT BLOKIR JATUH TEMPO'
 ? '======================================================'
 ? NOREK , ' ' , TANGGAL , ' ' , SALDOBLOKIR , ' ' , KETERANGAN
 SKIP 
 ENDDO 
 IF RECCOUNT() > 0
 ? '------------------------------------------------------'
 ENDIF 
 USE 
 CSQL =  ;
      "select dept,norek,tanggal,catatan,jumlah,vld,vld2,tglvalid from catatan where vld='2' and " +  ;
"((vld2=1 and tglvalid>=mtgl) or (vld2='2' and tglvalid=mtgl) or (vld2='3' and DAY(tglvalid)='" +  ;
STR(DAY(MTGL)) + "')) order by dept"
 LCEK = SQLEXEC(OODBC,CSQL,'SMT')
 IF LCEK < 1
  MESSAGEBOX('Gagal baca catatan')
 RETURN 
 ENDIF 
 IF RECCOUNT() > 0
 ? '-----------------------------------------------------------'
 ? ' CATATAN'
 ? '==========================================================='
 ENDIF 
 GO TOP
 DO WHILE  .NOT. EOF()
 SKIP 
 ENDDO 
ENDPROC
*------
PROCEDURE jumneraca
 PARAMETER XNOPER
 LOCAL MDUMMY , MTANGGAL , MDEBET , MKREDIT , MAWAL
 MDUMMY = 'DUMMY'
 CSQL = "select MAX(tanggal) as tgl from neraca where noper='" + XNOPER + "'"
 LCEK = SQLEXEC(OODBC,CSQL,MDUMMY)
 MTANGGAL = TGL
 USE 
 IF MTANGGAL = TGLNOW
 MAWAL = 0
 ELSE 
 CSQL =  ;
      "select saldo from neraca where noper='" + XNOPER + "' and tanggal='" +  ;
SQLDATE(MTANGGAL) + "'"
 LCEK = SQLEXEC(OODBC,CSQL,MDUMMY)
 MAWAL = VAL(SALDO)
 ENDIF 
 CSQL =  ;
      "select jumlah from jurnal where jumlah>0 and noper='" + XNOPER + "' and tanggal='" +  ;
SQLDATE(TGLNOW) + "'"
 LCEK = SQLEXEC(OODBC,CSQL,MDUMMY)
 MDEBET = VAL(JUMLAH)
 CSQL =  ;
      "select jumlah from jurnal where jumlah<=0 and noper='" + XNOPER +  ;
"' and tanggal='" + SQLDATE(TGLNOW) + "'"
 LCEK = SQLEXEC(OODBC,CSQL,MDUMMY)
 MKREDIT = VAL(JUMLAH)
 CSQL =  ;
      "select noper from neraca where noper='" + XNOPER + "' and tanggal='" +  ;
SQLDATE(TGLNOW) + "'"
 LCEK = SQLEXEC(OODBC,CSQL,MDUMMY)
 IF NOPER <> XNOPER
 CSQL =  ;
      "insert into neraca set kantor='" + DEFAKANTOR + "', tanggal='" + SQLDATE(TGLNOW) +  ;
"', " + "noper='" + XNOPER + "', saldoawal='" + STR(MAWAL) + "',debet='" +  ;
STR(MDEBET) + "',kredit='" + STR(MKREDIT) + "',saldo='" +  ;
STR(MAWAL + MDEBET - MKREDIT) + "'"
 LCEK = SQLEXEC(OODBC,CSQL)
 ELSE 
  MESSAGEBOX(MAWAL)
  MESSAGEBOX(MDEBET)
  MESSAGEBOX(MKREDIT)
  MESSAGEBOX(MAWAL + MDEBET - MKREDIT)
 CSQL =  ;
      "UPDATE neraca set saldoawal='" + STR(MAWAL) + ", debet='" + STR(MDEBET) +  ;
"', kredit='" + STR(MKREDIT) + "', saldo='" + STR(MAWAL + MDEBET - MKREDIT) +  ;
"' WHERE noper='" + XNOPER + "' and tanggal='" + SQLDATE(TGLNOW) + "'"
 LCEK = SQLEXEC(OODBC,CSQL)
 ? CSQL
  MESSAGEBOX(LCEK)
 ENDIF 
ENDPROC
*------
PROCEDURE cekdata
 RETURN 
ENDPROC
*------*
