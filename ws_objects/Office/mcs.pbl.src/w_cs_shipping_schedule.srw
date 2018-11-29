$PBExportHeader$w_cs_shipping_schedule.srw
forward
global type w_cs_shipping_schedule from w_sheet_4t
end type
type sle_document from statictext within w_cs_shipping_schedule
end type
type sle_status from statictext within w_cs_shipping_schedule
end type
type st_black from statictext within w_cs_shipping_schedule
end type
type st_blue from statictext within w_cs_shipping_schedule
end type
type st_13 from statictext within w_cs_shipping_schedule
end type
type p_5 from picture within w_cs_shipping_schedule
end type
type st_12 from statictext within w_cs_shipping_schedule
end type
type p_4 from picture within w_cs_shipping_schedule
end type
type st_red from statictext within w_cs_shipping_schedule
end type
type st_10 from statictext within w_cs_shipping_schedule
end type
type p_3 from picture within w_cs_shipping_schedule
end type
type st_9 from statictext within w_cs_shipping_schedule
end type
type p_2 from picture within w_cs_shipping_schedule
end type
type st_8 from statictext within w_cs_shipping_schedule
end type
type st_7 from statictext within w_cs_shipping_schedule
end type
type st_5 from statictext within w_cs_shipping_schedule
end type
type st_4 from statictext within w_cs_shipping_schedule
end type
type st_6 from statictext within w_cs_shipping_schedule
end type
type sle_destination from singlelineedit within w_cs_shipping_schedule
end type
type sle_shipper from singlelineedit within w_cs_shipping_schedule
end type
type st_1 from statictext within w_cs_shipping_schedule
end type
type gb_1 from groupbox within w_cs_shipping_schedule
end type
type dw_shipper_detail from datawindow within w_cs_shipping_schedule
end type
type st_3 from statictext within w_cs_shipping_schedule
end type
type dw_pallets from datawindow within w_cs_shipping_schedule
end type
type dw_objects from datawindow within w_cs_shipping_schedule
end type
type str_oe_detail from structure within w_cs_shipping_schedule
end type
end forward

type str_oe_detail from structure
    long irowid
    string szum
end type

global type w_cs_shipping_schedule from w_sheet_4t
string title = "Monitor Shipping Dock"
string menuname = "m_cs_ship_schedule"
event edit_qty pbm_custom07
event show_note pbm_custom10
event edit_shipper_header pbm_custom13
sle_document sle_document
sle_status sle_status
st_black st_black
st_blue st_blue
st_13 st_13
p_5 p_5
st_12 st_12
p_4 p_4
st_red st_red
st_10 st_10
p_3 p_3
st_9 st_9
p_2 p_2
st_8 st_8
st_7 st_7
st_5 st_5
st_4 st_4
st_6 st_6
sle_destination sle_destination
sle_shipper sle_shipper
st_1 st_1
gb_1 gb_1
dw_shipper_detail dw_shipper_detail
st_3 st_3
dw_pallets dw_pallets
dw_objects dw_objects
end type
global w_cs_shipping_schedule w_cs_shipping_schedule

type variables
long		i_l_shipper,&
		i_l_suffix
end variables

forward prototypes
public subroutine display_objects (string a_s_part)
public function string wf_strip_off_suffix (string a_s_part, long a_l_suffix)
end prototypes

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

public subroutine display_objects (string a_s_part);String szMod_string
Long   lBackColor

lBackColor		= 0
szMod_string 	= "serial.color = '0~tif( (shipper > 0) , 255, if( parent_serial > 0, 16711680, " + String(lBackColor) + "))'"

dw_objects.Modify(szMod_string)

//If i_l_suffix > 0 then
//	dw_objects.Retrieve ( wf_strip_off_suffix ( a_s_part, i_l_suffix ) )
//Else
	dw_objects.Retrieve ( i_l_shipper )
//End If

end subroutine

public function string wf_strip_off_suffix (string a_s_part, long a_l_suffix);Long iPos

iPos	= PosA(a_s_part, "-" + String(a_l_suffix))
If iPos > 1 then
	a_s_part	= LeftA(a_s_part, iPos - 1)
End If

Return a_s_part
end function

event open;call super::open;string	l_s_status,&
			l_s_printed

i_l_shipper	= Message.DoubleParm

dw_objects.SetTransObject(sqlca)
dw_pallets.SetTransObject(sqlca)
dw_shipper_detail.SetTransObject(sqlca)

dw_shipper_detail.Retrieve ( i_l_shipper ) 
dw_pallets.Retrieve(i_l_shipper)

