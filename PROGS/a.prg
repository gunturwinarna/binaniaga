lcCon = "DRIVER={MySQL ODBC 5.1 Driver};DESC=;DATABASE=binaniaga"+;
		";SERVER=localhost;UID=root"+;
		";PASSWORD=;PORT=3306;OPTION=;STMT=;"
		*+lonmdb
defaconnect=lcCon
oODBC=SQLSTRINGCONNECT(defaconnect)

MESSAGEBOX(TIME())
xjam = TIME()

MESSAGEBOX(TIME())
 
csql= "update anggota_mutasi set jam = '"+xjam+"'"
lcek=SQLEXEC(oODBC,csql,'jam')
IF lcek > 1
 xx =' berhasil '
 ELSE
 xx =' gagal '
 ENDIF
 
MESSAGEBOX(xx+csql )



return

* ambil nilai kode ke A
  csql ="select kode from resort where spv='spv1' and urutan='A'"
  lcek=SQLEXEC(oODBC,csql,'SPV')
   
  xresortA =kode
  brow
* ambil nilai kode ke B  
  csql ="select kode from resort where spv='spv1' and urutan='B'"
  lcek=SQLEXEC(oODBC,csql,'SPV')
   
  xresortB =kode
  brow
  
  
 *baca anggota dengan 2 kunci xresortA dan xresortB
 csql ="SELECT * FROM anggota  WHERE resort='"+TRIM(xresortA)+"'or resort='"+TRIM(xresortB)+"'"
 lcek=SQLEXEC(oODBC,csql,'AGT')
  
  IF lcek > 0
    pesan = 'berhasil  '
  ELSE
    pesan =' gagal '
  ENDIF
  
MESSAGEBOX(pesan +csql)

brow


*!*	csql ='select norek,tglinp, substr(tglinp,11,9) as jam from col_bayar where norek=00000323'
*!*				lcek=SQLEXEC(oODBC,csql)
*!*	  IF lcek > 0
*!*	    pesan = 'berhasil  '
*!*	  ELSE
*!*	    pesan =' gagal '
*!*	  endif
*!*	MESSAGEBOX(pesan +csql)


*!*	 csql="insert into anggota_mutasi (kantor,cif, jam,opt) value "+"('001','"+ALLTRIM(norek)+"','"+(jam)+ "','oke')"
*!*		        lcek=SQLEXEC(oODBC,csql)

*!*	 IF lcek > 0
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
*!*	tgljtempo ='2020-12-03'
*!*	xxtgl ='2020-01-29'
*!*	  

*!*	   IF tgljtempo > xxtgl
*!*				     MLEBIHJT = 0
*!*				 ELSE 
*!*				  	mtgljtempo=KRD.tgljtempo      
*!*					 IF XXTGL >= MTGLJTEMPO AND XXTGL <= MAJU1BLN(MTGLJTEMPO)
*!*					 	MLEBIHJT = 1
*!*					 ELSE 
*!*						 IF XXTGL <= MAJU1BLN(MAJU1BLN(MTGLJTEMPO))
*!*						 	MLEBIHJT = 2
*!*						 ELSE 
*!*						 	MLEBIHJT = 3
*!*						 ENDIF 
*!*					 ENDIF 
*!*				 ENDIF
*!*				 LEBIHJT=MLEBIHJT 
*!*				 
*!*				 
*!*				 ? tgljtempo
*!*				 ? xxtgl
*!*				 ? lebihjt