$PBExportHeader$w_receiving_dock_inquiry.srw
$PBExportComments$receiving dock inquiry screen
forward
global type w_receiving_dock_inquiry from w_sheet_4t
end type
type em_date from singlelineedit within w_receiving_dock_inquiry
end type
type st_6 from statictext within w_receiving_dock_inquiry
end type
type st_5 from statictext within w_receiving_dock_inquiry
end type
type p_4 from picture within w_receiving_dock_inquiry
end type
type p_3 from picture within w_receiving_dock_inquiry
end type
type st_4 from statictext within w_receiving_dock_inquiry
end type
type st_3 from statictext within w_receiving_dock_inquiry
end type
type cb_3 from commandbutton within w_receiving_dock_inquiry
end type
type cb_2 from commandbutton within w_receiving_dock_inquiry
end type
type dw_1 from datawindow within w_receiving_dock_inquiry
end type
type cb_1 from commandbutton within w_receiving_dock_inquiry
end type
type st_2 from statictext within w_receiving_dock_inquiry
end type
type p_2 from picture within w_receiving_dock_inquiry
end type
type st_1 from statictext within w_receiving_dock_inquiry
end type
type p_1 from picture within w_receiving_dock_inquiry
end type
type dw_receiving_dock from datawindow within w_receiving_dock_inquiry
end type
type dw_arrival from u_arrival_inquiry within w_receiving_dock_inquiry
end type
end forward

shared variables

end variables

global type w_receiving_dock_inquiry from w_sheet_4t
string title = "Receiving Dock Inquiry"
string menuname = "m_receiving_inquiry"
long backcolor = 78682240
event ue_po_inquiry pbm_custom01
event ue_arrival pbm_custom02
event ue_sort pbm_custom03
em_date em_date
st_6 st_6
st_5 st_5
p_4 p_4
p_3 p_3
st_4 st_4
st_3 st_3
cb_3 cb_3
cb_2 cb_2
dw_1 dw_1
cb_1 cb_1
st_2 st_2
p_2 p_2
st_1 st_1
p_1 p_1
dw_receiving_dock dw_receiving_dock
dw_arrival dw_arrival
end type
global w_receiving_dock_inquiry w_receiving_dock_inquiry

type variables
Boolean bReceiving        //Drag from receiving dock

Long      iReceivingRow  //Current row in datawindow

Decimal  nQty                 //Qty received

Long iPo                        // The current po number
Long lRowId

Decimal nAccum
Decimal nBalance

String szLocation
String cSortOrder
String szColumn

St_Unit_Conversion St_Unit_Conversions

String szPartNumber

Long iColumn
end variables

forward prototypes
public function boolean wf_update_dw (datawindow dwin)
public subroutine show_notes ()
public subroutine hide_notes ()
public subroutine wf_update_po_release (decimal a_n_balance)
end prototypes

event ue_po_inquiry;dw_arrival.Visible = FALSE
dw_receiving_dock.Retrieve ( date( em_date.text ) )
SetPointer ( HourGlass! )

end event

event ue_arrival;dw_arrival.Visible = TRUE
dw_arrival.Retrieve ()
end event

event ue_sort;str_sort l_st_parm

IF dw_arrival.Visible = TRUE THEN
	
  l_st_parm.dw = dw_arrival
ELSE 
	
  l_st_parm.dw = dw_receiving_dock
  
END IF

l_st_parm.title = ' Sort '

OpenWithParm( w_sort, l_st_parm)

end event

public function boolean wf_update_dw (datawindow dwin);If dw_receiving_dock.Update() > 0 then
	Commit;
	Return TRUE
Else
	Rollback;
	Return FALSE
End If
end function

public subroutine show_notes ();If iReceivingRow < 1 Then
	MessageBox ( "Error", "You must choose a detail~rline item first!", StopSign! )
	Return
End if

cb_1.Visible = True
st_3.Visible = True
dw_1.Visible = True
cb_2.Visible = True
cb_3.Visible = True
dw_1.SetTransObject ( sqlca )
If dw_1.Retrieve ( iPo ) < 1 Then
	dw_1.InsertRow ( 1 )