If dw_shipper_detail.RowCount() > 0 then
	i_l_suffix = dw_shipper_detail.GetItemNumber ( 1, 18 ) //"shipper_detail_suffix" 	
	Display_Objects(dw_shipper_detail.GetItemString(1, "part"))
Else
	dw_objects.Reset()
End If

sle_shipper.text		= String(i_l_shipper)

SELECT 	destination,
			status,
			printed
INTO		:sle_destination.text,
			:l_s_status,
			:l_s_printed
FROM		shipper
WHERE		shipper.id = :i_l_shipper ;

If l_s_status = 'S' then
	sle_status.text	= "Staged"
	sle_status.textcolor	= f_get_color_value ( "green" )		//65280
Else
	sle_status.text	= "Not Ready"
	sle_status.textcolor	= sle_shipper.textcolor
End If

If l_s_printed = 'Y' then
	sle_document.text	= "Printed"
	sle_document.textcolor	= f_get_color_value ( "green" )		
Else
	sle_document.text	= "Not Printed"
	sle_document.textcolor	= sle_shipper.textcolor
End If
end event

on w_cs_shipping_schedule.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_cs_ship_schedule" then this.MenuID = create m_cs_ship_schedule
this.sle_document=create sle_document
this.sle_status=create sle_status
this.st_black=create st_black
this.st_blue=create st_blue
this.st_13=create st_13
this.p_5=create p_5
this.st_12=create st_12
this.p_4=create p_4
this.st_red=create st_red
this.st_10=create st_10
this.p_3=create p_3
this.st_9=create st_9
this.p_2=create p_2
this.st_8=create st_8
this.st_7=create st_7
this.st_5=create st_5
this.st_4=create st_4
this.st_6=create st_6
this.sle_destination=create sle_destination
this.sle_shipper=create sle_shipper
this.st_1=create st_1
this.gb_1=create gb_1
this.dw_shipper_detail=create dw_shipper_detail
this.st_3=create st_3
this.dw_pallets=create dw_pallets
this.dw_objects=create dw_objects
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_document
this.Control[iCurrent+2]=this.sle_status
this.Control[iCurrent+3]=this.st_black
this.Control[iCurrent+4]=this.st_blue
this.Control[iCurrent+5]=this.st_13
this.Control[iCurrent+6]=this.p_5
this.Control[iCurrent+7]=this.st_12
this.Control[iCurrent+8]=this.p_4
this.Control[iCurrent+9]=this.st_red
this.Control[iCurrent+10]=this.st_10
this.Control[iCurrent+11]=this.p_3
this.Control[iCurrent+12]=this.st_9
this.Control[iCurrent+13]=this.p_2
this.Control[iCurrent+14]=this.st_8
this.Control[iCurrent+15]=this.st_7
this.Control[iCurrent+16]=this.st_5
this.Control[iCurrent+17]=this.st_4
this.Control[iCurrent+18]=this.st_6
this.Control[iCurrent+19]=this.sle_destination
this.Control[iCurrent+20]=this.sle_shipper
this.Control[iCurrent+21]=this.st_1
this.Control[iCurrent+22]=this.gb_1
this.Control[iCurrent+23]=this.dw_shipper_detail
this.Control[iCurrent+24]=this.st_3
this.Control[iCurrent+25]=this.dw_pallets
this.Control[iCurrent+26]=this.dw_objects
end on

on w_cs_shipping_schedule.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.sle_document)
destroy(this.sle_status)
destroy(this.st_black)
destroy(this.st_blue)
destroy(this.st_13)
destroy(this.p_5)
destroy(this.st_12)
destroy(this.p_4)
destroy(this.st_red)
destroy(this.st_10)
destroy(this.p_3)
destroy(this.st_9)
destroy(this.p_2)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_6)
destroy(this.sle_destination)
destroy(this.sle_shipper)
destroy(this.st_1)
destroy(this.gb_1)
destroy(this.dw_shipper_detail)
destroy(this.st_3)
destroy(this.dw_pallets)
destroy(this.dw_objects)
end on

type sle_document from statictext within w_cs_shipping_schedule
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

type sle_status from statictext within w_cs_shipping_schedule
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

type st_black from statictext within w_cs_shipping_schedule
integer x = 2487
integer y = 784
integer width = 334
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
boolean enabled = false
string text = "Black = Available"
boolean focusrectangle = false
end type

type st_blue from statictext within w_cs_shipping_schedule
integer x = 2153
integer y = 788
integer width = 311
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 16777215
boolean enabled = false
string text = "Blue = On Pallet"
boolean focusrectangle = false
end type

