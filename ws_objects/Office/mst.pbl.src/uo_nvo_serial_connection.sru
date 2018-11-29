$PBExportHeader$uo_nvo_serial_connection.sru
forward
global type uo_nvo_serial_connection from nonvisualobject
end type
end forward

type comstat from structure
    character bits
    integer cbinque
    integer cboutque
end type

type dcb from structure
    character id
    integer baudrate
    character bytesize
    character parity
    character stopbits
    integer rlstimeout
    integer ctstimeout
    integer dsrtimeout
    character bits1
    character bits2
    character xonchar
    character xoffchar
    integer xonlim
    integer xofflim
    character pechar
    character eofchar
    character evtchar
    integer txdelay
end type

global type uo_nvo_serial_connection from nonvisualobject
end type
global uo_nvo_serial_connection uo_nvo_serial_connection

type prototypes
FUNCTION int OpenComm(string IpcomName,int wInQue, int wOutQue) &
LIBRARY "USER.EXE" alias for "OpenComm;Ansi"
FUNCTION int ReadComm(int nCid,REF string Inbuff, int nSize)&
LIBRARY "USER.exe" alias for "ReadComm;Ansi"
FUNCTION int GetCommError(int nCid,REF comstat CommSt) LIBRARY "USER.EXE" alias for "GetCommError;Ansi"
FUNCTION int CloseComm(int nCid) LIBRARY "USER.EXE"
FUNCTION int EnableCommNotification(int nCid,uint hWnd, int InNote,&
int OutNote) LIBRARY "USER.EXE"
FUNCTION int GetCommEventMask(int nCid,int nEvtMask) LIBRARY "USER.EXE"
FUNCTION long SetCommEventMask(int nCid,int nEvtMask) LIBRARY "USER.EXE"
FUNCTION int GetCommState(int nCid, REF dcb lpDCB) LIBRARY "USER.EXE" alias for "GetCommState;Ansi"
FUNCTION int SetCommState(dcb lpDCB) LIBRARY "USER.EXE" alias for "SetCommState;Ansi"
FUNCTION int FlushComm(int nCid, int Queue) LIBRARY "USER.EXE"
FUNCTION int WriteComm(int nCid,string outbuf,int outlen) LIBRARY "USER.EXE" alias for "WriteComm;Ansi"

end prototypes

type variables
int		ii_commid,&
		ii_wordlength,&
		ii_parity
long		il_baudrate
string		is_comport

end variables

forward prototypes
public function string uf_read_port ()
public function integer uf_open_port (window win, integer trigsize, string szcomport, long al_baud_rate, integer ai_word_length, integer ai_parity)
public function integer uf_setup (boolean ab_mode, window aw_parent, string as_comport, long al_baud_rate, integer ai_word_length, integer ai_parity)
end prototypes

public function string uf_read_port ();int 		CharCount,CharRead,LoopCount,EventMask
string 	InBuff,RetString
comstat 	comstat1

GetCommError(ii_CommId,comstat1)

CharCount = ComStat1.CbInQue

InBuff=SPACE(CharCount)

CharRead = ReadComm(ii_CommId,InBuff,CharCount)

return inbuff
end function

public function integer uf_open_port (window win, integer trigsize, string szcomport, long al_baud_rate, integer ai_word_length, integer ai_parity);dcb dcb1

ii_CommId=OpenComm(szComPort,512,512)
IF ii_CommId<0 THEN
	MessageBox("OPEN PORT","OpenComm Failure")
	RETURN -1
END IF

IF (EnableCommNotification(ii_CommId,Handle(win),TrigSize,-1) = 0) THEN
	MessageBox("OPEN PORT","EnableCommNotification Failed")
	RETURN -1
END IF

SetCommEventMask(ii_CommId,0)

IF (GetCommState(ii_CommId,dcb1) <> 0) THEN

	MessageBox("OPEN PORT","GET COMM STATE FAILED")
	RETURN -1	
	
END IF

dcb1.BaudRate=al_baud_rate      		// Set baud
dcb1.bits2=CharA(3) 						// set xon/xoff
dcb1.ByteSize=CharA(ai_word_length)	// Set Word len
dcb1.Parity=CharA(ai_parity) 						//	Set PARITY

IF (SetCommState(dcb1) <>0 ) THEN
	MessageBox("OPEN PORT","ERROR SETTING COMM STATE")
	Return -1
END IF 

RETURN 0
end function

public function integer uf_setup (boolean ab_mode, window aw_parent, string as_comport, long al_baud_rate, integer ai_word_length, integer ai_parity);if ab_mode then
	Return uf_open_port ( aw_parent, 1, "COM" + as_comport, al_baud_rate, ai_word_length, ai_parity )
else
	CloseComm ( ii_commid )
	Return 0
end if
end function

on destructor;CloseComm ( ii_CommId )
end on

on uo_nvo_serial_connection.create
TriggerEvent( this, "constructor" )
end on

on uo_nvo_serial_connection.destroy
TriggerEvent( this, "destructor" )
end on

