$PBExportHeader$w_enter_opertor_code.srw
forward
global type w_enter_opertor_code from window
end type
type em_1 from editmask within w_enter_opertor_code
end type
type st_5 from statictext within w_enter_opertor_code
end type
type st_4 from statictext within w_enter_opertor_code
end type
type sle_truck_number from singlelineedit within w_enter_opertor_code
end type
type sle_pro_number from singlelineedit within w_enter_opertor_code
end type
type st_3 from statictext within w_enter_opertor_code
end type
type sle_operator from singlelineedit within w_enter_opertor_code
end type
type cb_2 from commandbutton within w_enter_opertor_code
end type
type st_2 from statictext within w_enter_opertor_code
end type
type cb_1 from commandbutton within w_enter_opertor_code
end type
type sle_password from singlelineedit within w_enter_opertor_code
end type
type st_1 from statictext within w_enter_opertor_code
end type
type gb_1 from groupbox within w_enter_opertor_code
end type
end forward

global type w_enter_opertor_code from window
integer x = 759
integer y = 536
integer width = 1179
integer height = 948
boolean titlebar = true
string title = "Enter Shipping Data"
windowtype windowtype = response!
long backcolor = 77897888
em_1 em_1
st_5 st_5
st_4 st_4
sle_truck_number sle_truck_number
sle_pro_number sle_pro_number
st_3 st_3
sle_operator sle_operator
cb_2 cb_2
st_2 st_2
cb_1 cb_1
sle_password sle_password
st_1 st_1
gb_1 gb_1
end type
global w_enter_opertor_code w_enter_opertor_code

type variables
string	i_s_mode
end variables

event open;i_s_mode = Message.StringParm
em_1.text = string(today())

end event

on w_enter_opertor_code.create
this.em_1=create em_1
this.st_5=create st_5
this.st_4=create st_4
this.sle_truck_number=create sle_truck_number
this.sle_pro_number=create sle_pro_number
this.st_3=create st_3
this.sle_operator=create sle_operator
this.cb_2=create cb_2
this.st_2=create st_2
this.cb_1=create cb_1
this.sle_password=create sle_password
this.st_1=create st_1
this.gb_1=create gb_1
this.Control[]={this.em_1,&
this.st_5,&
this.st_4,&
this.sle_truck_number,&
this.sle_pro_number,&
this.st_3,&
this.sle_operator,&
this.cb_2,&
this.st_2,&
this.cb_1,&
this.sle_password,&
this.st_1,&
this.gb_1}
end on

on w_enter_opertor_code.destroy
destroy(this.em_1)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.sle_truck_number)
destroy(this.sle_pro_number)
destroy(this.st_3)
destroy(this.sle_operator)
destroy(this.cb_2)
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.sle_password)
destroy(this.st_1)
destroy(this.gb_1)
end on

type em_1 from editmask within w_enter_opertor_code
integer x = 517
integer y = 568
integer width = 521
integer height = 88
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yy"
end type

type st_5 from statictext within w_enter_opertor_code
integer x = 146
integer y = 572
integer width = 320
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Date shipped"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_enter_opertor_code
integer x = 146
integer y = 448
integer width = 320
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Truck Number"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_truck_number from singlelineedit within w_enter_opertor_code
integer x = 517
integer y = 448
integer width = 521
integer height = 88
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_pro_number from singlelineedit within w_enter_opertor_code
integer x = 517
integer y = 324
integer width = 521
integer height = 88
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_enter_opertor_code
integer x = 174
integer y = 208
integer width = 247
integer height = 72
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Code"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_operator from singlelineedit within w_enter_opertor_code
integer x = 517
integer y = 208
integer width = 521
integer height = 88
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean enabled = false
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_enter_opertor_code
integer x = 878
integer y = 732
integer width = 256
integer height = 108
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancel"
boolean cancel = true
end type

event clicked;bCancel	= TRUE
if i_s_mode = "w_quick_shipper" then
	w_quick_shipper.is_Operator		= ""
	w_quick_shipper.szProNumber	= ""
	setnull(w_quick_shipper.idt_dateshipped)
	
else
	w_shipping_dock.is_operator		= ""
	w_shipping_dock.szProNumber	= ""
	w_shipping_dock.is_trucknumber	= ""
	setnull(w_shipping_dock.idt_dateshipped)

end if

Close(w_enter_opertor_code)
end event

type st_2 from statictext within w_enter_opertor_code
integer x = 123
integer y = 324
integer width = 361
integer height = 72
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Pro Number"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_enter_opertor_code
integer x = 603
integer y = 732
integer width = 247
integer height = 108
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "OK"
boolean default = true
end type

event clicked;string	ls_time

If date(em_1.text) > today() then 
	Messagebox ( Monsys.msg_title, "Invalid ship date")
	em_1.setfocus()
	return
end if 	
	
ls_time = string(now())

If IsNull(sle_operator.text) OR (Trim(sle_operator.text) = '') then
	MessageBox("Warning", "You must enter password to proceed", Stopsign!)
	Return
Else
	if i_s_mode = "w_quick_shipper" then
		w_quick_shipper.is_operator	= Trim(sle_operator.text)
		w_quick_shipper.szProNumber	= Trim(sle_pro_number.text)
		w_quick_shipper.idt_dateshipped	= datetime(date(Trim(em_1.text)),time(ls_time))		
	else
		w_shipping_dock.is_operator	= Trim(sle_operator.text)
		w_shipping_dock.szProNumber	= Trim(sle_pro_number.text)
		w_shipping_dock.is_trucknumber	= Trim(sle_truck_number.text)
		w_shipping_dock.idt_dateshipped	= datetime(date(Trim(em_1.text)),time(ls_time))
		
	end if
End If
Close(w_enter_opertor_code)

end event

type sle_password from singlelineedit within w_enter_opertor_code
integer x = 517
integer y = 92
integer width = 521
integer height = 88
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
boolean autohscroll = false
boolean password = true
borderstyle borderstyle = stylelowered!
end type

on modified;String szPass, szCode
szPass = this.Text
Select employee.operator_code
	INTO :szCode
	From Employee
Where Employee.password = :szPass ;
If szCode <= " " Then 
	this.Setfocus()
	this.Text = ""
	sle_operator.Text = ""
	Return
Else
	sle_operator.Text = szCode
End If
end on

type st_1 from statictext within w_enter_opertor_code
integer x = 137
integer y = 100
integer width = 283
integer height = 72
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Operator"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_enter_opertor_code
integer x = 18
integer y = 16
integer width = 1115
integer height = 692
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 78682240
end type

