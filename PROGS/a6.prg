           mcif='00527'
           mtgl=ctod('31-12-2016')
           mtgltab1=CTOD('31-07-2016')
           mtabungan1=0
	mtabungan2=0
	csql="select norek,jenis,produk from simpanan where cif=?mcif"
	lcek=SQLEXEC(oODBC,csql,"smt")
	DO WHILE !EOF()
	   mnorek=norek
	   csql="select tanggal,debet, kredit, saldo from simpanan_mutasi where norek='"+mnorek+"' and "+;
	        "tanggal>='"+sqldate(awalthn(mtgl))+"' and tanggal<='"+sqldate(mtgl)+"'"+;
	        " order by tanggal"
	   lcek=SQLEXEC(oodbc,csql,"smt1")
	   GO BOTTOM 
	   msaldo=saldo
	   SUM debet FOR  tanggal<=mtgltab1 TO ambil
	   mtabungan1=mtabungan1+ambil
	   mtabungan2=mtabungan2+msaldo
	   SELECT smt
	   SKIP 
	   
	ENDDO 
	MESSAGEBOX(mtabungan1)
	MESSAGEBOX(mtabungan2)