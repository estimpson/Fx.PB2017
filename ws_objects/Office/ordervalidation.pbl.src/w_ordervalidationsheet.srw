$PBExportHeader$w_ordervalidationsheet.srw
forward
global type w_ordervalidationsheet from Window
end type
type st_3 from statictext within w_ordervalidationsheet
end type
type st_2 from statictext within w_ordervalidationsheet
end type
type cb_1 from commandbutton within w_ordervalidationsheet
end type
type cb_insert from commandbutton within w_ordervalidationsheet
end type
type dw_orders from datawindow within w_ordervalidationsheet
end type
type st_1 from statictext within w_ordervalidationsheet
end type
type sle_password from singlelineedit within w_ordervalidationsheet
end type
type cb_update from commandbutton within w_ordervalidationsheet
end type
type dw_order_releases from u_dw_ordervalidation within w_ordervalidationsheet
end type
end forward

type st_release_data from structure
	decimal {0}	order_no
	string		destination
	string		customer_part
	decimal {6}	our_cum
	decimal {6}	their_cum
	datetime		our_shipped_date
	datetime		their_shipped_date
	decimal {6}	our_shipped
	decimal {6}	their_shipped
	datetime		order_date
	string		part_number
	string		release_type
	datetime		due_date
	integer		sequence
	decimal {6}	old_quantity
	decimal {6}	quantity
	string		checked
	string		status
	string		notes
	datetime		review_date
	string		reviewed_by
end type

global type w_ordervalidationsheet from Window
int X=23
int Y=36
int Width=3273
int Height=1996
long BackColor=78682240
WindowState WindowState=maximized!
WindowType WindowType=child!
event ue_previousorder ( )
event ue_previousdiscrepency ( )
event ue_nextorder ( )
event ue_nextdiscrepency ( )
st_3 st_3
st_2 st_2
cb_1 cb_1
cb_insert cb_insert
dw_orders dw_orders
st_1 st_1
sle_password sle_password
cb_update cb_update
dw_order_releases dw_order_releases
end type
global w_ordervalidationsheet w_ordervalidationsheet

type variables
datetime	idt_OrderSchedule

long	il_CurrentRow = 1
long	il_CurrentOrder
long	il_OrderRows

string	is_SalesRep
string	is_Operator

DataStore	ids_orderdata

DataWindowChild	ldwc_orders
end variables

event ue_previousorder;//  Scroll to previous page.
dw_order_releases.ScrollPriorPage ( )
end event

event ue_previousdiscrepency;//  Scroll to the previous selected row [discrepency].
//  Declarations.
CONSTANT INTEGER	yes = 1
CONSTANT INTEGER	no = 2
INTEGER	li_response

LONG	ll_nextselected

//  Get the previous selected row and assign it to current row.
ll_nextselected = dw_order_releases.GetPreviousSelectedRow ( il_currentrow )

//  If no more selected rows, ask to return to first selected.
IF ll_nextselected = 0 THEN
	li_response = MessageBox ( monsys.msg_title, "No more discrepencies, wrap from the end?", question!, yesno! )
	IF li_response = yes THEN
		ll_nextselected = dw_order_releases.GetPreviousSelectedRow ( 0 )
		IF ll_nextselected = 0 THEN
			MessageBox ( monsys.msg_title, "No more discrepecies in releases." )
		ELSE
			il_currentrow = ll_nextselected
		END IF
	END IF
ELSE
	il_currentrow = ll_nextselected
END IF

//  Scroll to current row.
dw_order_releases.ScrollToRow ( il_currentrow )
end event

event ue_nextorder;//  Scroll to next page.
dw_order_releases.ScrollNextPage ( )
end event

event ue_nextdiscrepency;//  Scroll to the next selected row [discrepency].
//  Declarations.
CONSTANT INTEGER	yes = 1
CONSTANT INTEGER	no = 2
INTEGER	li_response

LONG	ll_nextselected

