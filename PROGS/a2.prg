* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
*  FileName A2.PRG <-- This file create by UnFoxAll
* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


 CSQL = 'DROP TRIGGER cif_update'
 LCEK = SQLEXEC(OODBC,CSQL)
 TEXT 
    CREATE TRIGGER `cif_update` AFTER UPDATE ON `anggota` FOR EACH ROW BEGIN
  	   if old.cif<>new.cif then 
  	      update anggota_mutasi set cif=new.cif where cif=old.cif;
  	      update pinjaman set cif=new.cif where cif=old.cif ;
  	      update simpanan set cif=new.cif where cif=old.cif;
  	      update catatan set norek=new.cif where dept='ANGG' and norek=old.cif;
  	   end if;
    
    END 
 ENDTEXT 
 LCEK = SQLEXEC(OODBC,STR1)
 IF LCEK < 1
  MESSAGEBOX('TRIGGER - cif_udate gagal dibuat')
 ENDIF 
 CSQL = 'DROP TRIGGER pinj_insert'
 LCEK = SQLEXEC(OODBC,CSQL)
 TEXT 
      CREATE TRIGGER `pinj_insert` AFTER INSERT ON `pinjaman` FOR EACH ROW BEGIN    
      SET @mppap=NEW.pokok*(0.5/100);
      INSERT INTO pinjaman_saldo (kantor,norek,tanggal,sisapokok,sisabunga,kol_awal,kol,ppap,adm,provisi,biaya) VALUES 
      (NEW.kantor,NEW.norek,NEW.tanggal,NEW.pokok,NEW.jasa,'1','1',@mppap,NEW.adm,NEW.provisi,NEW.biaya);
      END 
 ENDTEXT 
 LCEK = SQLEXEC(OODBC,STR1)
 IF LCEK < 1
  MESSAGEBOX('TRIGGER - pinj_insert gagal dibuat')
 ENDIF 
 CSQL = 'DROP TRIGGER pinj_update'
 LCEK = SQLEXEC(OODBC,CSQL)
 TEXT 
  create trigger `pinj_update` AFTER UPDATE ON `pinjaman` 
      FOR EACH ROW BEGIN    
      IF old.norek<>new.norek THEN 
         set @mNorek=old.norek;
         set @Newnorek=new.norek;
         UPDATE pinjaman_saldo SET norek=@Newnorek WHERE norek=@mnorek;
         update pinjaman_akrual SET norek=@Newnorek WHERE norek=@mnorek;
         update pinjaman_jadwal SET norek=@Newnorek WHERE norek=@mnorek;
         update pinjaman_jaminan SET norek=@Newnorek WHERE norek=@mnorek;
         update pinjaman_mutasi SET norek=@Newnorek WHERE norek=@mnorek;
         update catatan set norek=@Newnorek where dept='PINJ' and norek=@mNorek;
      end if;
  end; 
 ENDTEXT 
 LCEK = SQLEXEC(OODBC,STR1)
 IF LCEK < 1
  MESSAGEBOX('TRIGGER - pinj_insert gagal dibuat')
 ENDIF 
 CSQL = 'DROP TRIGGER simp_insert'
 LCEK = SQLEXEC(OODBC,CSQL)
 TEXT 
      CREATE TRIGGER `simp_insert` AFTER INSERT ON `simpanan` FOR EACH ROW BEGIN    
          INSERT INTO simpanan_saldo (kantor,norek, tanggal, saldo) VALUES 
         (NEW.kantor,NEW.norek,NEW.tanggal,'0');
      END 
 ENDTEXT 
 LCEK = SQLEXEC(OODBC,STR1)
 IF LCEK < 1
  MESSAGEBOX('TRIGGER - simp_insert gagal dibuat')
 ENDIF 
 CSQL = 'DROP TRIGGER `simp_update`'
 LCEK = SQLEXEC(OODBC,CSQL)
 TEXT 
  CREATE TRIGGER `simp_update` AFTER UPDATE on `simpanan` FOR EACH ROW BEGIN    
      IF old.norek<>new.norek THEN 
         set @mNorek=old.norek;
         set @Newnorek=new.norek;
         UPDATE simpanan_saldo SET norek=@Newnorek WHERE norek=@mnorek;
         update simpanan_akrual SET norek=@Newnorek WHERE norek=@mnorek;
         update simpanan_autodebet SET norek=@Newnorek WHERE norek=@mnorek;
         update simpanan_blokir SET norek=@Newnorek WHERE norek=@mnorek;
         update simpanan_bilyet SET norek=@Newnorek WHERE norek=@mnorek;
         update simpanan_bunga SET norek=@Newnorek WHERE norek=@mnorek;  
         update simpanan_mutasi SET norek=@Newnorek WHERE norek=@mnorek;
         update catatan SET norek=@Newnorek WHERE dept='SIMP' and norek=@mnorek;
      end if;
  END
 ENDTEXT 
 LCEK = SQLEXEC(OODBC,STR1)
 IF LCEK < 1
  MESSAGEBOX('TRIGGER - simp_update gagal dibuat')
 ENDIF 
 CSQL = 'DROP TRIGGER inv_ins'
 LCEK = SQLEXEC(OODBC,CSQL)
 TEXT 
     CREATE TRIGGER `inv_ins` AFTER INSERT ON `gl_inventaris_mutasi` FOR EACH ROW BEGIN
     set @mAkum=(select sum(kredit)-sum(debet) from gl_inventaris_mutasi where nomorid=NEW.nomorid);
     set @mnilai=(select harga from gl_inventaris where nomorid=new.nomorid);
     update gl_inventaris set akumulasi=@mAkum, nilaibuku=(@mNilai-@mAkum) where nomorid=new.nomorid;
     END
 ENDTEXT 
 LCEK = SQLEXEC(OODBC,STR1)
 IF LCEK < 1
  MESSAGEBOX('TRIGGER - inv_insert dibuat')
 ENDIF 
 CSQL = 'DROP FUNCTION IF EXISTS cekblokir'
 LCEK = SQLEXEC(OODBC,CSQL)
 TEXT 
     CREATE FUNCTION `cekblokir` (mnorek varchar(17), mtgl date)	RETURNS varchar(1) BEGIN
     SET @ada=(select count(norek) from simpanan_blokir where norek=mnorek and tglcabut='0000-00-00' or tglcabut>mtgl);
     if @ada>0 then 
        return 'Y' ;
     else 
        return 'T';
     end if;     
     END
 ENDTEXT 
 LCEK = SQLEXEC(OODBC,STR1)
 IF LCEK < 1
  MESSAGEBOX('FUNCTION CEK BLOKIR')
 ENDIF 
 CSQL = 'DROP FUNCTION IF EXISTS cekautodebet'
 LCEK = SQLEXEC(OODBC,CSQL)
 TEXT 
     CREATE FUNCTION `cekautodebet`(mnorek varchar(17), mtgl date)	RETURNS varchar(1) BEGIN
     SET @ada=(select count(norek) from simpanan_autodebet where norek=mnorek and tglcabut='0000-00-00' or tglcabut>mtgl);
     if @ada>0 then 
        return 'Y' ;
     else 
        return 'T';
     end if;     
     END
 ENDTEXT 
 LCEK = SQLEXEC(OODBC,STR1)
 IF LCEK < 1
  MESSAGEBOX('FUNCTION CEK AUTODEBET')
 ENDIF 
 CSQL = 'DROP FUNCTION IF EXISTS saldotab'
 LCEK = SQLEXEC(OODBC,CSQL)
 TEXT 
       CREATE FUNCTION saldotab(mnorek varchar(25), mtgl date)	RETURNS double(15,0)    BEGIN
         set @iddata=(select max(iddata) from simpanan_mutasi where norek=mnorek and tanggal<=mtgl);       
         set @sld=(select saldo from simpanan_mutasi where norek=mnorek and iddata=@iddata);
         return @sld;    
         END
 ENDTEXT 
 LCEK = SQLEXEC(OODBC,STR1)
 IF LCEK < 1
  MESSAGEBOX('GAGAL MEMBUAT PROCEDURE SALDOTAB')
 ENDIF 
 CSQL = 'DROP TRIGGER perkiraan_au'
 LCEK = SQLEXEC(OODBC,CSQL)
 TEXT 
  	create trigger `perkiraan_au` AFTER UPDATE on `perkiraan` 
  	for each row BEGIN
  	   if old.noper<>new.noper then 
  	      update neraca set noper=new.noper where noper=old.noper;
  	      update neraca_konsol set noper=new.noper where noper=old.noper;
  	      update jurnal set noper=new.noper where noper=old.noper;
  	      update setsandi set keterangan=new.noper where keterangan=old.noper and left(ket2,5)='NOPER';
  	      update setsandi_pinj set jurnal_pokok=new.noper where jurnal_pokok=old.noper;
  	      update setsandi_pinj set jurnal_jasa=new.noper where jurnal_jasa=old.noper;
  	      update setsandi_pinj set jurnal_denda=new.noper where jurnal_denda=old.noper;
  	      update setsandi_pinj set jurnal_adm=new.noper where jurnal_adm=old.noper;
  	      update setsandi_pinj set jurnal_prov=new.noper where jurnal_prov=old.noper;
  	      update setsandi_pinj set jurnal_yadit=new.noper where jurnal_yadit=old.noper;
  	      update setsandi_pinj set jurnal_ppap=new.noper where jurnal_ppap=old.noper;
  	      update setsandi_tab set jurnaltab=new.noper where jurnaltab=old.noper;
  	      update setsandi_tab set jurnalutangbg=new.noper where jurnalutangbg=old.noper;
  	      update setsandi_tab set jurnalbunga=new.noper where jurnalbunga=old.noper;
  	      update setsandi_tab set jurnaladm=new.noper where jurnaladm=old.noper;
  	      update setsandi_tab set jurnaladmtutup=new.noper where jurnaladmtutup=old.noper;
  	      update setsandi_tab set jurnalpajak=new.noper where jurnalpajak=old.noper;
  	      update setsandi_tab set jurnalksd=new.noper where jurnalksd=old.noper;
  	   end if;
  	  
  	END;
 ENDTEXT 
 LCEK = SQLEXEC(OODBC,STR1)
 IF LCEK < 1
  MESSAGEBOX('TRIGGER UFTER UPDATE PERKIRAAN')
 ENDIF 
 CSQL = 'DROP TRIGGER neraca_au'
 LCEK = SQLEXEC(OODBC,CSQL)
 TEXT 
       CREATE TRIGGER `neraca_au` AFTER UPDATE on `neraca`FOR EACH ROW BEGIN        
       set @msaldoawal=(select sum(saldoawal) from neraca where noper=new.noper and tanggal=new.tanggal);
       set @mdebet=(select sum(debet) from neraca where noper=new.noper and tanggal=new.tanggal);
       set @mkredit=(select sum(kredit) from neraca where noper=new.noper and tanggal=new.tanggal);
       set @msaldo=(select sum(saldo) from neraca where noper=new.noper and tanggal=new.tanggal);
       update neraca_konsol set saldoawal=@msaldoawal,debet=@mdebet,kredit=@mkredit,saldo=@msaldo where noper=new.noper and tanggal=new.tanggal;
      END;
 ENDTEXT 
 LCEK = SQLEXEC(OODBC,STR1)
 IF LCEK < 1
  MESSAGEBOX('TRIGGER NERACA AFTER UPDATE')
 ENDIF 
 CSQL = 'DROP TRIGGER neraca_ai'
 LCEK = SQLEXEC(OODBC,CSQL)
 TEXT 
      CREATE TRIGGER `neraca_ai` AFTER INSERT on `neraca` FOR EACH ROW BEGIN    
      set @mnoper=(select noper from neraca_konsol where noper=new.noper and tanggal=new.tanggal);
      if @mnoper<>'' then
          set @msaldoawal=(select sum(saldoawal) from neraca where noper=new.noper and tanggal=new.tanggal);
          set @mdebet=(select sum(debet) from neraca where noper=new.noper and tanggal=new.tanggal);
          set @mkredit=(select sum(kredit) from neraca where noper=new.noper and tanggal=new.tanggal);
          set @msaldo=(select sum(saldo) from neraca where noper=new.noper and tanggal=new.tanggal);
          insert into neraca_konsol (noper,tanggal,saldoawal,debet,kredit,saldo) value (new.noper,new.tanggal,@msaldoawal,@mdebet,@mkredit,@msaldo);
      end if;
      END
 ENDTEXT 
 LCEK = SQLEXEC(OODBC,STR1)
 IF LCEK < 1
  MESSAGEBOX('TRIGGER NERACA AFTER INSERT')
 ENDIF 
 CSQL = 'DROP FUNCTION hitneraca'
 LCEK = SQLEXEC(OODBC,CSQL)
 TEXT 
      CREATE FUNCTION hitneraca(mkantor varchar(4), mnoper varchar(10), mtgl date) RETURNS double(15,0)
      BEGIN
          SET @tgl=(select max(tanggal) from neraca where kantor=mkantor and noper=mnoper and tanggal<=mtgl group by noper );
          set @sld=(select sum(saldo) from neraca where kantor=mkantor and noper=mnoper and tanggal=@tgl );     
          return @sld;
      END
 ENDTEXT 
 LCEK = SQLEXEC(OODBC,STR1)
 IF LCEK < 1
  MESSAGEBOX('FUNCTION HITNERACA')
 ENDIF 
*