type st_13 from statictext within w_cs_shipping_schedule
integer x = 2432
integer y = 176
integer width = 165
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 255
long backcolor = 16777215
boolean enabled = false
string text = "Staged"
long bordercolor = 16777215
boolean focusrectangle = false
end type

type p_5 from picture within w_cs_shipping_schedule
integer x = 2345
integer y = 176
integer width = 73
integer height = 56
string picturename = "logo2.bmp"
boolean focusrectangle = false
end type

type st_12 from statictext within w_cs_shipping_schedule
integer x = 2107
integer y = 176
integer width = 210
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 255
long backcolor = 16777215
boolean enabled = false
string text = "Part Note"
long bordercolor = 16777215
boolean focusrectangle = false
end type

type p_4 from picture within w_cs_shipping_schedule
integer x = 2021
integer y = 172
integer width = 73
integer height = 56
string picturename = "noteyes.bmp"
boolean focusrectangle = false
end type

on clicked;w_shipping_dock1.TriggerEvent("show_note")
end on

type st_red from statictext within w_cs_shipping_schedule
integer x = 1829
integer y = 788
integer width = 320
integer height = 48
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 255
long backcolor = 16777215
boolean enabled = false
string text = "Red = Staged"
boolean focusrectangle = false
end type

type st_10 from statictext within w_cs_shipping_schedule
integer x = 1353
integer y = 784
integer width = 110
integer height = 48
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 255
long backcolor = 16777215
boolean enabled = false
string text = "Box"
boolean focusrectangle = false
end type

type p_3 from picture within w_cs_shipping_schedule
integer x = 1280
integer y = 788
integer width = 55
integer height = 48
string picturename = "box.bmp"
boolean focusrectangle = false
end type

type st_9 from statictext within w_cs_shipping_schedule
integer x = 1152
integer y = 784
integer width = 128
integer height = 48
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 255
long backcolor = 16777215
boolean enabled = false
string text = "Pallet"
boolean focusrectangle = false
end type

type p_2 from picture within w_cs_shipping_schedule
integer x = 1079
integer y = 792
integer width = 64
integer height = 44
string picturename = "pallet.bmp"
boolean focusrectangle = false
end type

type st_8 from statictext within w_cs_shipping_schedule
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

type st_7 from statictext within w_cs_shipping_schedule
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

type st_5 from statictext within w_cs_shipping_schedule
integer x = 1504
integer y = 776
integer width = 1353
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "   Objects"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_4 from statictext within w_cs_shipping_schedule
integer x = 9
integer y = 776
integer width = 1463
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "             Staged Pallets/Objects"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_6 from statictext within w_cs_shipping_schedule
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

type sle_destination from singlelineedit within w_cs_shipping_schedule
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

type sle_shipper from singlelineedit within w_cs_shipping_schedule
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

type st_1 from statictext within w_cs_shipping_schedule
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

type gb_1 from groupbox within w_cs_shipping_schedule
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

type dw_shipper_detail from datawindow within w_cs_shipping_schedule
integer x = 9
integer y = 256
integer width = 2853
integer height = 496
integer taborder = 10
string dataobject = "dw_cs_shipper_detail"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;string	l_s_part

SetNull(i_l_suffix)

If row > 0 then
	l_s_part 		= GetItemString(row, "part")
	i_l_suffix		= GetItemNumber(row, "shipper_detail_suffix")
	If i_l_suffix > 0 then
		l_s_part	= wf_strip_off_suffix(l_s_part, i_l_suffix)
	End If
	Display_objects ( l_s_part ) 
	SelectRow(0, FALSE)
	SelectRow(row, TRUE)
End If

end event

type st_3 from statictext within w_cs_shipping_schedule
integer x = 9
integer y = 164
integer width = 2853
integer height = 72
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

type dw_pallets from datawindow within w_cs_shipping_schedule
integer x = 9
integer y = 856
integer width = 1463
integer height = 564
integer taborder = 20
string dragicon = "MONITOR.ICO"
string dataobject = "dw_pallets"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;if row > 0 then
	if GetItemString ( row, "type" ) = 'S' then
		OpenWithParm ( w_cs_shipping_schedule_pallet_info, GetItemNumber ( row, "serial" ) )
	end if
end if
end event

type dw_objects from datawindow within w_cs_shipping_schedule
integer x = 1504
integer y = 856
integer width = 1353
integer height = 564
integer taborder = 30
string dragicon = "MONITOR.ICO"
string dataobject = "dw_available_objects"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