//  Get the next selected row and assign it to current row.
ll_nextselected = dw_order_releases.GetSelectedRow ( il_currentrow )

//  If no more selected rows, ask to return to first selected.
IF ll_nextselected = 0 THEN
	li_response = MessageBox ( monsys.msg_title, "No more discrepencies, return to first?", question!, yesno! )
	IF li_response = yes THEN
		ll_nextselected = dw_order_releases.GetSelectedRow ( 0 )
		IF ll_nextselected = 0 THEN
			MessageBox ( monsys.msg_title, "No more discrepecies in releases." )
		ELSE
			il_currentrow = ll_nextselected
		END IF
	END IF
ELSE
	il_currentrow = ll_nextselected
END IF

//  Scroll to current row.
dw_order_releases.ScrollToRow ( il_currentrow )
end event

on w_ordervalidationsheet.create
this.st_3=create st_3
this.st_2=create st_2
this.cb_1=create cb_1
this.cb_insert=create cb_insert
this.dw_orders=create dw_orders
this.st_1=create st_1
this.sle_password=create sle_password
this.cb_update=create cb_update
this.dw_order_releases=create dw_order_releases
this.Control[]={this.st_3,&
this.st_2,&
this.cb_1,&
this.cb_insert,&
this.dw_orders,&
this.st_1,&
this.sle_password,&
this.cb_update,&
this.dw_order_releases}
end on

on w_ordervalidationsheet.destroy
destroy(this.st_3)
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.cb_insert)
destroy(this.dw_orders)
destroy(this.st_1)
destroy(this.sle_password)
destroy(this.cb_update)
destroy(this.dw_order_releases)
end on

event resize;dw_order_releases.Resize ( newwidth, newheight - dw_order_releases.y )
end event

type st_3 from statictext within w_ordervalidationsheet
int X=1431
int Y=96
int Width=274
int Height=68
boolean Visible=false
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="4"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_ordervalidationsheet
int X=1435
int Y=16
int Width=274
int Height=76
boolean Visible=false
boolean Enabled=false
string Text="Undo Timer:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_ordervalidationsheet
int X=1065
int Y=8
int Width=302
int Height=240
int TabOrder=30
boolean Visible=false
string Text="Undo"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_insert from commandbutton within w_ordervalidationsheet
int X=2743
int Y=96
int Width=407
int Height=84
int TabOrder=20
boolean Enabled=false
string Text="&Insert Release"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//	Declarations.
long	ll_FirstRowOnPage
long	ll_CurrentRow

//	Initialize
ll_FirstRowOnPage = Long ( dw_order_releases.object.datawindow.FirstRowOnPage )
ll_CurrentRow = dw_order_releases.GetRow ( )

//	Open popup to create new release.
OpenWithParm ( w_newreleasepopup, il_currentorder )

//	If new release was created, then refresh releases.
if message.DoubleParm = 0 then
	ldwc_orders.Retrieve ( is_SalesRep )
	dw_order_releases.Retrieve ( il_CurrentOrder )
	dw_order_releases.ScrollToRow ( ll_FirstRowOnPage )
	dw_order_releases.SetRow ( ll_CurrentRow )
end if
end event

type dw_orders from datawindow within w_ordervalidationsheet
int X=14
int Y=12
int Width=855
int Height=180
int TabOrder=30
string DataObject="d_orderselection"
boolean Border=false
end type

event constructor;SetTransObject ( SQLCA )

if GetChild ( "order_no", ldwc_Orders ) = 1 then
	ldwc_Orders.InsertRow ( 0 )
	ldwc_Orders.SetTransObject ( SQLCA )
end if
Retrieve ( )
SQLCA.of_Commit ( )
end event

event itemchanged;AcceptText ( )
if row > 0 then
	if dwo.id = '1' then
		is_salesrep = data
		ldwc_Orders.Retrieve ( is_salesrep )
		sle_password.enabled = false
		dw_order_releases.Retrieve ( 0 )
		Object.order_no.TabSequence = 20
	elseif dwo.id = '2' then
		il_CurrentOrder = object.order_no [ row ]
		
		dw_order_releases.Retrieve ( il_CurrentOrder )
		
		if il_OrderRows > 0 then
			idt_OrderSchedule = dw_order_releases.object.order_date [ 1 ]
		end if
	end if
