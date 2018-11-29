$PBExportHeader$w_post_platinum.srw
forward
global type w_post_platinum from w_ai_piped_sync
end type
type st_batch from statictext within w_post_platinum
end type
type st_batch_number from statictext within w_post_platinum
end type
type dw_list_of_headers from datawindow within w_post_platinum
end type
end forward

global type w_post_platinum from w_ai_piped_sync
int X=0
int Y=0
int Width=2939
int Height=1548
WindowType WindowType=main!
boolean TitleBar=true
string Title="Monitor's AP Posting Screen"
long BackColor=78682240
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event ue_getnumbers pbm_custom02
event ue_post pbm_custom03
event ue_cancel pbm_custom04
event ue_open2 pbm_custom05
st_batch st_batch
st_batch_number st_batch_number
dw_list_of_headers dw_list_of_headers
end type
global w_post_platinum w_post_platinum

type variables
INTEGER	ii_NextTrx
end variables

forward prototypes
public subroutine wf_update_numbers ()
end prototypes

on ue_getnumbers;call w_ai_piped_sync::ue_getnumbers;  SELECT	next_voucher
    INTO	:ii_NextTrx
    FROM	parameters  ;

wf_update_numbers ( )
end on

on ue_post;call w_ai_piped_sync::ue_post;INTEGER	i_TempBatch, &
			i_TempTrx, &
			i_Response

LONG		l_Row, &
		l_RowCount

STRING	s_TrxCtrlNumTemp, &
			s_TrxCtrlNum, &
			s_InvoiceNum, &
			s_VendorCode

//	Update header & detail records with new information.

l_Row = 0
dw_list_of_headers.AcceptText ( )
DO WHILE dw_list_of_headers.GetSelectedRow ( l_Row ) > 0
	l_Row = dw_list_of_headers.GetSelectedRow ( l_Row )
	s_TrxCtrlNumTemp = dw_list_of_headers.GetItemString ( l_Row, 'trx_ctrl_num', PRIMARY!, TRUE )
	s_TrxCtrlNum = dw_list_of_headers.GetItemString ( l_Row, 'trx_ctrl_num' )

	  UPDATE	exp_apdata_detail
	     SET	trx_ctrl_num = :s_TrxCtrlNum
	   WHERE	trx_ctrl_num = :s_TrxCtrlNumTemp  ;

	IF SQLCA.SQLCode <> 0 THEN
		MessageBox ( 'Warning', 'Unable to update detail records.~nProcess halted.' )
		Return
	END IF
LOOP
IF dw_list_of_headers.Update ( ) = -1 THEN
	MessageBox ( 'Warning', 'Unable to update header records.~nProcess halted.' )
	Rollback  ;
	Return
END IF

commit  ;

wf_execute_transaction ( 'APVoucher' )

l_Row = 0
l_RowCount = dw_list_of_headers.RowCount ( )

DO WHILE dw_list_of_headers.GetSelectedRow ( l_Row ) > 0
	l_Row = dw_list_of_headers.GetSelectedRow ( l_Row )
	s_VendorCode = dw_list_of_headers.GetItemString ( l_Row, 'vendor_code' )
	s_InvoiceNum = dw_list_of_headers.GetItemString ( l_Row, 'doc_ctrl_num' )
	s_TrxCtrlNum = dw_list_of_headers.GetItemString ( l_Row, 'trx_ctrl_num' )

	  UPDATE	audit_trail
	     SET	posted = 'Y'
	   WHERE	type = 'R' AND
				vendor = :s_VendorCode AND
				invoice_number = :s_InvoiceNum  ;

	  DELETE	FROM exp_apdata_detail
	   WHERE	trx_ctrl_num = :s_TrxCtrlNum  ;

	dw_list_of_headers.DeleteRow ( l_Row )
	l_Row --
LOOP

  UPDATE	parameters
     SET	next_voucher = next_voucher + :l_RowCount  ;

commit  ;

dw_list_of_headers.Update ( )
end on

on ue_cancel;call w_ai_piped_sync::ue_cancel;Close ( This )
end on

on ue_open2;call w_ai_piped_sync::ue_open2;dw_list_of_headers.Retrieve ( )
dw_list_of_headers.SelectRow ( 0, TRUE )
end on

public subroutine wf_update_numbers ();LONG	l_Row, &
		l_Count

l_Row = 0
l_Count = 0
DO WHILE dw_list_of_headers.GetSelectedRow ( l_Row ) > 0
	l_Row = dw_list_of_headers.GetSelectedRow ( l_Row )
	dw_list_of_headers.SetItem ( l_Row, 'trx_ctrl_num', String ( ii_NextTrx + l_Count ) )
	l_Count ++
LOOP
end subroutine

on resize;call w_ai_piped_sync::resize;This.Resize ( 2943, 1548 )
end on

on activate;call w_ai_piped_sync::activate;gnv_App.of_GetFrame().ChangeMenu ( m_post_platinum )
end on

on w_post_platinum.create
int iCurrent
call super::create
this.st_batch=create st_batch
this.st_batch_number=create st_batch_number
this.dw_list_of_headers=create dw_list_of_headers
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_batch
this.Control[iCurrent+2]=this.st_batch_number
this.Control[iCurrent+3]=this.dw_list_of_headers
end on

on w_post_platinum.destroy
call super::destroy
destroy(this.st_batch)
destroy(this.st_batch_number)
destroy(this.dw_list_of_headers)
end on

type dw_error from w_ai_piped_sync`dw_error within w_post_platinum
boolean Visible=false
end type

type cb_1 from w_ai_piped_sync`cb_1 within w_post_platinum
int TabOrder=60
boolean Visible=false
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
end type

type cb_2 from w_ai_piped_sync`cb_2 within w_post_platinum
int TabOrder=50
boolean Visible=false
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
end type

type cb_3 from w_ai_piped_sync`cb_3 within w_post_platinum
int TabOrder=70
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
end type

type st_1 from w_ai_piped_sync`st_1 within w_post_platinum
boolean Visible=false
long BackColor=78682240
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
end type

type dw_progress from w_ai_piped_sync`dw_progress within w_post_platinum
int X=311
int Y=1292
end type

type cb_4 from w_ai_piped_sync`cb_4 within w_post_platinum
int X=32
int Y=1296
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
end type

type st_5 from w_ai_piped_sync`st_5 within w_post_platinum
long TextColor=0
long BackColor=78682240
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
end type

type st_3 from w_ai_piped_sync`st_3 within w_post_platinum
long TextColor=0
long BackColor=78682240
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
end type

type st_2 from w_ai_piped_sync`st_2 within w_post_platinum
long TextColor=0
long BackColor=78682240
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
end type

type st_4 from w_ai_piped_sync`st_4 within w_post_platinum
long TextColor=0
long BackColor=78682240
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
end type

type st_batch from statictext within w_post_platinum
int X=37
int Y=36
int Width=549
int Height=72
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="Batch Number:"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=78682240
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_batch_number from statictext within w_post_platinum
int X=613
int Y=36
int Width=375
int Height=72
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="none"
boolean FocusRectangle=false
long BackColor=78682240
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_list_of_headers from datawindow within w_post_platinum
int X=37
int Y=228
int Width=1746
int Height=988
int TabOrder=40
string DataObject="d_list_of_export_headers"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

on constructor;SetTrans ( SQLCA )
end on

on doubleclicked;BOOLEAN 	b_Selected
LONG		l_Row

l_Row	= GetClickedRow()

If l_Row > 0 then
	b_Selected = IsSelected ( l_Row )
	SelectRow ( l_Row, NOT b_Selected )
END IF
end on

