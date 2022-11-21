* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
*  FileName A4.PRG <-- This file create by UnFoxAll
* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


 LOCAL OFORM
 OFORM = CREATEOBJECT('Tform')
  OFORM.SHOW(1)

PROCEDURE buf2dword
 LPARAMETER LCBUFFER
 RETURN ASC(SUBSTR(LCBUFFER,1,1)) + BITLSHIFT(ASC(SUBSTR(LCBUFFER,2,1)),8) +  ;
BITLSHIFT(ASC(SUBSTR(LCBUFFER,3,1)),16) + BITLSHIFT(ASC(SUBSTR(LCBUFFER,4,1)),24)
ENDPROC
*------
DEFINE CLASS Tform AS Form
 WIDTH = 340
 HEIGHT = 310
 AUTOCENTER = .T.
 CAPTION = 'Using Video Capture'
 MINBUTTON = .F.
 MAXBUTTON = .F.
 HWINDOW = 0
 HCAPTURE = 0
 CAPWIDTH = 0
 CAPHEIGHT = 0
 CAPOVERLAY = 0
 ADD OBJECT CMDGETFRAME AS COMMANDBUTTON WITH DEFAULT = .T. , LEFT = 15 , TOP = 264 ,  ;
      HEIGHT = 27 , WIDTH = 90 , CAPTION = 'Get Frame' , ENABLED = .F.
 ADD OBJECT CMDPREVIEW AS COMMANDBUTTON WITH DEFAULT = .T. , LEFT = 106 , TOP = 264 ,  ;
      HEIGHT = 27 , WIDTH = 100 , CAPTION = 'Preview Video' , ENABLED = .F.
 ADD OBJECT CMDCLOSE AS COMMANDBUTTON WITH CANCEL = .T. , LEFT = 250 , TOP = 264 ,  ;
      HEIGHT = 27 , WIDTH = 70 , CAPTION = 'Close'

PROCEDURE Activate
 IF THIS.HWINDOW = 0
 DECLARE INTEGER GetFocus IN user32
 THIS.HWINDOW = GETFOCUS()
  THIS.CREATECAPTUREWINDOW
  THIS.DRIVERCONNECT
 ENDIF 
ENDPROC
*------ 

PROCEDURE Destroy
  THIS.RELEASECAPTUREWINDOW
ENDPROC
*------ 

PROCEDURE cmdClose.Click
  THISFORM.RELEASE
ENDPROC
*------ 

PROCEDURE cmdGetFrame.Click
  THISFORM.GETFRAME
ENDPROC
*------ 

PROCEDURE cmdPreview.Click
  THISFORM.STARTPREVIEW
ENDPROC
*------ 

PROCEDURE GetFrame
  THIS.MSG(1084,0,0)
ENDPROC
*------ 

PROCEDURE CreateCaptureWindow
 DECLARE INTEGER capCreateCaptureWindow IN avicap32 STRING , LONG , INTEGER , INTEGER ,  ;
      INTEGER , INTEGER , INTEGER , INTEGER 
 THIS.HCAPTURE =  ;
      CAPCREATECAPTUREWINDOW('',1342177280,10,8,320,240,THIS.HWINDOW,1)
ENDPROC
*------ 

PROCEDURE DriverConnect
  THIS.MSG(1034,0,0)
 IF THIS.ISCAPTURECONNECTED()
  THIS.GETCAPTUREDIMENSIONS
 STORE .T. TO THIS.CMDGETFRAME.ENABLED , THIS.CMDPREVIEW.ENABLED
 THIS.CAPTION =  ;
      THIS.CAPTION + ': connected, ' + LTRIM(STR(THIS.CAPWIDTH)) + 'x' +  ;
LTRIM(STR(THIS.CAPHEIGHT))
 ELSE 
 THIS.CAPTION = THIS.CAPTION + ': failed to connect'
 ENDIF 
ENDPROC
*------ 

PROCEDURE DriverDisconnect
  THIS.MSG(1035,0,0)
ENDPROC
*------ 

PROCEDURE ReleaseCaptureWindow
 IF THIS.HCAPTURE <> 0
  THIS.DRIVERDISCONNECT
 DECLARE INTEGER DestroyWindow IN user32 INTEGER 
 = DESTROYWINDOW(THIS.HCAPTURE)
 THIS.HCAPTURE = 0
 ENDIF 
ENDPROC
*------ 

PROCEDURE msg
 LPARAMETER MSG , WPARAM , LPARAM , NMODE
 IF THIS.HCAPTURE = 0
 RETURN 
 ENDIF 
 IF VARTYPE(NMODE) <> 'N' .OR. NMODE = 0
 DECLARE INTEGER SendMessage IN user32 INTEGER , INTEGER , INTEGER , INTEGER 
 = SENDMESSAGE(THIS.HCAPTURE,MSG,WPARAM,LPARAM)
 ELSE 
 DECLARE INTEGER SendMessage IN user32 INTEGER , INTEGER , INTEGER , STRING @
 = SENDMESSAGE(THIS.HCAPTURE,MSG,WPARAM,@LPARAM)
 ENDIF 
ENDPROC
*------ 

PROCEDURE IsCaptureConnected
 LOCAL CBUFFER , NRESULT
 CBUFFER = REPLICATE(CHR(0),44)
  THIS.MSG(1038,LEN(CBUFFER),@CBUFFER,1)
 THIS.CAPOVERLAY = BUF2DWORD(SUBSTR(CBUFFER,5,4))
 NRESULT = ASC(SUBSTR(CBUFFER,21,1))
 RETURN (NRESULT <> 0)
ENDPROC
*------ 

PROCEDURE GetCaptureDimensions
 LOCAL CBUFFER
 CBUFFER = REPLICATE(CHR(0),76)
  THIS.MSG(1078,LEN(CBUFFER),@CBUFFER,1)
 THIS.CAPWIDTH = BUF2DWORD(SUBSTR(CBUFFER,1,4))
 THIS.CAPHEIGHT = BUF2DWORD(SUBSTR(CBUFFER,5,4))
ENDPROC
*------ 

PROCEDURE StartPreview
  THIS.MSG(1076,30,0)
  THIS.MSG(1074,1,0)
 IF THIS.CAPOVERLAY <> 0
  THIS.MSG(1075,1,0)
 ENDIF 
ENDPROC
*------ 

PROCEDURE StopPreview
  THIS.MSG(1074,0,0)
ENDPROC
*------ 
ENDDEFINE
*------*