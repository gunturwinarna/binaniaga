* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
*  FileName BUATINI.PRG <-- This file create by UnFoxAll
* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-



PROCEDURE buatfileini
 DO CREATEINI
 LOCAL CFILE
 CFILE = SYS(5) + SYS(2003) + '\TERRA.INI'
 = MAKEFILE(CFILE)
 = WRITEPRIVATEPROFILESECTION('NAMAKOP','KOPN=KSP "YAKIN"' + CHR(0),CFILE)
 = WRITEPRIVATEPROFILESECTION('CONECTION','server=localhost	' + CHR(0) + 'user=root	' + CHR(0) + 'password=123	' + CHR(0) +  ;
'databased=koperasi	' +  ;
CHR(0) +  ;
'# ----------- sms banking' +  ;
CHR(0) +  ;
'sms_port=' +  ;
CHR(0) +  ;
'sms_baundrate=' +  ;
CHR(0) +  ;
'# ----------- MDC' +  ;
CHR(0) +  ;
'mdc_port=' +  ;
CHR(0) +  ;
'mdc_baundrate=' +  ;
CHR(0) +  ;
'# ----------- BARCODE' +  ;
CHR(0) +  ;
'bar_port=' +  ;
CHR(0) +  ;
'bar_baundrate=' +  ;
CHR(0),CFILE)
 = WRITEPRIVATEPROFILESECTION('IMAGE','MAINICON=.\image\desktop.ico' + CHR(0) + 'BACKLOGO=' + CHR(0) +  ;
'HEADTOP=KSP "YAKIN"' +  ;
CHR(0),CFILE)
 = WRITEPRIVATEPROFILESECTION('FORMAT','ANGGOTA =!!.!!!!!!!' + CHR(0) + 'SIMPANAN=!!!.!!.!!!!!!' + CHR(0) +  ;
'PINJAMAN=!!.!!.!!!!!' +  ;
CHR(0),CFILE)
 = WRITEPRIVATEPROFILESECTION('KEYPRESS','CKEYSEARCH=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890. -_/[],:',CFILE)
 RETURN 
ENDPROC
*------
PROCEDURE bacapublic
 RETURN 
ENDPROC
*------
PROCEDURE MakeFile
 LPARAMETER CFILE
 IF FILE(CFILE)
 DELETE File (CFILE)
 ENDIF 
 HFILE = FCREATE(CFILE)
 = FCLOSE(HFILE)
ENDPROC
*------
PROCEDURE CreateINI
 DECLARE WritePrivateProfileSection IN kernel32 STRING , STRING , STRING 
 DECLARE WritePrivateProfileString IN kernel32 STRING , STRING , STRING , STRING 
ENDPROC
*------*
