* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
*  FileName A1.PRG <-- This file create by UnFoxAll
* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


 PUBLIC OFRMLISTEXAMPLES
 OFRMLISTEXAMPLES = NEWOBJECT('frmListExamples')
  OFRMLISTEXAMPLES.SHOW
 RETURN 

DEFINE CLASS frmListExamples AS form
 DATASESSION = 2
 TOP = 0
 LEFT = 0
 HEIGHT = 262
 WIDTH = 325
 CAPTION = 'List and ListItem Array Example'
 NAME = 'frmListExamples'
 ADD OBJECT SHAPE1 AS SHAPE WITH TOP = 43 , LEFT = 32 , HEIGHT = 76 , WIDTH = 261 ,  ;
      SPECIALEFFECT = 0 , NAME = 'Shape1'
 ADD OBJECT CBOLISTBAD AS COMBOBOX WITH COLUMNCOUNT = 3 , COLUMNWIDTHS = '100,100,50' ,  ;
      HEIGHT = 22 , LEFT = 111 , SORTED = .T. , STYLE = 2 , TABINDEX = 1 ,  ;
      TOP = 53 , WIDTH = 147 , NAME = 'cboListBad'
 ADD OBJECT CBOLISTITEM AS COMBOBOX WITH COLUMNCOUNT = 3 , COLUMNWIDTHS =  ;
      '100,100,50' , LEFT = 34 , SORTED = .T. , STYLE = 2 , TABINDEX = 3 , TOP = 154 ,  ;
      NAME = 'cboListItem'
 ADD OBJECT LABEL1 AS LABEL WITH FONTBOLD = .T. , CAPTION = 'Using the List Array:' ,  ;
      HEIGHT = 17 , LEFT = 34 , TOP = 24 , WIDTH = 176 , TABINDEX = 7 ,  ;
      NAME = 'Label1'
 ADD OBJECT LABEL2 AS LABEL WITH FONTBOLD = .T. , CAPTION =  ;
      'Using the ListItem Array:' , HEIGHT = 17 , LEFT = 34 , TOP = 135 , WIDTH = 173 , TABINDEX = 8 ,  ;
      NAME = 'Label2'
 ADD OBJECT CBOLISTGOOD AS COMBOBOX WITH COLUMNCOUNT = 3 , COLUMNWIDTHS =  ;
      '100,100,50' , HEIGHT = 22 , LEFT = 111 , SORTED = .T. , STYLE = 2 , TABINDEX = 2 ,  ;
      TOP = 86 , WIDTH = 147 , NAME = 'cboListGood'
 ADD OBJECT LABEL3 AS LABEL WITH ALIGNMENT = 1 , CAPTION = 'Wrong!' , HEIGHT = 17 ,  ;
      LEFT = 51 , TOP = 56 , WIDTH = 47 , TABINDEX = 9 , NAME = 'Label3'
 ADD OBJECT LABEL4 AS LABEL WITH ALIGNMENT = 1 , CAPTION = 'Right!' , HEIGHT = 17 ,  ;
      LEFT = 58 , TOP = 89 , WIDTH = 40 , TABINDEX = 10 , NAME = 'Label4'

PROCEDURE cbolistbad.Init
&&----No event!
ENDPROC 

PROCEDURE cbolistgood.Init
&&----No event!
ENDPROC 

PROCEDURE cbolistitem.Init
 WITH THIS  
  .ADDLISTITEM('Cleveland')
  .ADDLISTITEM('Ohio',.NEWITEMID,2)
  .ADDLISTITEM('44122',.NEWITEMID,3)
  .ADDLISTITEM('Caversham')
  .ADDLISTITEM('England',.NEWITEMID,2)
  .ADDLISTITEM('RG4 8BX',.NEWITEMID,3)
  .ADDLISTITEM('Buffalo')
  .ADDLISTITEM('New York',.NEWITEMID,2)
  .ADDLISTITEM('14228',.NEWITEMID,3)
  .ADDLISTITEM('Milwaukee')
  .ADDLISTITEM('Wisconsin',.NEWITEMID,2)
  .ADDLISTITEM('43225',.NEWITEMID,3)
  .ADDLISTITEM('International Falls')
  .ADDLISTITEM('Minnesota',.NEWITEMID,2)
  .ADDLISTITEM('42666',.NEWITEMID,3)
 ENDWITH 
ENDPROC
*------ 
ENDDEFINE
*------*
