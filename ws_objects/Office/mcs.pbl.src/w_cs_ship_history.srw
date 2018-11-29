$PBExportHeader$w_cs_ship_history.srw
forward
global type w_cs_ship_history from w_sheet_4t
end type
type dw_1 from datawindow within w_cs_ship_history
end type
type sle_document from statictext within w_cs_ship_history
end type
type sle_status from statictext within w_cs_ship_history
end type
type st_8 from statictext within w_cs_ship_history
end type
type st_7 from statictext within w_cs_ship_history
end type
type st_6 from statictext within w_cs_ship_history
end type
type sle_destination from singlelineedit within w_cs_ship_history
end type
type sle_shipper from singlelineedit within w_cs_ship_history
end type
type st_1 from statictext within w_cs_ship_history
end type
type gb_1 from groupbox within w_cs_ship_history
end type
type dw_shipper_detail from datawindow within w_cs_ship_history
end type
type st_3 from statictext within w_cs_ship_history
end type
type str_oe_detail from structure within w_cs_ship_history
end type
end forward

type str_oe_detail from structure
    long irowid
    string szum
end type

global type w_cs_ship_history from w_sheet_4t
string title = "Monitor Shipping Dock"
string menuname = "m_cs_ship_history"
event edit_qty pbm_custom07
event show_note pbm_custom10
event edit_shipper_header pbm_custom13
dw_1 dw_1
sle_document sle_document
sle_status sle_status
st_8 st_8
st_7 st_7
st_6 st_6
sle_destination sle_destination
sle_shipper sle_shipper
st_1 st_1
gb_1 gb_1
dw_shipper_detail dw_shipper_detail
st_3 st_3
end type
global w_cs_ship_history w_cs_ship_history

type variables
long	i_l_shipper,&
	i_l_suffix, &
	il_rowno

end variables

event edit_qty;//If iDetailRow > 0 then
//	If (sle_status.text	= "Staged") AND (sle_document.text = "Printed") then
//		If MessageBox("Warning", "Shipper is staged and packing slip has been printed. " + &
//							"~rAre you sure to change quantity now", Stopsign!, OkCancel!) = 2 then
//			Return
//		End If
//	End If
//	OpenWithParm(w_update_detail_qty, iDetailRow)
//Else
//	MessageBox("Warning", "Click shipper detail line item first", StopSign!)
//End If
//
//this.SetMicroHelp("Ready")
//
end event

event edit_shipper_header;//OpenWithParm(w_edit_shipper_shipping_info, iShipper)
//this.SetMicroHelp("Ready")
end event

event open;call super::open;string	l_s_status,&
			l_s_printed

i_l_shipper	= Message.DoubleParm

dw_shipper_detail.SetTransObject(sqlca)

dw_shipper_detail.Retrieve ( i_l_shipper )

sle_shipper.text		= String(i_l_shipper)

SELECT 	destination
INTO		:sle_destination.text
FROM		shipper
WHERE		shipper.id = :i_l_shipper ;

sle_status.text	= "Shipped"
sle_document.text	= "Printed"

end event

on w_cs_ship_history.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_cs_ship_history" then this.MenuID = create m_cs_ship_history
this.dw_1=create dw_1
this.sle_document=create sle_document
this.sle_status=create sle_status
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.sle_destination=create sle_destination
this.sle_shipper=create sle_shipper
this.st_1=create st_1
this.gb_1=create gb_1
this.dw_shipper_detail=create dw_shipper_detail
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.sle_document
this.Control[iCurrent+3]=this.sle_status
this.Control[iCurrent+4]=this.st_8
this.Control[iCurrent+5]=this.st_7
this.Control[iCurrent+6]=this.st_6
this.Control[iCurrent+7]=this.sle_destination
this.Control[iCurrent+8]=this.sle_shipper
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.dw_shipper_detail
this.Control[iCurrent+12]=this.st_3
end on

on w_cs_ship_history.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.sle_document)
destroy(this.sle_status)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.sle_destination)
destroy(this.sle_shipper)
destroy(this.st_1)
destroy(this.gb_1)
destroy(this.dw_shipper_detail)
destroy(this.st_3)
end on

type dw_1 from datawindow within w_cs_ship_history
integer x = 18
integer y = 864
integer width = 2853
integer height = 816
integer taborder = 20
string dataobject = "dw_cs_ship_history_objects"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;SetTransObject ( sqlca )
end event

type sle_document from statictext within w_cs_ship_history
integer x = 2446
integer y = 48
integer width = 347
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8421504
boolean enabled = false
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type sle_status from statictext within w_cs_ship_history
integer x = 1673
integer y = 48
integer width = 347
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8421504
boolean enabled = false
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_8 from statictext within w_cs_ship_history
integer x = 2066
integer y = 48
integer width = 366
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Packing List"
boolean focusrectangle = false
end type

type st_7 from statictext within w_cs_ship_history
integer x = 1467
integer y = 48
integer width = 201
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Status"
boolean focusrectangle = false
end type

type st_6 from statictext within w_cs_ship_history
integer x = 713
integer y = 48
integer width = 338
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Destination"
boolean focusrectangle = false
end type

type sle_destination from singlelineedit within w_cs_ship_history
integer x = 1065
integer y = 48
integer width = 347
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8421504
boolean enabled = false
boolean autohscroll = false
end type

type sle_shipper from singlelineedit within w_cs_ship_history
integer x = 293
integer y = 48
integer width = 347
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8421504
boolean enabled = false
boolean autohscroll = false
end type

type st_1 from statictext within w_cs_ship_history
integer x = 41
integer y = 48
integer width = 251
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Shipper"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_cs_ship_history
integer x = 5
integer width = 2866
integer height = 144
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
end type

type dw_shipper_detail from datawindow within w_cs_ship_history
integer x = 18
integer y = 256
integer width = 2853
integer height = 592
integer taborder = 10
string dataobject = "dw_cs_shipper_detail"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;if RowCount ( ) > 0 then
	if isnull(il_rowno) or il_rowno = 0 then il_rowno = 1
	SelectRow ( il_rowno, TRUE )
	SetRow ( 1 )
	dw_1.Retrieve ( string(i_l_shipper), GetItemString ( il_rowno, "part" ) )
end if
end event

event clicked;SelectRow ( 0, FALSE )
if Row > 0 then
	il_rowno = row	
	SelectRow ( row, TRUE )
	SetRow ( row )
	dw_1.Retrieve ( STRING(i_l_shipper), GetItemString ( row, "part" ) )
else
	dw_1.Retrieve ( '', '' )
end if
end event

type st_3 from statictext within w_cs_ship_history
integer x = 18
integer y = 160
integer width = 2853
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "Shipper Detail Item"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

