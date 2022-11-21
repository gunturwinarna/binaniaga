*!*	lcCon = "DRIVER={MySQL ODBC 5.1 Driver};DESC=;DATABASE=binaniaga"+;
*!*			";SERVER=localhost;UID=root"+;
*!*			";PASSWORD=;PORT=3306;OPTION=;STMT=;"
*!*			*+lonmdb
*!*	defaconnect=lcCon
*!*	oODBC=SQLSTRINGCONNECT(defaconnect)

*!*	  csql="SELECT * FROM pinjaman limit 10 "
*!*	  
*!*	  lcek=SQLEXEC(oODBC,csql)
*!*	  
*!*	 
*!*	  IF lcek > 0
*!*	    pesan = 'berhasil  '
*!*	  ELSE
*!*	    pesan =' gagal '
*!*	  endif
*!*	MESSAGEBOX(pesan +csql)

*!*	STORE 'abcdefghijklm' TO myString
*!*	CLEAR
*!*	MESSAGEBOX(mystring)
*!*	MESSAGEBOX(SUBSTR(myString, 1, 5))
*!*	MESSAGEBOX(SUBSTR(myString, 6))
cfiletemp  = 'D:\nominatif_temp'
cfilename = 'D:\Nominatif_oke'
local oExcel, oSheet
 
oExcel = CreateObject([Excel.Application])
oExcel.Visible = .T.
oExcel.Workbooks.Add()
 
oSheet = oExcel.ActiveSheet
 
oSheet.Cells(1,1).Value = [DATA PINJAMAN]
oSheet.Cells(1,1).Font.Bold = .T. 
 
lnRow = 0
*!*	 di tutup dulu
* SELECT * FROM pinjaman INTO CURSOR pinjam

*inset into pinjam from pinjaman

*SELECT csrMHS
GO TOP
DO WHILE NOT EOF()
    lnRow = lnRow + 1
    IF lnRow = 1   
        lnRow = 3
        lnCol = 1
         
        oSheet.Range([A3]).Select
        oSheet.Cells(lnRow,lnCol).Value = [NOREK]
        oSheet.Cells(lnRow,lnCol).Font.Bold = .T.       
        oSheet.Cells(lnRow,lnCol).HorizontalAlignment = 3
         
        lnCol = lnCol + 1
        oSheet.Range([B3]).Select
        oSheet.Cells(lnRow,lnCol).Value = [NOPK]
        oSheet.Cells(lnRow,lnCol).Font.Bold = .T.       
        oSheet.Cells(lnRow,lnCol).HorizontalAlignment = 3
         
        lnCol = lnCol + 1
        oSheet.Range([C3]).Select
        oSheet.Cells(lnRow,lnCol).Value = [CIF]
        oSheet.Cells(lnRow,lnCol).Font.Bold = .T.
        oSheet.Cells(lnRow,lnCol).HorizontalAlignment = 3
         
        lnCol = lnCol + 1
        oSheet.Range([D3]).Select
        oSheet.Cells(lnRow,lnCol).Value = [TANGGAL]
        oSheet.Cells(lnRow,lnCol).Font.Bold = .T.
        oSheet.Cells(lnRow,lnCol).HorizontalAlignment = 3
 
        lnCol = lnCol + 1
        oSheet.Range([E3]).Select
        oSheet.Cells(lnRow,lnCol).Value = [POKOK]
        oSheet.Cells(lnRow,lnCol).Font.Bold = .T.
        oSheet.Cells(lnRow,lnCol).HorizontalAlignment = 3
         
        lnRow = 4
        lnBeginRange = lnRow
    ENDIF
*!*	     
*!*	    oSheet.Cells(lnRow,1).Value = "'"+csrMHS.nim 
*!*	    oSheet.Cells(lnRow,2).Value = csrMHS.nama_mhs
*!*	    oSheet.Cells(lnRow,3).Value = csrMHS.jk 
*!*	    oSheet.Cells(lnRow,4).Value = csrMHS.tmpt_lahir 
*!*	    oSheet.Cells(lnRow,5).Value = csrMHS.alamat 

    oSheet.Cells(lnRow,1).Value = "'"+kredit.norek 
    oSheet.Cells(lnRow,2).Value = kredit.nopk
    oSheet.Cells(lnRow,3).Value = kredit.cif
    oSheet.Cells(lnRow,4).Value = kredit.tanggal 
    oSheet.Cells(lnRow,5).Value = kredit.pokok

*!*	 
    SKIP
ENDDO

oExcel   = CREATEOBJECT("Excel.Application")
oWorkbook = oExcel.Application.Workbooks.Open(cfiletemp)
oWorkbook.SaveAs(cfilename)
oExcel.Quit
oExcel = NULL
 
DELETE FILE '&cfiletemp'
 
WAIT 'Create File ' + cfilename + ' Success..!' WINDOW NOWAIT