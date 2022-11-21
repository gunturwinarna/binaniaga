DO whil !EOF()
      n=INKEY(0)
      IF LASTKEY()=27
           EXIT
      ENDIF 
      MESSAGEBOX(n)
  ENDDO 