end if

SQLCA.of_Commit ( )

//	Clear the operator password, disable update button, and disable this control.
sle_password.text = ''
cb_update.enabled = false
cb_insert.enabled = false
dw_order_releases.enabled = false
end event

type st_1 from statictext within w_ordervalidationsheet
int X=1929
int Y=16
int Width=311
int Height=76
boolean Enabled=false
string Text="Reviewed By:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_password from singlelineedit within w_ordervalidationsheet
int X=2258
int Y=12
int Width=439
int Height=68
int TabOrder=10
boolean Enabled=false
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean PassWord=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;long	ll_RowCount

DataStore	lds_GetOperator

if text > '' then
	//	Validate operator password.
	lds_GetOperator = create DataStore
	lds_GetOperator.DataObject = 'd_getoperator'
	lds_GetOperator.SetTransObject ( SQLCA )
	if lds_GetOperator.Retrieve ( text ) > 0 then
		//	Set operator code on rows in current order.
		is_operator = lds_GetOperator.object.operator_code [ 1 ]
		cb_update.enabled = true
		cb_insert.enabled = true
		dw_order_releases.enabled = true
		for ll_RowCount = 1 to il_OrderRows
			dw_order_releases.object.reviewed_by [ ll_RowCount ] = is_operator
		next
	end if
	destroy lds_GetOperator
end if

SQLCA.of_Commit ( )
end event

type cb_update from commandbutton within w_ordervalidationsheet
int X=2743
int Y=4
int Width=407
int Height=84
int TabOrder=40
boolean Enabled=false
string Text="&Update Order"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//  Declarations.
DataStore	lds_SetReviewByDate

//	Transfer releases.
if SQLCA.of_TransferInsertedRelease ( il_CurrentOrder ) = 0 then
	lds_SetReviewByDate = create DataStore
	lds_SetReviewByDate.DataObject = 'd_setreviewbydate'
	lds_SetReviewByDate.SetTransObject ( SQLCA )
	if lds_SetReviewByDate.Retrieve ( il_CurrentOrder, Date ( idt_OrderSchedule ) ) = 1 then
		lds_SetReviewByDate.object.reviewed_by [ 1 ] = is_operator
		lds_SetReviewByDate.object.review_date [ 1 ] = Today ( )
		if lds_SetReviewByDate.Update ( ) = 1 then
			SQLCA.of_commit ( )
		else
			SQLCA.of_rollback ( )
		end if
	else
		SQLCA.of_rollback ( )
	end if
	destroy lds_SetReviewByDate
else
	SQLCA.of_rollback ( )
end if

ldwc_orders.Retrieve ( is_SalesRep )
dw_order_releases.Retrieve ( il_CurrentOrder )

//	Clear the operator password, disable update button, and disable this control.
sle_password.text = ''
cb_update.enabled = false
cb_insert.enabled = false
dw_order_releases.enabled = false
end event

type dw_order_releases from u_dw_ordervalidation within w_ordervalidationsheet
event ue_constructed ( )
int X=9
int Y=220
int Width=3141
int Height=1720
int TabOrder=50
string DataObject="d_order_validationnormal"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean VScrollBar=true
end type

event ue_constructed;SetTransObject ( SQLCA )
end event

event constructor;POST EVENT ue_constructed ( )
end event

event editchanged;object.checked [ row ] = 'Y'
end event

event itemchanged;//  Update releases from EDI data.

//  Declarations.
constant string	MESSAGE862 = '862-Release created thru stored procedure'
constant string MESSAGE830 = '830-Release created thru stored procedure'

string	ls_Note

long	ll_FirstRowOnPage

