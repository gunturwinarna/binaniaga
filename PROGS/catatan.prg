* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
*  FileName CATATAN.PRG <-- This file create by UnFoxAll
* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


 TEXT 
  *------------- sebagai dasar baca register ----------------
  * ambil tanggal pembuatan tabel user
  SELECT create_time FROM INFORMATION_SCHEMA.TABLES where table_schema='suryaartha' and table_name='user'
   
  *------------------- form transparant
  * Penulisanya
  * 1. Ketik Di Form procedure - init
  * : transparent(thisform.HWnd, thisform.BackColor)
  * 2. buat background formnya : RGB(255,0,255)
  * 3. ShowWindow=2
  * 4. Ketik di Form procedure - unload
  * CLEAR DLLS GetWindowLong,SetWindowLong,SetLayeredWindowAttributes
  *------------------------------------------------------------------------
  PROCEDURE transparenci
  LPARAMETERS nHWND, nColor
  DECLARE INTEGER GetWindowLong IN user32.DLL INTEGER hWnd, ;
  INTEGER nIndex
  DECLARE INTEGER SetWindowLong IN user32.DLL INTEGER hWnd, ;
  INTEGER nIndex, ;
  INTEGER dwNewLong
  DECLARE INTEGER SetLayeredWindowAttributes IN WIN32API INTEGER HWND, ;
  INTEGER crKey, ;
  INTEGER bAlpha,;
  INTEGER dwFlags
  *********************************************************************************************
  #DEFINE LWA_TRANSPARENT 1
  #DEFINE GWL_EXSTYLE -20
  #DEFINE WS_EX_LAYERED 0x00080000
  
  LOCAL lnFlags
  *********************************************************************************************
  lnFlags = GetWindowLong(nHWND, GWL_EXSTYLE) && Gets the existing flags from the window
  lnFlags = BITOR(lnFlags, WS_EX_LAYERED) && Appends the Layered flag to the existing ones
  SetWindowLong(nHWND, GWL_EXSTYLE, lnFlags) && Sets the new flags to the window
  SetLayeredWindowAttributes(nHWND, nColor, 0, LWA_TRANSPARENT)
  ENDPROC
  * HexToStr
  *******************************************
  Function HexToStr(cBytes)
  Local cReturn,n
  cReturn=""
  For n=Len(cBytes)/2 to 1 step -1
  nChr=eval("0x"+SubStr(cBytes,(n-1)*2+1,2))
  cReturn=cReturn+chr(nChr)
  endfor
  Return cReturn
  EndFunc 
  *-------------- default printer
  * Penulisannya
  * =GetdefaPrn()
  *----------------------------------------------------------------------------
  PROCEDURE getdefaprn
  DECLARE INTEGER GetDefaultPrinter IN winspool.drv;
  STRING @ pszBuffer,;
  INTEGER @ pcchBuffer
  
  * returns default printer name (WinNT)
  nBufsize = 250
  cPrinter = REPLICATE(Chr(0), nBufsize)
  
  = GetDefaultPrinter(@cPrinter, @nBufsize)
  cPrinter = SUBSTR(cPrinter, 1, AT(Chr(0),cPrinter)-1)
  RETURN cPrinter
  ENDPROC 
  
  *------------------- cek mac address
  cMacAddress=""
  objWMIService = GetObject("winmgmts:"+;
   "{impersonationLevel=impersonate}!\\.\root\cimv2")
  colItems = objWMIService.ExecQuery(;
   "Select * From Win32_NetworkAdapterConfiguration")
  For Each objItem in colItems
   IF varTYPE(objItem.MACAddress)="C"
    cMacAddress=cMacAddress+objItem.MACAddress+","
    endif
  endfor
  ?cMacAddress
  
  *__________________ untuk baca processor
  objWMIService = GetObject("winmgmts:" ;
   + "{impersonationLevel=impersonate}!\\" + "."+ "\root\cimv2")
  colItems  =  objWMIService.ExecQuery( ;
   "Select  *  from  Win32_Processor")
  For  Each  objItem  in  colItems
    cName = objItem.Name
  ENDFOR
  *----------- atau dengan ini (baca prosesor
  GETENV("PROCESSOR_ARCHITECTURE")
  GETENV("PROCESSOR_IDENTIFIER")
  GETENV("PROCESSOR_LEVEL")
  GETENV("NUMBER_OF_PROCESSORS")
  GETENV("PROCESSOR_REVISION")
  
  *------------------- mengatur uac windows-------------
  */ Meng-Enable UAC /*
  WSHShell = CreateObject("WScript.Shell")
  cKey = "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\"+;
   "Policies\System\EnableLUA"
  WshShell.RegWrite(cKey, 1, "REG_DWORD")
  
  */ Men-Disable UAC /*
  WSHShell = CreateObject("WScript.Shell")
  cKey = "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\"+;
   "Policies\System\EnableLUA"
  WshShell.RegWrite(cKey, 0, "REG_DWORD")
  
  *--------------backup mysql---------------
  1. backup
  EXECSCRIPT("! mysqldump -u root -padmin dbpos > " + ;
   "c:\File_hasil_Export.sql")
  2. restore
  EXECSCRIPT("! mysql -u root -padmin dbpos < " +;
   "c:\File_Hasil_Export.sql") 
  
  *--------------- mengetahui kapasitas harddisk
  cDrive="D"
  objWMIService = GetObject("winmgmts:" +;
   "{impersonationLevel=impersonate}!\\" +;
   GETENV("COMPUTERNAME") + "\root\cimv2")
  colDisks = objWMIService.ExecQuery;
  ("Select * from Win32_LogicalDisk Where DriveType = 3")
  iCek=0
  For Each objDisk in colDisks
   IF objDisk.DeviceID=UPPER(cDrive)+":"
    IFreeSpace = objDisk.FreeSpace
    ITotalSpace = objDisk.Size
    ITotalUsage = objDisk.Size - objDisk.FreeSpace
    iCek=1
   ENDIF
  ENDFOR
  IF iCek=0
   MESSAGEBOX("Drive yang anda masukkan tidak ada")
   IFreeSpace = 0
   ITotalSpace = 0
   ITotalUsage = 0
  ENDIF 
  *---------------------------------- merubah atrribut file
  
  *Menambahkan Attribut R (Read Only)
  cNmFile="c:\FoxproMania.doc"
  EXECSCRIPT("! /n attrib " + cNmFile + " +R")
  
  *Menambahkan Attribut H (Hidden)
  cNmFile="c:\FoxproMania.doc"
  EXECSCRIPT("! /n attrib " + cNmFile + " +H")
  
  *Menambahkan Attribut S (System)
  cNmFile="c:\FoxproMania.doc"
  EXECSCRIPT("! /n attrib " + cNmFile + " +S")
  
  *Menambahkan Attribut A, H dan S sekaligus
  cNmFile="c:\FoxproMania.doc"
  EXECSCRIPT("! /n attrib " + cNmFile + " +A +H +S")
  
  *Menghilangkan Attribut R (Read Only)
  cNmFile="c:\FoxproMania.doc"
  EXECSCRIPT("! /n attrib " + cNmFile + " -R")
  
  *Menghilangkan Attribut H (Hidden)
  cNmFile="c:\FoxproMania.doc"
  EXECSCRIPT("! /n attrib " + cNmFile + " -H")
  
  *Menghilangkan Attribut S (System)
  cNmFile="c:\FoxproMania.doc"
  EXECSCRIPT("! /n attrib " + cNmFile + " -S")
  
  *Menghilangkan Attribut A, H dan S sekaligus
  cNmFile="c:\FoxproMania.doc"
  EXECSCRIPT("! /n attrib " + cNmFile + " -S -H -A")
  
  *------------------------------------------------- mengganti nama komputer
  ewName = "FoxproMania"
  strComputer = "." 
  objWMIService = GetObject("winmgmts:" ;
   + "{impersonationLevel=impersonate}!\\" + ;
   strComputer + "\root\cimv2")
  colComputers = objWMIService.ExecQuery;
   ("Select * from Win32_ComputerSystem")
  For Each objComputer in colComputers
   err = ObjComputer.Rename(sNewName)
   If err <> 0
    MESSAGEBOX("Penggantian Nama Komputer Gagal..!!, ;
     error # " + Err)
   Else
    MESSAGEBOX("Penggantian Nama Komputer Berhasil, ;
     Silahkan Restart PC")
   EndIf
  EndFor 
  
  *---------------------------------------------------mengetahui komputer yg terhubung
  
  ! net view > c:\tmp.txt
  cTmp=filetoSTR("c:\tmp.txt")
  DELETE FILE c:\tmp.txt
  cListpc=SUBSTR(cTmp,AT("\\", cTmp),;
   AT("The command", cTmp)-AT("\\", cTmp))
  
   *------------------------------------------------- compress & extract file
   && Source untuk Mengkompress Folder
  strFolderName="d:\test\hasil" && Folder yang mau di kompress
  strZipFileName="c:\hasil.zip" && Nama File ZIP hasil kompres
  IF DIRECTORY(JUSTPATH(strZipFileName))=.f.
   MESSAGEBOX("Folder '"+strZipFileName+"' Tidak ada") 
   RETURN .f.
  ENDIF  
  IF LOWER(JUSTEXT(strZipFileName))<>"zip"
   strZipFileName=strZipFileName+".zip"
  ENDIF
  fso = CreateObject("Scripting.FileSystemObject")
  ts = fso.OpenTextFile(strZipFileName, 8, .t.)
  BlankZip = "PK" + Chr(5) + Chr(6)
  For x = 1 to 18
   BlankZip = BlankZip + Chr(0)
  ENDFOR
  ts.Write(BlankZip)
  objShell = CreateObject("Shell.Application")
  WshShell = CreateObject("WScript.Shell")
  DestFldr=objShell.NameSpace(strZipFileName)
  SrcFldr=objShell.NameSpace(strFolderName)
  DestFldr.CopyHere(strFolderName)
  *--------------------- 
  && Source untuk Mengekstrak File ZIP
  strFolderName="c:\hasil" && Folder untuk menempatkan file yg di ekstrak
  strFileName="c:\hasil.zip" && File ZIP yang ingin di ekstrak
  objshell = CreateObject("Shell.Application")
  objfso = CreateObject("Scripting.FileSystemObject")
  If !DIRECTORY(strFolderName) 
   objfso.CreateFolder(strFolderName)
  ENDIF 
  objshell.NameSpace(strFolderName).CopyHere;
  (objshell.NameSpace(strFileName).Items)
  
  *----------------------------------------------------- drive
  WSHShell = CreateObject("WScript.Shell")
  
  *Menyembunyikan Drive
  WSHShell.RegWrite("HKEY_CURRENT_USER\Software\Microsoft\+;
   "Windows\CurrentVersion\Policies\Explorer\NoDrives", 256,;
   "REG_DWORD")
  
  *Menampilkan kembali drive yang disembunyikan
  WSHShell.RegDelete("HKEY_CURRENT_USER\Software\Microsoft\+;
   "Windows\CurrentVersion\Policies\Explorer\NoDrives")
  
  *Memproteksi Drive
  WSHShell.RegWrite("HKEY_CURRENT_USER\Software\Microsoft\+;
   "Windows\CurrentVersion\Policies\Explorer\NoViewOnDrive", 256,;
   "REG_DWORD")
  
  *Menghilangkan proteksi pada drive yang terproteksi
  WSHShell.RegDelete("HKEY_CURRENT_USER\Software\Microsoft\+;
   "Windows\CurrentVersion\Policies\Explorer\NoViewOnDrive")
  
  * catatan a=1,b=2,c=4,d=8 dst
  
  *-----------------------------------------------------------------register
  WSHShell = CreateObject("WScript.Shell")
  
  *Membuat key dengan nama "Kunciku" di HKCU dengan nilai default "Kunci Tertinggi"
  WSHShell.RegWrite("HKCU\Kunciku\", "Kunci Tertinggi")
  
  *Membuat subkey dengan nama "FoxMania" di bawah key "Kunciku" dengan nilai default "Subkey"
  WSHShell.RegWrite("HKCU\Kunciku\FoxMania\", "Subkey")
  
  *Membuat sebuah nilai dengan nama "setting" di dalam Key "Kunciku" dengan tipe text yang berisi "1" (REG_SZ)
  WSHShell.RegWrite("HKCU\Kunciku\setting", 1)
  
  *Membuat sebuah nilai dengan nama "kode" di dalam Key "Kunciku" dengan tipe decimal yang berisi 3 (REG_DWORD)
  WSHShell.RegWrite("HKCU\Kunciku\kode", 3, "REG_DWORD")
  
  *Membuat sebuah nilai dengan nama "setting2" di dalam SubKey "FoxMania" dengan tipe binary yang berisi 3 (REG_BINARY)
  WSHShell.RegWrite("HKCU\Kunciku\FoxMania\setting2", 4,;
   "REG_BINARY")
  
  *Membaca nilai default dari Key Kunciku dan disimpan dalam variable cnil
  cnil = WSHShell.RegRead("HKCU\Kunciku\")
  
  *Membaca nilai default dari SubKey FoxMania dan disimpan dalam variable cnil 
  cnil = WSHShell.RegRead("HKCU\Kunciku\FoxMania\")
  
  *Membaca nilai setting yang ada di Key Kunciku dan disimpan dalam variable cnil 
  cnil = WSHShell.RegRead("HKCU\Kunciku\setting")
  
  *Membaca nilai kode yang ada di Key Kunciku dan disimpan dalam variable cnil 
  cnil = WSHShell.RegRead("HKCU\Kunciku\kode")
  
  *Menghapus nilai setting2 yang berada di dalam subkey FoxMania
  WSHShell.RegDelete("HKCU\Kunciku\FoxMania\setting2")
  
  *Menghapus SubKey FoxMania
  WSHShell.RegDelete("HKCU\Kunciku\FoxMania\") 
  
  *Menghapus key Kunciku
  WSHShell.RegDelete("HKCU\Kunciku\") 
  
  *----------------------------------------------------- mengatur tanggal dan jam komputer
  *Pengaturan tanggal dengan format (dd/mm/yyyy)
  ctgl="21/03/2011"
  EXECSCRIPT("! date "+ctgl)  
  
  *Pengaturan waktu dengan format (hh:mm:ss)
  cwkt="09:06:20"
  EXECSCRIPT("! time "+cwkt)
  
  *----------------------------------------------------- mengganti nomor IP
  
  cip="192.168.1.189"
  csubnet="255.255.255.0"
  cgateway="192.168.1.1"
  cscr= '! netsh interface ip set address "Local Area connection";
  static '+cip+" "+csubnet+" "+cgateway+" 1"
  EXECSCRIPT(cscr)
  
  *----------------------------------------------------- mendeteksi koneksi internet
  
  DECLARE Long InternetCheckConnection IN Wininet.dll String Url,;
  Long dwFlags, Long Reserved
  lcUrl = "http://www.google.com"
  IF InternetCheckConnection(lcUrl, 1, 0) <> 0
  cStatus="Terkoneksi"
  ELSE
  cStatus="Tidak Terkoneksi"
  ENDIF
  
  *------------------------------------------------- mengetahui nama workgroup
  RUN net config workstation | FINDSTR.EXE ;
   /R /B /I /C:"Workstation domain  " >> c:\tmp.txt
  cwg=ALLTRIM(SUBSTR(FILETOSTR("c:\tmp.txt"),;
   19,LEN(FILETOSTR("c:\tmp.txt"))))
  DELETE FILE c:\tmp.txt
  
  *------------------------------------------------- mengetahui ip public
  Cara 1 -->
  
  oHTML = CreateObject("MSXML2.XMLhttp")
  oHTML.open("GET", "http://www.your-ip-address.com", .F.)
  ohtml.send()
  P3=oHTML.ResponseText
  P1="Your IP address is"
  P2="</nobr></td></tr></table>"
  CIP=SUBSTR(P3,AT(P1,P3,1)+39,AT(P2,P3,1)-AT(P1,P3,1)-39)
  
  
  Cara 2 -->
  
  LOCAL oIe AS InternetExplorer.Application
  LOCAL tDt
  oIe = CREATEOBJECT([InternetExplorer.Application])
  oIe.Navigate2([whatismyip.com])
  tDt = DATETIME()
  DO WHILE oIe.ReadyState <> 4 AND DATETIME() - tDt < 30
     INKEY(0.01)
  ENDDO
  
  ALINES(laLines,oIe.Document.Body.InnerText)
  CIP=SUBSTR(ALLTRIM(laLines[3]),21,LEN(ALLTRIM(laLines[3]))-21)
  oIe = NULL
  
  *---------- cek koneksi sebelum transaksi
  IF SQLEXEC(lnSQH,[SELECT @@IDENTITY],[crsTest]) < 0
     MessageBox([Connection is not valid anymore])
     RETURN
  ENDIF
  USE IN SELECT([crsTest]
  
  *---- notifikasi tabungan
  Dari : BANK MANDIRI
  Trx Rek : xxx123
  Transaksi KREDIT : Rp. 50000
  tanggal :xx-xx-xxxx jam :xx:xx:xx
  *------ perintah di word
  
  buat tabel
  Set myRange = ActiveDocument.Range(Start:=0, End:=0)
  ActiveDocument.Tables.Add Range:=myRange, NumRows:=3, NumColumns:=4
  cari dan ganti di dokumen lain
  
   ActiveDocument.Range(Start:=0, End:=ActiveDocument.Content.End).Copy
      Documents(1).Activate
      Set myRange = ActiveDocument.Content
      myRange.Find.Execute FindText:="<<jaminan>>"
      myRange.Paste
  *!*	 
  *!*	*--------------- hanya ntuk catatan pengingat saja
  *!*	csql="select coba1 from aa"
  *!*	lcek=SQLEXEC(oODBC,csql,"smt")
  *!*	csql=coba1
  *!*	USE 
  *!*	csql=STRTRAN(csql,"&tanggal&","2015-03-19")
  *!*	csql=STRTRAN(csql,"&noper&","1101")
  *!*	MESSAGEBOX(csql)
  *!*	lcek=SQLEXEC(oODBC,csql,"smt")
  
  *!*	 
  *!*	  1. mengganti kata tertentu STRTRAN(kalimat,'KATA')
  *!*	  ?EXECSCRIPT("oForm=CREATEOBJECT('Form')"+CHR(13)+"?oForm.AutoCenter")
  *!*	   
  *!*	
  
  *!*	*----- untuk cetak struk
  *!*	*-----------------------------------------------------------------------------------------*
  *!*	FUNCTION DGEN_RPT  &&  DOS REPORTS
  *!*	*-----------------------------------------------------------------------------------------*
  *!*	LPARAMETERS lcPrn_Target,lcRpt_Prg,lcPF_Name,lnFontSize,llShowMsg
  
  *!*	IF PARAMETERS() < 4
  *!*	   lnFontSize = gnFontNorm
  *!*	ENDIF
  
  *!*	IF PARAMETERS() < 5
  *!*	   llShowMsg = .F.
  *!*	ENDIF
  
  *!*	IF PARAMETERS() < 3
  *!*	   lcPF_Name = SET("PRINTER",3)
  *!*	ENDIF
  
  *!*	*---  PRINTER
  *!*	IF lcPrn_Target = "PRINTER"
  
  *!*	   lcSavePrn = SET("PRINTER",3)
  *!*	   IF SET("PRINTER",3) <> lcPF_Name
  *!*	      SET PRINTER TO NAME (lcPF_Name)
  *!*	   ENDIF
  *!*	   SET CONSOLE OFF
  *!*	   SET DEVICE TO PRINT
  *!*	   SET PRINTER FONT "Courier New",lnFontSize
  *!*	   IF llShowMsg
  *!*	      WAIT WINDOW " PRINTING REPORT ... PLEASE WAIT " NOWAIT
  *!*	   ENDIF
  
  *!*	   DO (lcRpt_Prg)
  
  *!*	   SET CONSOLE ON
  *!*	   SET DEVICE TO SCREEN
  *!*	   SET PRINTER TO
  *!*	   IF SET("PRINTER",3) <> lcSavePrn
  *!*	      SET PRINTER TO NAME (lcSavePrn)
  *!*	   ENDIF
  
  *!*	   IF llShowMsg
  *!*	      WAIT CLEAR
  *!*	   ENDIF
  *!*	ELSE
  
  *!*	   lcSavePrn = SET("PRINTER",3)
  *!*	   SET PRINTER TO (lcPF_Name)
  *!*	   SET CONSOLE OFF
  *!*	   SET DEVICE TO PRINT
  *!*	   SET PRINTER FONT "Courier New",lnFontSize
  *!*	   IF llShowMsg
  *!*	      WAIT WINDOW " PRINTING REPORT ... PLEASE WAIT " NOWAIT
  *!*	   ENDIF
  
  *!*	   DO (lcRpt_Prg)
  
  *!*	   SET CONSOLE ON
  *!*	   SET DEVICE TO SCREEN
  *!*	   SET PRINTER TO
  *!*	   IF SET("PRINTER",3) <> lcSavePrn
  *!*	      SET PRINTER TO NAME (lcSavePrn)
  *!*	   ENDIF
  
  *!*	   IF llShowMsg
  *!*	      WAIT CLEAR
  *!*	   ENDIF
  *!*	ENDIF
  *!*	RETURN ""
  *!*	*-----------------------------------------------------------------------------------------* 
  *!*	*------------------- ini juga cetak struk
  *!*	CLEAR
  *!*	CLEA ALL
  *!*	LOCAL JmlFile
  *!*	JmlFile = 0
  *!*	WAIT WIND “Tunggu sebentar …” NOWA
  *!*	JmlFile = ADIR(aFile,”data\*.DBF”)
  *!*	WAIT CLEAR
  *!*	LIST DATABASE TO FILE PROGRAM\Inf_Data.txt
  *!*	IF JmlFile > 0
  *!*	* persiapan pencetakkan …
  *!*	LOCAL JmlField, JenisTag
  *!*	JenisTag = “”
  *!*	IF FILE(“PROGRAM\”+DTOS(DATE())+”.TXT”)
  *!*	aa=”DELE FILE PROGRAM\”+DTOS(DATE())+”.TXT”
  *!*	&aa
  *!*	ENDIF
  *!*	aa = “SET PRINTER TO PROGRAM\”+DTOS(DATE())+”.TXT ADDI”
  *!*	&aa
  *!*	SET PRINT ON
  *!*	ASORT(aFile)
  *!*	FOR j=1 TO JmlFile
  *!*	WAIT WIND “[“+ALLTRIM(STR(j))+”/”+ALLTRIM(STR(JmlFile))+”] FileName : “+ALLTRIM(aFile[j,1]) NOWAIT
  *!*	nmafile = ALLTRIM(aFile[j,1])
  *!*	USE “DATA\”+ALLTRIM(aFile[j,1]) IN 1 SHARED
  *!*	JenisTag = “”
  *!*	IF j=1
  *!*	? ” STRUKTUR DATABASE : PASIEN”
  *!*	? “—————————–”
  *!*	ENDIF
  *!*	? “[“+ALLTRIM(STR(j))+”/”+ALLTRIM(STR(JmlFile))+”] File Name : “+nmafile
  *!*	? CHR(218)+REPLICATE(CHR(196),16)+CHR(194)+REPLICATE(CHR(196),4)+   CHR(194)+REPLICATE(CHR(196),5)+CHR(194)+REPLICATE(CHR(196),3)+CHR(191)
  *!*	? CHR(179)+” Name           “+CHR(179)+”Type”+CHR(179)+”Width”+CHR(179)+”Dec”+CHR(179)
  *!*	? CHR(195)+REPLICATE(CHR(196),16)+CHR(197)+REPLICATE(CHR(196),4)+CHR(197) +REPLICATE(CHR(196),5)+CHR(197)+REPLICATE(CHR(196),3)+CHR(180)
  *!*	JmlField = AFIELDS(AObjField)
  *!*	FOR i=1 TO JmlField
  *!*	? CHR(179)+” “+PADR(AObjField(i,1),15,” “)+CHR(179)+” “+PADR(AObjField(i,2),1,” “)+”  “+CHR(179)+TRANSFORM(AObjField(i,3),”@Z ###”)+;
  *!*	”  “+CHR(179)+TRANSFORM(AObjField(i,4),”@Z ##”)+” “+CHR(179)
  *!*	ENDFOR
  
  *!*	? CHR(195)+REPLICATE(CHR(196),12)+Chr(194)+REPLICATE(CHR(196),3)+ CHR(193)+Chr(194)+REPLICATE(CHR(196),3)+CHR(193)+ REPLICATE(CHR(196),5)+CHR(193)+REPLICATE(CHR(196),3)+CHR(193)+REPLICATE(CHR(196),8)
  *!*	? CHR(179)+” TAG        “+CHR(179)+”Type”+CHR(179)+”  Expresion & Filter”
  *!*	? CHR(195)+REPLICATE(CHR(196),12)+Chr(197)+     REPLICATE(CHR(196),4)+Chr(197)+REPLICATE(CHR(196),10)+ REPLICATE(CHR(196),3)+REPLICATE(CHR(196),9)
  *!*	FOR nCount = 1 TO 254
  *!*	IF !EMPTY(TAG(nCount))  && Checks for tags in the index
  *!*	DO CASE
  *!*	CASE PRIMARY(nCount)
  *!*	JenisTag = “P”
  *!*	CASE CANDIDATE(nCount)
  *!*	JenisTag = “C”
  *!*	OTHERWISE
  *!*	JenisTag = “R”
  *!*	ENDCASE
  *!*	? CHR(179)+” “+PADR(TAG(nCount),11,” “)+CHR(179)+”  “+JenisTag+” “+CHR(179)+Key(nCount)
  *!*	? CHR(179)+SPACE(12)+CHR(179)+SPACE(4)+CHR(179)+FOR(nCount)      && Display .CDX names
  *!*	ELSE
  *!*	EXIT  && Exit the loop when no more tags are found
  *!*	ENDIF
  *!*	ENDFOR
  *!*	? CHR(192)+REPLICATE(CHR(196),12)+Chr(193)+REPLICATE(CHR(196),4)+Chr(193)+ REPLICATE(CHR(196),10)+REPLICATE(CHR(196),3)+REPLICATE(CHR(196),9)
  *!*	? “”
  *!*	USE
  *!*	ENDFO
  *!*	WAIT CLEAR
  *!*	SET PRINT OFF
  *!*	SET PRINTER TO
  *!*	MESSAGEBOX(“Proses telah dilakukan …”,0+64,””)
  *!*	*——————-
  *!*	ELSE
  *!*	MessageBox(“Tidak ada DATABASE …!!!!”,0+16,””)
  *!*	RETU .T.
  *!*	ENDIF
  *!*	CLOS ALL
  *!*	CLEA ALL
  *!*	CLEAR
  *!*	*-----------------------------
  *!*	*-------------- ini juga
  *!*	* ---- start
  *!*	LOCAL nRow
  *!*	nRow = 0
  *!*	nCounter = 0
  *!*	SET DEVICE TO FILE test.txt
  *!*	@ 0,0 say CHR(27)+"@"+CHR(27)+"M"
  *!*	FOR nRow = 1 TO 5
  *!*	   nCounter = nCounter + 1
  *!*	   @ nRow,10 say "???? : "+STR(nCounter)
  *!*	NEXT
  *!*	@ nRow, 0 say ""
  *!*	SET DEVICE TO SCREEN
  *!*	!type test.txt > prn
  *!*	* ---- end
  
  *!*	it works, but cannot print chinese, pls try and let me know
  
  *!*	*----------------- ini langsung ke printer tidak lewat windows
  *!*	CLEAR ALL
  *!*	USE m:\global\accounts\globalnew IN 0 SHARED
  *!*	SELECT globalnew
  
  *!*	SET PRINTER on
  *!*	SET PRINTER TO \\printscanserver\ZebraGen
  *!*	GO 136580
  *!*	DO WHILE RECNO()<136590
  
  
  
  *!*	??? '^xa'
  *!*	??? '^lh30,80'
  *!*	??? '^FO20,10^AS,90,90^FDHAWB: '
  *!*	? docket_no
  *!*	??? '^FS'
  *!*	??? '^FO20,110^AS,35^FD'
  *!*	? space(5)+ Upper(trim(company))
  *!*	??? '^FS'
  *!*	??? '^FO20,160^AS,35^FD'
  *!*	?  space(5)+upper(trim(address1))
  *!*	??? '^FS'
  *!*	??? '^FO20,210^AS,35^FD'
  *!*	?   space(5)+upper(trim(address2))
  *!*	??? '^FS'
  *!*	??? '^FO20,260^AS,35^FD'
  *!*	?   space(5)+upper(trim(address3))
  *!*	??? '^FS'
  *!*	??? '^FO20,310^AS,35^FD'
  *!*	?  space(5)+upper(trim(address4))
  *!*	??? '^FS'
  *!*	??? '^FO20,400^AS,35^FDCONTACT: '
  *!*	?  space(5)+upper(trim(CONTACT))
  *!*	???'^FS'
  *!*	??? '^FO20,480^AS,90,90^FD'
  *!*	?   space(5)+str(GLOBALNEW.PIECES,4)+" of "+str(globalnew.pieces,4)
  *!*	??? '^FS'
  *!*	??? '^FO120,650^BC,60^FD'
  *!*	if upper(trim(globalnew.country))="ITALY" OR upper(trim(globalnew.country))="SWITZERLAND";
  *!*	OR upper(trim(globalnew.country))="BELGIUM" OR upper(LEFT(globalnew.country,3))="LUX"
  *!*	?? space(5)+"*"+alltrim(str(globalnew.docket_no))+"*"
  *!*	endif 
  *!*	? DOCKET_NO
  *!*	??? '^FS'
  *!*	??? '^XZ'
  *!*	SKIP
  *!*	enddo
  
  *!*	SET PRINTER off
  *!*	SET PRINTER TO default
  *--------------------------- skenario cetak 1 ------------------
  install printer dengan sharing
  anggap printer aktif di lpt1 (saat awal masuk program)
    net use lpt1: \\user-PC\PLQ20 /persistent:yes
    
  hapus setelah selesai (saat keluar program)
    net use */del
  *------------------------- melihat tabel dalam 1 databased
  select table_name from information_schema.tables where table_schema='<your_database_name>';  
  
  *------- cetak perjanjian
   
  *!*	lcIsiPerjanjian = ''
  *!*	TEXT TO lcSQLGetLapTagihan TEXTMERGE NOSHOW PRETEXT 2
  *!*	PERJANJIAN KITA BERSAMA
  *!*	NO. 15-17.123.2322.
  
  *!*	Dengan ini kami nyatakan telah berjanji...
  
  
  *!*	<<bla...bla...>>
  
  *!*	terima kasih
  *!*	endtext
  
  
  
  
 ENDTEXT 
*
