* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
*  FileName PROS_MENU.PRG <-- This file create by UnFoxAll
* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-



PROCEDURE main_menu
 DEFINE MENU XMFORM BAR IN XMFORM
 DEFINE PAD _1 OF XMFORM PROMPT '\<System' KEY ALT+S
 DEFINE PAD _2 OF XMFORM PROMPT 'Se\<tting' SKIP FOR  .NOT. IJINMENU('MASTER') KEY ALT+M
 DEFINE PAD _3 OF XMFORM PROMPT '\<Transaksi' SKIP FOR  .NOT. IJINMENU('TRANSAKSI') KEY  ;
      ALT+T
 DEFINE PAD _4 OF XMFORM PROMPT '\<Laporan' SKIP FOR  .NOT. IJINMENU('LAPORAN') KEY  ;
      ALT+L
 DEFINE PAD _5 OF XMFORM PROMPT '\<Proses' SKIP FOR  .NOT. IJINMENU('PROSES') KEY ALT+P
 DEFINE PAD _6 OF XMFORM PROMPT '\<Utility' SKIP FOR  .NOT. IJINMENU('UTILITY') KEY  ;
      ALT+U
 DEFINE PAD _7 OF XMFORM PROMPT '\<About' KEY ALT+A
 ON PAD _1 OF XMFORM ACTIVATE POPUP XLOGIN
 ON PAD _2 OF XMFORM ACTIVATE POPUP XMASTER
 ON PAD _3 OF XMFORM ACTIVATE POPUP XTRANSAKSI
 ON PAD _4 OF XMFORM ACTIVATE POPUP XREPORT
 ON PAD _5 OF XMFORM ACTIVATE POPUP XPROSES
 ON PAD _6 OF XMFORM ACTIVATE POPUP XUTIL
 ON PAD _7 OF XMFORM ACTIVATE POPUP XABOUT
 DEFINE POPUP XLOGIN MARGIN 
 DEFINE BAR 1 OF XLOGIN PROMPT '\<Profil Client' SKIP FOR  .NOT. IJINMENU('SET') COLOR  ;
      SCHEME 3
 DEFINE BAR 2 OF XLOGIN PROMPT '\<Profil Lembaga' SKIP FOR DEFAIDGROUP <> 'ADMIN' COLOR  ;
      SCHEME 3
 DEFINE BAR 3 OF XLOGIN PROMPT '\----'
 DEFINE BAR 4 OF XLOGIN PROMPT 'Set \<User Login & Password' PICTURE ".\image\user.png"  COLOR SCHEME 3   SKIP FOR !ijinmenu("SET") 
      
 IF DEFAMASUK
 DEFINE BAR 5 OF XLOGIN PROMPT '\<Logout' STYLE 'BI' PICTURE  '.\image\key.ico' COLOR SCHEME 3
 ELSE 
 DEFINE BAR 5 OF XLOGIN PROMPT '\<Login' STYLE 'BI' PICTURE  '.\image\key.ico' COLOR SCHEME 3
 ENDIF 
 DEFINE BAR 6 OF XLOGIN PROMPT 'E\<xit' KEY CTRL+X , 'Ctrl+X'
 ON SELECTION BAR 1 OF XLOGIN do form setting
 ON SELECTION BAR 2 OF XLOGIN do form setting2
 ON SELECTION BAR 4 OF XLOGIN DO FORM atur_user
 ON SELECTION BAR 5 OF XLOGIN do form frm_login
 ON SELECTION BAR 6 OF XLOGIN oxmenu.release 			
 DEFINE POPUP XMASTER COLOR SCHEME 4 SHADOW MARGIN RELATIVE 
 DEFINE BAR 1 OF XMASTER PROMPT '---- Pinjaman-----' STYLE 'BI' SKIP COLOR SCHEME 3
 DEFINE BAR 2 OF XMASTER PROMPT 'Produk Pinjaman'
 ON SELECTION BAR 2 OF XMASTER DO FORM setsandi WITH "P001","TAMPIL" 
 DEFINE BAR 3 OF XMASTER PROMPT 'Cara Perhitungan Jasa Pinjaman' COLOR SCHEME 3
 ON SELECTION BAR 3 OF XMASTER DO FORM setsandi WITH "P002","TAMPIL" 
 DEFINE BAR 4 OF XMASTER PROMPT 'Jenis Penggunaan' COLOR SCHEME 3
 ON SELECTION BAR 4 OF XMASTER DO FORM setsandi WITH "P005","TAMPIL" 
 DEFINE BAR 5 OF XMASTER PROMPT 'Sektor Ekonomi' COLOR SCHEME 3
 ON SELECTION BAR 5 OF XMASTER DO FORM setsandi WITH "P006","TAMPIL" 
 DEFINE BAR 6 OF XMASTER PROMPT 'Sumber Pelunasan' COLOR SCHEME 3
 ON SELECTION BAR 6 OF XMASTER DO FORM setsandi WITH "P007","TAMPIL" 
 DEFINE BAR 7 OF XMASTER PROMPT '\-'
 DEFINE BAR 8 OF XMASTER PROMPT '---- Simpanan-----' STYLE 'BI' SKIP COLOR SCHEME 3
 DEFINE BAR 9 OF XMASTER PROMPT 'Produk Simpanan' COLOR SCHEME 3
 ON SELECTION BAR 9 OF XMASTER DO FORM setsandi WITH "S001","TAMPIL"  
 DEFINE BAR 10 OF XMASTER PROMPT 'Cara Perhitungan ' COLOR SCHEME 3
 ON SELECTION BAR 10 OF XMASTER DO FORM setsandi WITH "S002","TAMPIL"  
 DEFINE BAR 11 OF XMASTER PROMPT 'Kelompok Simpanan' COLOR SCHEME 3
 ON SELECTION BAR 11 OF XMASTER DO FORM setsandi WITH "S003","TAMPIL"
 DEFINE BAR 12 OF XMASTER PROMPT '\-'
 DEFINE BAR 13 OF XMASTER PROMPT '---- Akuntansi-----' STYLE 'BI' SKIP COLOR SCHEME 3
 DEFINE BAR 14 OF XMASTER PROMPT 'Kode Perkiraan' COLOR SCHEME 3
 ON SELECTION BAR 14 OF XMASTER DO FORM setsandi WITH "GL01","TAMPIL"
 DEFINE BAR 15 OF XMASTER PROMPT '\-'
 DEFINE BAR 16 OF XMASTER PROMPT 'Pengikatan Barang Bergerak' COLOR SCHEME 3
 ON SELECTION BAR 16 OF XMASTER DO FORM setsandi WITH "P009","TAMPIL"
 DEFINE BAR 17 OF XMASTER PROMPT 'Pengikatan Tanah dan Bangunan' COLOR SCHEME 3
 ON SELECTION BAR 17 OF XMASTER DO FORM setsandi WITH "P010","TAMPIL"
 DEFINE BAR 18 OF XMASTER PROMPT 'Pengikatan Jaminan Simpanan' COLOR SCHEME 3
 ON SELECTION BAR 18 OF XMASTER DO FORM setsandi WITH "P011","TAMPIL"        
 DEFINE BAR 19 OF XMASTER PROMPT 'Pengikatan Jaminan Lain-Lain' COLOR SCHEME 3
 ON SELECTION BAR 19 OF XMASTER DO FORM setsandi WITH "P012","TAMPIL" 
 DEFINE BAR 20 OF XMASTER PROMPT '\-'
 DEFINE BAR 21 OF XMASTER PROMPT 'Daftar Kolektor' COLOR SCHEME 3
 ON SELECTION BAR 21 OF XMASTER DO FORM setsandi WITH "C002","TAMPIL" 
 DEFINE BAR 22 OF XMASTER PROMPT 'Daftar Instansi' COLOR SCHEME 3
 ON SELECTION BAR 22 OF XMASTER DO FORM setsandi WITH "P003","TAMPIL" 
 DEFINE BAR 23 OF XMASTER PROMPT 'Wilayah Pinjaman' COLOR SCHEME 3
 ON SELECTION BAR 23 OF XMASTER DO FORM setsandi WITH "P004","TAMPIL"        
 DEFINE BAR 24 OF XMASTER PROMPT 'Daftar Notaris' COLOR SCHEME 3
 ON SELECTION BAR 24 OF XMASTER DO FORM setsandi WITH "P013","TAMPIL" 
 DEFINE BAR 25 OF XMASTER PROMPT 'Daftar Asuransi' COLOR SCHEME 3
 ON SELECTION BAR 25 OF XMASTER DO FORM setsandi WITH "P014","TAMPIL" 
 DEFINE BAR 26 OF XMASTER PROMPT 'Kode Marketing' COLOR SCHEME 3
 ON SELECTION BAR 26 OF XMASTER DO FORM setsandi WITH "A001","TAMPIL"
 DEFINE BAR 27 OF XMASTER PROMPT 'Kode Kota' COLOR SCHEME 3
 ON SELECTION BAR 27 OF XMASTER DO FORM setsandi WITH "A002","TAMPIL"
 ON BAR 9 OF XMASTER ACTIVATE POPUP XPRODUK
 DEFINE POPUP XPRODUK COLOR SCHEME 4 SHADOW MARGIN RELATIVE 
 DEFINE BAR 1 OF XPRODUK PROMPT 'Produk Simpanan / Tabungan'
 DEFINE BAR 2 OF XPRODUK PROMPT 'Produk Simpanan Berjangka'
 DEFINE BAR 3 OF XPRODUK PROMPT 'Modal Penyertaan'
 ON SELECTION BAR 1 OF XPRODUK DO FORM setsandi WITH "S01A","TAMPIL"
 ON SELECTION BAR 2 OF XPRODUK DO FORM setsandi WITH "S01B","TAMPIL"
 ON SELECTION BAR 3 OF XPRODUK DO FORM setsandi WITH "S01C","TAMPIL"
 DEFINE POPUP XTRANSAKSI MARGIN 
 DEFINE BAR 1 OF XTRANSAKSI PROMPT 'Kasir' STYLE 'BI' SKIP COLOR SCHEME 3 PICTURE   '.\image\Bank Teller 2.png'
 DEFINE BAR 2 OF XTRANSAKSI PROMPT 'Transaksi Kas dan Non Kas' SKIP FOR  ;
       .NOT. IJINMODUL('KAS','VIEW') COLOR SCHEME 3
 ON SELECTION BAR 2 OF XTRANSAKSI DO FORM kasir
 DEFINE BAR 3 OF XTRANSAKSI PROMPT '\----'
 DEFINE BAR 4 OF XTRANSAKSI PROMPT 'Bagian Pinjaman / Pembiayaan' STYLE 'BI' SKIP COLOR  ;
      SCHEME 3 PICTURE  '.\image\loan.png'
 DEFINE BAR 5 OF XTRANSAKSI PROMPT 'Daftar Pinjaman / Pembiayaan' SKIP FOR  ;
       .NOT. IJINMODUL('PINJ','VIEW') COLOR SCHEME 3
 ON SELECTION BAR 5 OF XTRANSAKSI DO FORM pinjaman WITH "TAMPIL","A" 
 DEFINE BAR 6 OF XTRANSAKSI PROMPT 'Penerimaan Angsuran' SKIP FOR  ;
       .NOT. IJINMODUL('PINJ','VIEW') COLOR SCHEME 3
 ON SELECTION BAR 6 OF XTRANSAKSI DO FORM pinjaman WITH "TAMPIL","B"
 DEFINE BAR 7 OF XTRANSAKSI PROMPT 'Data History Pinjaman' SKIP FOR  ;
       .NOT. IJINMODUL('PINJ','VIEW') COLOR SCHEME 3
 ON SELECTION BAR 7 OF XTRANSAKSI DO FORM pinjaman WITH "TAMPIL","P"  
 DEFINE BAR 8 OF XTRANSAKSI PROMPT '\----'
 DEFINE BAR 9 OF XTRANSAKSI PROMPT 'Bagian Simpanan / Funding' STYLE 'BI' SKIP COLOR  ;
      SCHEME 3 PICTURE  '.\image\bank 4 add.png'
 DEFINE BAR 10 OF XTRANSAKSI PROMPT 'Daftar Simpanan ' SKIP FOR  ;
       .NOT. IJINMODUL('SIMP','VIEW') COLOR SCHEME 3
 ON SELECTION BAR 10 OF XTRANSAKSI DO FORM simpanan WITH "TAMPIL","A" 
 DEFINE BAR 11 OF XTRANSAKSI PROMPT 'Simpanan Di Blokir ' SKIP FOR  ;
       .NOT. IJINMODUL('SIMP','VIEW') COLOR SCHEME 3
 ON SELECTION BAR 11 OF XTRANSAKSI DO FORM simpanan WITH "TAMPIL","B" 
 DEFINE BAR 12 OF XTRANSAKSI PROMPT 'Auto debet Simpanan ' SKIP FOR  ;
       .NOT. IJINMODUL('SIMP','VIEW') COLOR SCHEME 3
 ON SELECTION BAR 12 OF XTRANSAKSI DO FORM simpanan WITH "TAMPIL","D" 
 DEFINE BAR 13 OF XTRANSAKSI PROMPT 'Data History Simpanan' SKIP FOR  ;
       .NOT. IJINMODUL('SIMP','VIEW') COLOR SCHEME 3
 ON SELECTION BAR 13 OF XTRANSAKSI DO FORM simpanan WITH "TAMPIL","P"
 DEFINE BAR 14 OF XTRANSAKSI PROMPT '\----'
 DEFINE BAR 15 OF XTRANSAKSI PROMPT 'Keanggotaan' STYLE 'BI' SKIP COLOR SCHEME 3
 DEFINE BAR 16 OF XTRANSAKSI PROMPT 'Daftar Anggota Koperasi' SKIP FOR  ;
       .NOT. IJINMODUL('ANGG','VIEW') COLOR SCHEME 3
 ON SELECTION BAR 16 OF XTRANSAKSI DO FORM Anggota WITH "TAMPIL","A" 
 DEFINE BAR 17 OF XTRANSAKSI PROMPT 'History Anggota Koperasi' SKIP FOR  ;
       .NOT. IJINMODUL('ANGG','VIEW') COLOR SCHEME 3
 ON SELECTION BAR 17 OF XTRANSAKSI DO FORM Anggota WITH "TAMPIL","P"
 DEFINE BAR 18 OF XTRANSAKSI PROMPT '\----'
 DEFINE BAR 19 OF XTRANSAKSI PROMPT 'Bagian Akuntansi' STYLE 'BI' SKIP COLOR SCHEME 3  ;
      PICTURE  '.\image\Scale.png'
 DEFINE BAR 20 OF XTRANSAKSI PROMPT 'Jurnal Transaksi' SKIP FOR  ;
       .NOT. IJINMODUL('AKT','VIEW') COLOR SCHEME 3
 ON SELECTION BAR 20 OF XTRANSAKSI DO FORM gl_jurnal
 DEFINE BAR 21 OF XTRANSAKSI PROMPT 'Daftar Perkiraan Akuntansi' SKIP FOR  ;
       .NOT. IJINMODUL('AKT','VIEW') COLOR SCHEME 3
 ON SELECTION BAR 21 OF XTRANSAKSI DO FORM gl_perkiraan
 DEFINE BAR 22 OF XTRANSAKSI PROMPT 'Daftar Inventaris' SKIP FOR  ;
       .NOT. IJINMODUL('AKT','VIEW') COLOR SCHEME 3
 ON SELECTION BAR 22 OF XTRANSAKSI DO FORM gl_inventaris
 DEFINE BAR 23 OF XTRANSAKSI PROMPT '\----'
 DEFINE BAR 24 OF XTRANSAKSI PROMPT 'Kolektif' STYLE 'BI' SKIP COLOR SCHEME 3
 DEFINE BAR 25 OF XTRANSAKSI PROMPT 'Pembayaran Kolektif Instansi' SKIP FOR  ;
       .NOT. IJINMODUL('COL','VIEW') COLOR SCHEME 3
 ON SELECTION BAR 25 OF XTRANSAKSI DO FORM instansi_masuk
 DEFINE BAR 26 OF XTRANSAKSI PROMPT 'Pembayaran Petugas Kolektor' SKIP FOR  ;
       .NOT. IJINMODUL('COL','VIEW') COLOR SCHEME 3
 ON SELECTION BAR 26 OF XTRANSAKSI DO FORM Col1_masuk
 DEFINE POPUP XREPORT COLOR SCHEME 4 MARGIN RELATIVE SCROLL 
 DEFINE BAR 1 OF XREPORT PROMPT 'Laporan Keanggotaan' COLOR SCHEME 3
 DEFINE BAR 2 OF XREPORT PROMPT 'Laporan Simpanan' COLOR SCHEME 3 PICTURE  '.\image\bank 4 add.png'
 DEFINE BAR 3 OF XREPORT PROMPT 'Laporan Pinjaman' COLOR SCHEME 3 PICTURE '.\image\loan.png'
 DEFINE BAR 4 OF XREPORT PROMPT 'Laporan Kasir' COLOR SCHEME 3 PICTURE   '.\image\Bank Teller 2.png'
 DEFINE BAR 5 OF XREPORT PROMPT 'Laporan Akuntansi' COLOR SCHEME 3 PICTURE   '.\image\Scale.png'
 DEFINE BAR 6 OF XREPORT PROMPT 'Laporan Kolektor' COLOR SCHEME 3
 ON BAR 1 OF XREPORT ACTIVATE POPUP XLAPANGGOTA
 DEFINE POPUP XLAPANGGOTA COLOR SCHEME 4 SHADOW MARGIN RELATIVE 
 DEFINE BAR 1 OF XLAPANGGOTA PROMPT '1. Laporan Daftar Anggota'
 DEFINE BAR 2 OF XLAPANGGOTA PROMPT '2. Laporan Mutasi Simpanan Pokok'
 DEFINE BAR 3 OF XLAPANGGOTA PROMPT '3. Laporan Mutasi Simpanan Wajib'
 DEFINE BAR 4 OF XLAPANGGOTA PROMPT '4. Laporan Rincian SHU'
 DEFINE BAR 5 OF XLAPANGGOTA PROMPT '5. Laporan Anggota Keluar'
 DEFINE BAR 6 OF XLAPANGGOTA PROMPT '6. Tanda Terima SHU'
 ON SELECTION BAR 1 OF XLAPANGGOTA do form angg_lap with 1
 ON SELECTION BAR 2 OF XLAPANGGOTA do form angg_lap with 3
 ON SELECTION BAR 3 OF XLAPANGGOTA do form angg_lap with 4
 ON SELECTION BAR 4 OF XLAPANGGOTA do form angg_lap with 2
 ON SELECTION BAR 5 OF XLAPANGGOTA do form angg_lap with 5
 ON SELECTION BAR 6 OF XLAPANGGOTA do form angg_lap with 6
 ON BAR 2 OF XREPORT ACTIVATE POPUP XLAPSIMPANAN
 DEFINE POPUP XLAPSIMPANAN COLOR SCHEME 4 SHADOW MARGIN RELATIVE 
 DEFINE BAR 1 OF XLAPSIMPANAN PROMPT '1. Laporan Pembukaan rekening Baru'
 DEFINE BAR 2 OF XLAPSIMPANAN PROMPT '2. Laporan Mutasi Simpanan'
 DEFINE BAR 3 OF XLAPSIMPANAN PROMPT '3. Laporan Nominatif Simpanan'
 DEFINE BAR 4 OF XLAPSIMPANAN PROMPT '4. Laporan Penutupan Rekening'
 DEFINE BAR 5 OF XLAPSIMPANAN PROMPT '5. Laporan Nominatif Rinci'
 DEFINE BAR 6 OF XLAPSIMPANAN PROMPT '6. Laporan Simpanan Instansi'
 DEFINE BAR 7 OF XLAPSIMPANAN PROMPT '7. Laporan Mutasi Saldo'
 DEFINE BAR 8 OF XLAPSIMPANAN PROMPT '8. Pengambilan Simpanan'
 ON SELECTION BAR 1 OF XLAPSIMPANAN do form simp_lap with 1
 ON SELECTION BAR 2 OF XLAPSIMPANAN do form simp_lap with 2
 ON SELECTION BAR 3 OF XLAPSIMPANAN do form simp_lap with 3
 ON SELECTION BAR 4 OF XLAPSIMPANAN do form simp_lap with 4
 ON SELECTION BAR 5 OF XLAPSIMPANAN do form simp_lap with 5
 ON BAR 6 OF XLAPSIMPANAN ACTIVATE POPUP XLAPSIMP_INST
 DEFINE POPUP XLAPSIMP_INST COLOR SCHEME 4 SHADOW MARGIN RELATIVE 
 DEFINE BAR 1 OF XLAPSIMP_INST PROMPT '1. Daftar Mutasi Pengambilan Simpanan'
 DEFINE BAR 2 OF XLAPSIMP_INST PROMPT '2. Laporan .....'
 ON SELECTION BAR 1 OF XLAPSIMP_INST do form angg_lap with 1
 ON SELECTION BAR 2 OF XLAPSIMP_INST do form angg_lap with 2
 ON SELECTION BAR 7 OF XLAPSIMPANAN do form simp_lap with 6  
 ON SELECTION BAR 8 OF XLAPSIMPANAN do form simp_lap with 7  
 ON BAR 3 OF XREPORT ACTIVATE POPUP XLAPPINJAMAN
 DEFINE POPUP XLAPPINJAMAN COLOR SCHEME 4 SHADOW MARGIN RELATIVE 
 DEFINE BAR 1 OF XLAPPINJAMAN PROMPT '1. Laporan Realisasi Pinjaman'
 DEFINE BAR 2 OF XLAPPINJAMAN PROMPT '2. Laporan Penerimaan Angsuran'
 DEFINE BAR 3 OF XLAPPINJAMAN PROMPT '3. Laporan Nominatif Pinjaman'
 DEFINE BAR 4 OF XLAPPINJAMAN PROMPT '4. Laporan Pelunasan Pinjaman'
 DEFINE BAR 5 OF XLAPPINJAMAN PROMPT '5. Laporan Non Performing Loan (NPL)'
 DEFINE BAR 6 OF XLAPPINJAMAN PROMPT '6. Laporan Nasabah Belum Bayar'
 DEFINE BAR 7 OF XLAPPINJAMAN PROMPT '7. Laporan Mutasi Rekening Koran'
 DEFINE BAR 8 OF XLAPPINJAMAN PROMPT '8. Laporan Pinjaman Belum Cair'
 ON SELECTION BAR 1 OF XLAPPINJAMAN do form pinj_lap with 1
 ON SELECTION BAR 2 OF XLAPPINJAMAN do form pinj_lap with 2
 ON SELECTION BAR 3 OF XLAPPINJAMAN do form pinj_lap with 3
 ON SELECTION BAR 4 OF XLAPPINJAMAN do form pinj_lap with 4
 ON BAR 5 OF XLAPPINJAMAN ACTIVATE POPUP XLAPPINJ_NPL
 DEFINE POPUP XLAPPINJ_NPL COLOR SCHEME 4 SHADOW MARGIN RELATIVE 
 DEFINE BAR 1 OF XLAPPINJ_NPL PROMPT '1. Rekapitulasi NPL'
 DEFINE BAR 2 OF XLAPPINJ_NPL PROMPT '2. Rekap NPL Per Instansi'
 DEFINE BAR 3 OF XLAPPINJ_NPL PROMPT '3. Rekap NPL Per Marketing'
 DEFINE BAR 4 OF XLAPPINJ_NPL PROMPT '4. Rekap NPL Per Wilayah'
 DEFINE BAR 5 OF XLAPPINJ_NPL PROMPT '5. Rekap NPL Per Produk'
 DEFINE BAR 6 OF XLAPPINJ_NPL PROMPT '6. Rekap NPL Per Sektor Ekonomi'
 ON SELECTION BAR 1 OF XLAPPINJ_NPL do form pinj_lap with 5
 ON SELECTION BAR 2 OF XLAPPINJ_NPL do form pinj_lap with 6
 ON SELECTION BAR 3 OF XLAPPINJ_NPL do form pinj_lap with 9
 ON SELECTION BAR 4 OF XLAPPINJ_NPL do form pinj_lap with 10
 ON SELECTION BAR 5 OF XLAPPINJ_NPL do form pinj_lap with 11
 ON SELECTION BAR 6 OF XLAPPINJ_NPL do form pinj_lap with 12
 ON SELECTION BAR 7 OF XLAPPINJAMAN do form pinj_lap with 8
 ON SELECTION BAR 8 OF XLAPPINJAMAN do form pinj_lap with 9
 ON BAR 4 OF XREPORT ACTIVATE POPUP XLAPKASIR
 DEFINE POPUP XLAPKASIR COLOR SCHEME 4 SHADOW MARGIN RELATIVE 
 DEFINE BAR 1 OF XLAPKASIR PROMPT '1. Laporan Penerimaan Kas'
 DEFINE BAR 2 OF XLAPKASIR PROMPT '2. Laporan Mutasi Non Kas'
 DEFINE BAR 3 OF XLAPKASIR PROMPT '3. Laporan Rincian Uang Kas'
 ON SELECTION BAR 1 OF XLAPKASIR do form kas_lap with 1
 ON SELECTION BAR 2 OF XLAPKASIR do form kas_lap with 2
 ON SELECTION BAR 3 OF XLAPKASIR do form kas_lap with 3
 ON BAR 5 OF XREPORT ACTIVATE POPUP XLAPAKUNTANSI
 DEFINE POPUP XLAPAKUNTANSI COLOR SCHEME 4 SHADOW MARGIN RELATIVE 
 DEFINE BAR 1 OF XLAPAKUNTANSI PROMPT '1. Laporan Neraca'
 DEFINE BAR 2 OF XLAPAKUNTANSI PROMPT '2. Laporan Laba Rugi'
 DEFINE BAR 3 OF XLAPAKUNTANSI PROMPT '3. Laporan Neraca Perbandingan'
 DEFINE BAR 4 OF XLAPAKUNTANSI PROMPT '4. Laporan Laba Rugi Perbandingan'
 DEFINE BAR 5 OF XLAPAKUNTANSI PROMPT '5. Laporan Neraca Harian'
 DEFINE BAR 6 OF XLAPAKUNTANSI PROMPT '6. Laporan Laba Rugi Harian'
 DEFINE BAR 7 OF XLAPAKUNTANSI PROMPT '7. Laporan Rincian Transaksi'
 DEFINE BAR 8 OF XLAPAKUNTANSI PROMPT '8. Laporan Rekap Buku Besar'
 DEFINE BAR 9 OF XLAPAKUNTANSI PROMPT '9. Daftar Inventaris'
 DEFINE BAR 10 OF XLAPAKUNTANSI PROMPT '10. Rincian Aktiva'
 DEFINE BAR 11 OF XLAPAKUNTANSI PROMPT '11. Rincian Pasiva'
 DEFINE BAR 12 OF XLAPAKUNTANSI PROMPT '12.Rincian Pendapatan'
 DEFINE BAR 13 OF XLAPAKUNTANSI PROMPT '13.Rincian Biaya'
 DEFINE BAR 14 OF XLAPAKUNTANSI PROMPT '14.Cetak Jurnal Transaksi'
 DEFINE BAR 15 OF XLAPAKUNTANSI PROMPT '15.Cetak Neraca dan Laba/rugi'
 DEFINE BAR 16 OF XLAPAKUNTANSI PROMPT '16.Laporan Rekap Transaksi'
 ON SELECTION BAR 1 OF XLAPAKUNTANSI do form gl_lap1 with 1  
 ON SELECTION BAR 2 OF XLAPAKUNTANSI do form gl_lap1 with 2  
 ON SELECTION BAR 3 OF XLAPAKUNTANSI do form gl_lap1 with 3  
 ON SELECTION BAR 4 OF XLAPAKUNTANSI do form gl_lap1 with 4  
 ON SELECTION BAR 5 OF XLAPAKUNTANSI do form gl_lap1 with 9  
 ON SELECTION BAR 6 OF XLAPAKUNTANSI do form gl_lap1 with 10  
 ON SELECTION BAR 7 OF XLAPAKUNTANSI do form gl_lap2 with 1  
 ON SELECTION BAR 8 OF XLAPAKUNTANSI do form gl_lap2 with 2  
 ON SELECTION BAR 9 OF XLAPAKUNTANSI do form gl_lap2 with 4  
 ON SELECTION BAR 10 OF XLAPAKUNTANSI do form gl_lap1 with 5  
 ON SELECTION BAR 11 OF XLAPAKUNTANSI do form gl_lap1 with 6  
 ON SELECTION BAR 12 OF XLAPAKUNTANSI do form gl_lap1 with 7  
 ON SELECTION BAR 13 OF XLAPAKUNTANSI do form gl_lap1 with 8  
 ON SELECTION BAR 14 OF XLAPAKUNTANSI do form gl_lap2 with 3  
 ON SELECTION BAR 15 OF XLAPAKUNTANSI do form gl_lap2 with 8  
 ON SELECTION BAR 16 OF XLAPAKUNTANSI DO FORM gl_lap2 with 10	
 ON BAR 6 OF XREPORT ACTIVATE POPUP XLAPKOLEKTOR
 DEFINE POPUP XLAPKOLEKTOR COLOR SCHEME 4 SHADOW MARGIN RELATIVE 
 DEFINE BAR 1 OF XLAPKOLEKTOR PROMPT '1. Daftar Tagihan Instansi'
 DEFINE BAR 2 OF XLAPKOLEKTOR PROMPT '2. Laporan Rekap Transaksi'
 DEFINE BAR 3 OF XLAPKOLEKTOR PROMPT '3. Laporan Daftar Kolektor'
 ON SELECTION BAR 1 OF XLAPKOLEKTOR do form col_lap with 1  
 ON SELECTION BAR 2 OF XLAPKOLEKTOR do form col_lap with 1  
 ON SELECTION BAR 3 OF XLAPKOLEKTOR do form col_lap with 1  
 DEFINE POPUP XPROSES MARGIN 
 DEFINE BAR 1 OF XPROSES PROMPT '1. Proses Harian' COLOR SCHEME 3
 DEFINE BAR 2 OF XPROSES PROMPT '2. Proses Hitung Perbagian' COLOR SCHEME 3
 DEFINE BAR 3 OF XPROSES PROMPT '3. Proses Perubahan Ketentuan' SKIP FOR  ;
      DEFAIDGROUP <> 'ADMIN' COLOR SCHEME 3
 DEFINE BAR 4 OF XPROSES PROMPT '4. Proses Hitung Ulang Saldo Simpanan' COLOR SCHEME 3
 DEFINE BAR 5 OF XPROSES PROMPT '5. Proses Hitung Ulang Simpanan Pokok dan Wajib' COLOR SCHEME 3
 DEFINE BAR 6 OF XPROSES PROMPT '\-'
 DEFINE BAR 7 OF XPROSES PROMPT '6. ACC Pengeluaran' SKIP FOR  .NOT. IJINACC() COLOR  ;
      SCHEME 3
 DEFINE BAR 8 OF XPROSES PROMPT '\-'
 DEFINE BAR 9 OF XPROSES PROMPT '7. Verifikasi Proses Harian' SKIP FOR  .NOT. IJINACC()  ;
      COLOR SCHEME 3
 DEFINE BAR 10 OF XPROSES PROMPT '\-'
 DEFINE BAR 11 OF XPROSES PROMPT '8. Proses Tutup Buku' SKIP FOR  .NOT. IJINACC() COLOR  ;
      SCHEME 3
 DEFINE BAR 12 OF XPROSES PROMPT '9. Batal Proses Tutup Buku' SKIP FOR  .NOT. IJINACC()  ;
      COLOR SCHEME 3
  DEFINE BAR 13 OF XPROSES PROMPT '\-'
 DEFINE BAR 14 OF XPROSES PROMPT '10. Proses Perhitungan SHU' SKIP FOR  .NOT. IJINACC() COLOR  SCHEME 3    
 
 ON SELECTION BAR 1 OF XPROSES prosharian(0)
 ON SELECTION BAR 2 OF XPROSES prosharian(1)
 ON SELECTION BAR 3 OF XPROSES do form proses_rubah
 ON SELECTION BAR 4 OF XPROSES do form proses_ceksaldo
 ON SELECTION BAR 5 OF XPROSES do form proses_cekpokok_wjb
 ON SELECTION BAR 7 OF XPROSES do form acc
 ON SELECTION BAR 9 OF XPROSES do form acc_harian1
 ON SELECTION BAR 11 OF XPROSES do form proses_tutupbuku
 ON SELECTION BAR 12 OF XPROSES do form proses_bataltutup
 ON SELECTION BAR 14 OF XPROSES do form angg_shu_proses
 DEFINE POPUP XUTIL MARGIN 
 DEFINE BAR 1 OF XUTIL PROMPT 'Pembatasan Tanggal' COLOR SCHEME 3
 ON SELECTION BAR 1 OF XUTIL do form atur_tanggal  
 DEFINE BAR 2 OF XUTIL PROMPT 'Setting Laporan' COLOR SCHEME 3
 ON BAR 2 OF XUTIL ACTIVATE POPUP XUTIL_LAP
 DEFINE POPUP XUTIL_LAP COLOR SCHEME 4 SHADOW MARGIN RELATIVE 
 DEFINE BAR 1 OF XUTIL_LAP PROMPT '1. Setting Laporan / Cetakan'
 DEFINE BAR 2 OF XUTIL_LAP PROMPT '2. Setting Posisi Cetakan'
 ON SELECTION BAR 1 OF XUTIL_LAP do form set_laporan
 ON SELECTION BAR 2 OF XUTIL_LAP do form form_option_cetak
 DEFINE BAR 3 OF XUTIL PROMPT 'Sms GateWay' COLOR SCHEME 3
 ON SELECTION BAR 3 OF XUTIL do form smsgateway1  
 DEFINE BAR 4 OF XUTIL PROMPT 'Backup databased' COLOR SCHEME 3
 ON SELECTION BAR 4 OF XUTIL do form form_backupdata  
 DEFINE BAR 5 OF XUTIL PROMPT 'Perbaikan Transaksi Simpanan' COLOR SCHEME 3
 ON SELECTION BAR 5 OF XUTIL do form a_perbaikan_simpanan
 DEFINE BAR 6 OF XUTIL PROMPT 'Perbaikan Mutasi Keanggotaan' COLOR SCHEME 3
 ON SELECTION BAR 6 OF XUTIL do form a_perbaikan_anggota
 DEFINE BAR 7 OF XUTIL PROMPT 'Cek Transaksi' COLOR SCHEME 3
 ON SELECTION BAR 7 OF XUTIL do form cek_transaksi   
 DEFINE BAR 8 OF XUTIL PROMPT 'Pengaturan Lainnya' COLOR SCHEME 3
 ON BAR 8 OF XUTIL ACTIVATE POPUP XUTIL_LAINNYA
 DEFINE POPUP XUTIL_LAINNYA COLOR SCHEME 4 SHADOW MARGIN RELATIVE 
 DEFINE BAR 1 OF XUTIL_LAINNYA PROMPT '1. Reset Tanggal Proses'
 DEFINE BAR 2 OF XUTIL_LAINNYA PROMPT '2. Proses Pelunasan sld 0'
 DEFINE BAR 3 OF XUTIL_LAINNYA PROMPT '3. Proses Tutup Otomatis Simpanan'
 ON SELECTION BAR 1 OF XUTIL_LAINNYA do form form_resetproses
 ON SELECTION BAR 2 OF XUTIL_LAINNYA do form form_AutoLunas
 ON SELECTION BAR 3 OF XUTIL_LAINNYA do form form_AutoTutup
 DEFINE BAR 8 OF XUTIL PROMPT 'Perbaikan Data' COLOR SCHEME 3
 ON SELECTION BAR 8 OF XUTIL do form a_perbaikan_table
 DEFINE BAR 9 OF XUTIL PROMPT 'Setting Default Printer' COLOR SCHEME 3
 ON SELECTION BAR 9 OF XUTIL do form setting_printer
 
 DEFINE POPUP XABOUT MARGIN 
 DEFINE BAR 1 OF XABOUT PROMPT 'About'
 DEFINE BAR 2 OF XABOUT PROMPT 'Registrasi Program'
 ON SELECTION BAR 1 OF XABOUT DO FORM about
 ON SELECTION BAR 2 OF XABOUT DO FORM register
 ACTIVATE MENU XMFORM
ENDPROC
*------
PROCEDURE coba
 DEFINE WINDOW WCOBA FROM 1 , 1 TO 20 , 30 CLOSE ZOOM TITLE 'Parent' IN DESKTOP
 MODIFY REPORT c:\ctk_buku_mutasi.frx NOWAIT IN WCOBA
 ACTIVATE WINDOW WCOBA
 ACTIVATE SCREEN
ENDPROC
*------*