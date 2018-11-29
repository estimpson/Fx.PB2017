$PBExportHeader$w_ai_ar_platinum.srw
forward
global type w_ai_ar_platinum from w_ai_piped_sync
end type
type st_interface_name from statictext within w_ai_ar_platinum
end type
type dw_1 from datawindow within w_ai_ar_platinum
end type
end forward

global type w_ai_ar_platinum from w_ai_piped_sync
int X=1
int Y=1
int Width=2926
int Height=1581
event ue_open2 pbm_custom02
event ue_post pbm_custom03
event ue_cancel pbm_custom04
st_interface_name st_interface_name
dw_1 dw_1
end type
global w_ai_ar_platinum w_ai_ar_platinum

on ue_open2;call w_ai_piped_sync::ue_open2;  SELECT accounting_type
    INTO	:st_interface_name.text
    FROM	parameters  ;

dw_1.Retrieve ( )
end on

on ue_post;call w_ai_piped_sync::ue_post;LONG	l_Row

IF dw_1.Update ( ) = -1 THEN
	MessageBox ( 'Warning', 'Unable to update Shipper table.~nPosting aborted.' )
	Return
END IF

wf_execute_transaction ( 'ARInvoice' )

FOR l_Row = 1 TO dw_1.RowCount ( )
	IF dw_1.GetItemString ( l_Row, 'posted' ) = 'R' THEN
		dw_1.SetItem ( l_Row, 'posted', 'Y' )
	END IF
	dw_1.Update ( )
	dw_1.Retrieve ( )
NEXT
end on

on ue_cancel;call w_ai_piped_sync::ue_cancel;Close ( This )
end on

on activate;call w_ai_piped_sync::activate;gnv_App.of_GetFrame().ChangeMenu ( m_ai_ar_platinum )
end on

on resize;call w_ai_piped_sync::resize;Resize ( 2943, 1548 )
end on

on w_ai_ar_platinum.create
int iCurrent
call w_ai_piped_sync::create
this.st_interface_name=create st_interface_name
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=st_interface_name
this.Control[iCurrent+2]=dw_1
end on

on w_ai_ar_platinum.destroy
call w_ai_piped_sync::destroy
destroy(this.st_interface_name)
destroy(this.dw_1)
end on

type dw_error from w_ai_piped_sync`dw_error within w_ai_ar_platinum
int TabOrder=20
boolean Visible=false
end type

type cb_1 from w_ai_piped_sync`cb_1 within w_ai_ar_platinum
boolean Visible=false
end type

type cb_2 from w_ai_piped_sync`cb_2 within w_ai_ar_platinum
boolean Visible=false
end type

type st_1 from w_ai_piped_sync`st_1 within w_ai_ar_platinum
int X=1
int Y=113
int Width=2931
string Text="Invoice Posting"
end type

type dw_progress from w_ai_piped_sync`dw_progress within w_ai_ar_platinum
int X=1
int Y=1373
int TabOrder=0
end type

type cb_4 from w_ai_piped_sync`cb_4 within w_ai_ar_platinum
int X=1084
int Y=1377
int TabOrder=10
end type

type st_5 from w_ai_piped_sync`st_5 within w_ai_ar_platinum
int X=805
int Y=1389
end type

type st_3 from w_ai_piped_sync`st_3 within w_ai_ar_platinum
int X=906
int Y=1401
end type

type st_2 from w_ai_piped_sync`st_2 within w_ai_ar_platinum
int X=814
int Y=1401
end type

type st_4 from w_ai_piped_sync`st_4 within w_ai_ar_platinum
int X=970
int Y=1401
end type

type st_interface_name from statictext within w_ai_ar_platinum
int X=33
int Y=21
int Width=513
int Height=61
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="none"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_1 from datawindow within w_ai_ar_platinum
int X=19
int Y=209
int Width=2871
int Height=1133
int TabOrder=30
string DataObject="dw_list_of_unposted_invoices"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

on clicked;LONG	l_Row

l_Row = GetClickedRow ( )

IF l_Row > 0 THEN
	SetItem ( l_Row, 'posted', 'R' )
END IF
end on

on constructor;SetTransObject ( SQLCA )
end on