st_release_data	lst_ReleaseCurr [ 1 ]
st_release_data	lst_ReleaseOrig [ 1 ]

//	Ensure valid row was modified.
if row = 0 then return

//	If anything other than the quantity was modified return
if Integer ( dwo.ID ) <> 16 then return

//  Initialization.
AcceptText ( )
ll_FirstRowOnPage = Long ( object.datawindow.FirstRowOnPage )

//  Modified inserted releases.
lst_ReleaseCurr = object.data.current [ row ]
//  Original inserted releases.
lst_ReleaseOrig = object.data.original [ row ]

//  Check if inserted release was modified.
if lst_ReleaseCurr [ 1 ].checked = 'Y' then
	//  if original quantity was zero, this is a new inserted release.
	if IsNull ( lst_ReleaseOrig [ 1 ].quantity, 0 ) = 0 then
		//  As long as new quantity is more than zero, create new inserted release for this order, date, and quantity.
		if lst_ReleaseCurr [ 1 ].quantity > 0 then
			//  Assign appropriate note.
			choose case lst_ReleaseCurr [ 1 ].notes
				case '862'
					ls_Note = MESSAGE862
				case '830'
					ls_Note = MESSAGE830
				case else
					ls_Note = ""
			end choose
			choose case SQLCA.of_CreateInsertedRelease ( il_CurrentOrder, lst_ReleaseCurr [ 1 ].due_date, lst_ReleaseCurr [ 1 ].quantity, lst_ReleaseCurr [ 1 ].release_type, ls_Note, lst_ReleaseCurr [ 1 ].status  )
				case 0
					SQLCA.of_Commit ( )
				case 100
					SQLCA.of_Rollback ( )
					MessageBox ( monsys.msg_title, 'Order not found.' )
				case -1
					SQLCA.of_Rollback ( )
					MessageBox ( monsys.msg_title, 'Error adding release.' )
			end choose
		end if
	//  Otherwise, if current quantity is zero, delete this inserted release.
	elseif lst_ReleaseCurr [ 1 ].quantity = 0 then
		choose case SQLCA.of_RemoveInsertedRelease ( il_CurrentOrder, lst_ReleaseCurr [ 1 ].sequence )
			case 0
				SQLCA.of_Commit ( )
			case 100
				SQLCA.of_Rollback ( )
				MessageBox ( monsys.msg_title, 'Release not found.' )
			case -1
				SQLCA.of_Rollback ( )
				MessageBox ( monsys.msg_title, 'Error removing release.' )
		end choose
	//  Otherwise, update the quantity of this inserted release.
	else
		choose case SQLCA.of_UpdateInsertedRelease ( il_CurrentOrder, lst_ReleaseCurr [ 1 ].sequence, lst_ReleaseCurr [ 1 ].quantity )
			case 0
				SQLCA.of_Commit ( )
			case 100
				SQLCA.of_Rollback ( )
				MessageBox ( monsys.msg_title, 'Release not found.' )
			case -1
				SQLCA.of_Rollback ( )
				MessageBox ( monsys.msg_title, 'Error updating release.' )
		end choose
	end if
end if

ldwc_orders.Retrieve ( is_SalesRep )
Retrieve ( il_CurrentOrder )
SetRedraw ( false )
ScrollToRow ( ll_FirstRowOnPage )
//post SetRow ( row )
SetRedraw ( true )

end event

event retrieveend;string	ls_matches [ ]
long	ll_counter

il_OrderRows = rowcount

if il_OrderRows > 0 then
	ls_matches = object.matched.primary
	sle_password.enabled = true
else
	sle_password.enabled = false
end if

for ll_counter = 1 to rowcount
	if ls_matches [ ll_counter ] = 'N' then
		SelectRow ( ll_counter, true )
	end if
next

SetRedraw ( true )
SQLCA.of_Commit ( )
end event

event rowfocuschanged;il_CurrentRow = currentrow
end event

event retrievestart;dw_order_releases.SetRedraw ( false )
end event