End if
dw_1.SetFocus ( )
end subroutine

public subroutine hide_notes ();cb_1.Visible = False
st_3.Visible = False
dw_1.Visible = False
cb_2.Visible = False
cb_3.Visible = False

end subroutine

public subroutine wf_update_po_release (decimal a_n_balance);Decimal l_n_Balance

DO While  a_n_Balance < 0
	if dw_receiving_dock.GetItemNumber(iReceivingRow, "po_number") <> iPo then Exit

	dw_receiving_dock.SetItem(iReceivingRow, "balance", 0)
	dw_receiving_dock.SetItem(iReceivingRow, "received_cum", nAccum)
	dw_receiving_dock.SetItem(iReceivingRow, "status", "C")	//Close this release
	iReceivingRow = iReceivingRow + 1
	l_n_Balance = Abs(a_n_Balance)
	nAccum = dw_receiving_dock.GetItemNumber(iReceivingRow, "received_cum")
	nAccum = nAccum + l_n_Balance
	a_n_Balance = dw_receiving_dock.GetItemNumber(iReceivingRow, "balance")
	a_n_Balance = a_n_Balance - l_n_Balance
Loop

dw_receiving_dock.SetItem(iReceivingRow, "balance", a_n_Balance)
dw_receiving_dock.SetItem(iReceivingRow, "received_cum", nAccum)
 

end subroutine

event open;call super::open;em_date.text	= String(today())
this.title		= "Receiving Dock Inquiry on " + em_date.text

TRIGGEREVENT ( "ue_po_inquiry" )

end event

on w_receiving_dock_inquiry.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_receiving_inquiry" then this.MenuID = create m_receiving_inquiry
this.em_date=create em_date
this.st_6=create st_6
this.st_5=create st_5
this.p_4=create p_4
this.p_3=create p_3
this.st_4=create st_4
this.st_3=create st_3
this.cb_3=create cb_3
this.cb_2=create cb_2
this.dw_1=create dw_1
this.cb_1=create cb_1
this.st_2=create st_2
this.p_2=create p_2
this.st_1=create st_1
this.p_1=create p_1
this.dw_receiving_dock=create dw_receiving_dock
this.dw_arrival=create dw_arrival
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_date
this.Control[iCurrent+2]=this.st_6
this.Control[iCurrent+3]=this.st_5
this.Control[iCurrent+4]=this.p_4
this.Control[iCurrent+5]=this.p_3
this.Control[iCurrent+6]=this.st_4
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.cb_3
this.Control[iCurrent+9]=this.cb_2
this.Control[iCurrent+10]=this.dw_1
this.Control[iCurrent+11]=this.cb_1
this.Control[iCurrent+12]=this.st_2
this.Control[iCurrent+13]=this.p_2
this.Control[iCurrent+14]=this.st_1
this.Control[iCurrent+15]=this.p_1
this.Control[iCurrent+16]=this.dw_receiving_dock
this.Control[iCurrent+17]=this.dw_arrival
end on

on w_receiving_dock_inquiry.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.em_date)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.p_4)
destroy(this.p_3)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.p_2)
destroy(this.st_1)
destroy(this.p_1)
destroy(this.dw_receiving_dock)
destroy(this.dw_arrival)
end on

event resize;call super::resize;dw_arrival.width  = this.width - 125
dw_arrival.height = this.height - 125
dw_receiving_dock.width = this.width - 125
dw_receiving_dock.height = this.height - 300
st_6.X				=  dw_receiving_dock.X 
st_6.Y				=  dw_receiving_dock.Y + dw_receiving_dock.height + 15
em_date.X			=  st_6.X + 75 + st_6.width
em_date.Y			=  st_6.Y

end event

type em_date from singlelineedit within w_receiving_dock_inquiry
integer x = 640
integer y = 1456
integer width = 306
integer height = 88
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

on modified;dw_receiving_dock.Retrieve (date(this.text))
w_receiving_dock_inquiry.title		= "Receiving Dock Inquiry on " + this.text
end on

event constructor;em_date.X			=  st_6.X + 75 + st_6.width
em_date.Y			=  st_6.Y
end event

