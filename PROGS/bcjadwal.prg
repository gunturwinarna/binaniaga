

  bypokok = 0
          bybunga = 0
          mnorek=thisform.norek 
          csql="select norek,tglvaluta,tgllunas,pokok,jasa,sisapokok,sisabunga from pinjaman where norek='"+mnorek+"'"
		   lcek=SQLEXEC(oODBC,csql,"smt1")
		  * brow
		   xsisapokok = sisapokok
		   xsisabunga = sisabunga
		   xpokok = pokok
		   xjasa = jasa
           mcur=saldokrd(Norek,tglnow)
		   SELECT(mcur)
		   msisapk=sisapk
           msisabg=sisabg
		   xxpk =999999
		*USE

		   
		   csql="select SUM(pokok) AS byrpokok, SUM(jasa) AS byrjasa  from pinjaman_mutasi where norek='"+mnorek+"'"
		   lcek=SQLEXEC(oODBC,csql,"smt1")  
		   
		   ** kasus jika di pinjaman mutasi = 0 / belum ada pembayaran
		   csql="select pokok as xpk,jasa as xjs  from pinjaman_mutasi where norek='"+mnorek+"'"
		   lcek=SQLEXEC(oODBC,csql,"smt2") 
		   
		   
		   IF xpk <> 0
		      bypokok = byrpokok 
		      byjasa = byrjasa
		      ELSE
		      bypokok = 0
		      byjasa = 0
		   endif    
		    
	*	   MESSAGEBOX('nilai bypokok : '+TRANSFORM(bypokok,'999,999'))
		   
		   *------ lihat perhitungan
	*	     MESSAGEBOX('xpokok' +TRANSFORM(xpokok,'999,999,999')+ ' / bypokok/ '+TRANSFORM(bypokok,'999,999,999')  )
		   sldpokok = xpokok - bypokok
		   sldjasa = xjasa-byjasa 
	*	    MESSAGEBOX('sldpokok' +TRANSFORM(sldpokok,'999,999,999')+ ' / sldjasa/ '+TRANSFORM(sldjasa,'999,999,999')  )
		   IF lcek<1
		      MESSAGEBOX(csql)
		   ENDIF 
	*	   MESSAGEBOX('msisapk' +TRANSFORM(msisapk,'999,999,999')+ ' / sldpokok/ '+TRANSFORM(xsisapokok,'999,999,999')  )
*!*	             IF (msisapk <> sldpokok) OR (msisabg <> sldjasa)

               IF (msisapk <> xsisapokok)
		         csql="update pinjaman set sisapokok='"+TRANSFORM(sldpokok,'999999999999999')+"',sisabunga='"+TRANSFORM(sldjasa,'999999999999999')+"' where norek='"+mnorek+"'"
		        
		         lcek=SQLEXEC(oOdbc,csql)
		         IF lcek < 1
		          
		            MESSAGEBOX('gagal :'+csql)
		         endif
		      ENDIF

    
		   
ENDIF
 
MESSAGEBOX("Proses Hitung Ulang sudah Selesai",64,"")
thisform.Release 