type st_6 from statictext within w_receiving_dock_inquiry
integer x = 46
integer y = 1464
integer width = 567
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Inquiry on and before"
boolean focusrectangle = false
end type

event constructor;st_6.X				=  dw_receiving_dock.X 
st_6.Y				=  dw_receiving_dock.Y + dw_receiving_dock.height + 15 

end event

type st_5 from statictext within w_receiving_dock_inquiry
integer x = 2560
integer y = 20
integer width = 283
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = " = Past Due"
boolean focusrectangle = false
end type

type p_4 from picture within w_receiving_dock_inquiry
integer x = 2487
integer y = 20
integer width = 73
integer height = 64
string picturename = "logo2.bmp"
boolean focusrectangle = false
end type

type p_3 from picture within w_receiving_dock_inquiry
integer x = 1938
integer y = 20
integer width = 73
integer height = 64
string picturename = "clear1.bmp"
boolean focusrectangle = false
end type

type st_4 from statictext within w_receiving_dock_inquiry
integer x = 2011
integer y = 20
integer width = 407
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "= Fully Received"
boolean focusrectangle = false
end type

type st_3 from statictext within w_receiving_dock_inquiry
boolean visible = false
integer x = 841
integer y = 352
integer width = 1353
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Footer Notes"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_receiving_dock_inquiry
boolean visible = false
integer x = 1134
integer y = 864
integer width = 256
integer height = 104
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancel"
end type

on clicked;hide_notes ( )
end on

type cb_2 from commandbutton within w_receiving_dock_inquiry
boolean visible = false
integer x = 841
integer y = 864
integer width = 256
integer height = 104
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Save"
end type

event clicked;Long lRow

If dw_1.Update ( ) = -1 Then
	RollBack ;
	Return
End if

Commit ;

dw_receiving_dock.Retrieve ( )
lRow = dw_receiving_dock.Find ( "row_id = " + String ( lRowId ), 1, dw_receiving_dock.RowCount ( ) )
If lRow > 0 Then
	SelectRow ( dw_receiving_dock, 0, False )
	SelectRow ( dw_receiving_dock, lRow, True )
End if

hide_notes ( )
end event

type dw_1 from datawindow within w_receiving_dock_inquiry
boolean visible = false
integer x = 841
integer y = 416
integer width = 1353
integer height = 416
integer taborder = 30
string dataobject = "d_header_notes"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type cb_1 from commandbutton within w_receiving_dock_inquiry
boolean visible = false
integer x = 805
integer y = 320
integer width = 1426
integer height = 704
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
end type

type st_2 from statictext within w_receiving_dock_inquiry
integer x = 1499
integer y = 20
integer width = 375
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "= Footer Notes"
boolean focusrectangle = false
end type

type p_2 from picture within w_receiving_dock_inquiry
integer x = 1422
integer y = 20
integer width = 73
integer height = 64
string picturename = "noteyes.bmp"
boolean focusrectangle = false
end type

type st_1 from statictext within w_receiving_dock_inquiry
integer x = 914
integer y = 20
integer width = 453
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = " = On Hold(Status)"
boolean focusrectangle = false
end type

type p_1 from picture within w_receiving_dock_inquiry
integer x = 841
integer y = 20
integer width = 73
integer height = 64
string picturename = "stopgrey.bmp"
boolean focusrectangle = false
end type

type dw_receiving_dock from datawindow within w_receiving_dock_inquiry
event ue_sort ( )
integer x = 27
integer y = 88
integer width = 2816
integer height = 1348
integer taborder = 10
string dragicon = "AppRectangle!"
string dataobject = "d_rec_dock_inquiry"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject ( sqlca )
this.width  = w_receiving_dock_inquiry.width - 125
this.height = w_receiving_dock_inquiry.height - 300
end event

type dw_arrival from u_arrival_inquiry within w_receiving_dock_inquiry
boolean visible = false
integer x = 37
integer y = 12
integer width = 2816
integer height = 1576
end type

event constructor;call super::constructor;this.width  = w_receiving_dock_inquiry.width - 125
this.height = w_receiving_dock_inquiry.height - 125
end event

