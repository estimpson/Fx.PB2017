$PBExportHeader$w_update_detail_qty.srw
$PBExportComments$Update shipper detail quantity
forward
global type w_update_detail_qty from window
end type
type sle_operator from singlelineedit within w_update_detail_qty
end type
type st_5 from statictext within w_update_detail_qty
end type
type sle_password from singlelineedit within w_update_detail_qty
end type
type st_4 from statictext within w_update_detail_qty
end type
type st_um_pack from statictext within w_update_detail_qty
end type
type sle_qty_packed from singlelineedit within w_update_detail_qty
end type
type st_qty_pack from statictext within w_update_detail_qty
end type
type st_um2 from statictext within w_update_detail_qty
end type
type st_um from statictext within w_update_detail_qty
end type
type cb_2 from commandbutton within w_update_detail_qty
end type
type cb_1 from commandbutton within w_update_detail_qty
end type
type sle_new_qty from singlelineedit within w_update_detail_qty
end type
type st_3 from statictext within w_update_detail_qty
end type
type sle_orig_qty from singlelineedit within w_update_detail_qty
end type
type st_2 from statictext within w_update_detail_qty
end type
type sle_part from singlelineedit within w_update_detail_qty
end type
type st_1 from statictext within w_update_detail_qty
end type
type gb_1 from groupbox within w_update_detail_qty
end type
end forward

global type w_update_detail_qty from window
integer x = 782
integer y = 596
integer width = 1344
integer height = 1060
boolean titlebar = true
string title = "Update Quantity Required"
boolean controlmenu = true
windowtype windowtype = popup!
long backcolor = 77897888
sle_operator sle_operator
st_5 st_5
sle_password sle_password
st_4 st_4
st_um_pack st_um_pack
sle_qty_packed sle_qty_packed
st_qty_pack st_qty_pack
st_um2 st_um2
st_um st_um
cb_2 cb_2
cb_1 cb_1
sle_new_qty sle_new_qty
st_3 st_3
sle_orig_qty sle_orig_qty
st_2 st_2
sle_part sle_part
st_1 st_1
gb_1 gb_1
end type
global w_update_detail_qty w_update_detail_qty

forward prototypes
public subroutine wf_reset_picklist_flag ()
end prototypes

public subroutine wf_reset_picklist_flag ();Long iShipper

iShipper	= w_list_of_active_shippers.iShipper

If iShipper > 0 then
	Update Shipper Set Picklist_printed = 'N' Where Id = :iShipper;
	If SQLCA.SQLCode = 0 then
		Commit;
		w_list_of_active_shippers.dw_shipping_dock.SetItem(w_list_of_active_shippers.iSelectedRow, "shipper_picklist_printed", "N")
	Else
		Rollback;
	End If
End If
end subroutine

event open;Long iDetailRow
Datawindow dWin

iDetailRow	= w_shipping_dock.iDetailRow
if	iDetailRow <= 0 or iDetailRow > w_shipping_dock.dw_shipper_detail.RowCount() then
	if	w_shipping_dock.dw_shipper_detail.RowCount() <= 0 then
		post Close(this)
		return
	else
		w_shipping_dock.dw_shipper_detail.SelectRow(0, false)
		w_shipping_dock.dw_shipper_detail.SelectRow(1, true)
		
		iDetailRow = 1
	end if
end if

dWin			= w_shipping_dock.dw_shipper_detail

sle_part.text			= dWin.GetItemString(iDetailRow, "part")
sle_orig_qty.text		= String(dWin.GetItemNumber(iDetailRow, "shipper_detail_qty_required"))
sle_qty_packed.text	= String(dWin.GetItemNumber(iDetailRow, "shipper_detail_alternative_qty"))
st_um.text				= dWin.GetItemString(iDetailRow, "shipper_detail_alternative_unit")
st_um2.text				= st_um.text
st_um_pack.text	= st_um.text
sle_password.SetFocus()

end event

on w_update_detail_qty.create
this.sle_operator=create sle_operator
this.st_5=create st_5
this.sle_password=create sle_password
this.st_4=create st_4
this.st_um_pack=create st_um_pack
this.sle_qty_packed=create sle_qty_packed
this.st_qty_pack=create st_qty_pack
this.st_um2=create st_um2
this.st_um=create st_um
this.cb_2=create cb_2
this.cb_1=create cb_1
this.sle_new_qty=create sle_new_qty
this.st_3=create st_3
this.sle_orig_qty=create sle_orig_qty
this.st_2=create st_2
this.sle_part=create sle_part
this.st_1=create st_1
this.gb_1=create gb_1
this.Control[]={this.sle_operator,&
this.st_5,&
this.sle_password,&
this.st_4,&
this.st_um_pack,&
this.sle_qty_packed,&
this.st_qty_pack,&
this.st_um2,&
this.st_um,&
this.cb_2,&
this.cb_1,&
this.sle_new_qty,&
this.st_3,&
this.sle_orig_qty,&
this.st_2,&
this.sle_part,&
this.st_1,&
this.gb_1}
end on

on w_update_detail_qty.destroy
destroy(this.sle_operator)
destroy(this.st_5)
destroy(this.sle_password)
destroy(this.st_4)
destroy(this.st_um_pack)
destroy(this.sle_qty_packed)
destroy(this.st_qty_pack)
destroy(this.st_um2)
destroy(this.st_um)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.sle_new_qty)
destroy(this.st_3)
destroy(this.sle_orig_qty)
destroy(this.st_2)
destroy(this.sle_part)
destroy(this.st_1)
destroy(this.gb_1)
end on

type sle_operator from singlelineedit within w_update_detail_qty
integer x = 517
integer y = 208
integer width = 521
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
boolean border = false
boolean autohscroll = false
boolean displayonly = true
end type

type st_5 from statictext within w_update_detail_qty
integer x = 137
integer y = 208
integer width = 247
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Code"
boolean focusrectangle = false
end type

type sle_password from singlelineedit within w_update_detail_qty
integer x = 517
integer y = 92
integer width = 521
integer height = 88
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean border = false
boolean autohscroll = false
boolean password = true
end type

event modified;sle_new_qty.Enabled = false
cb_1.Enabled = false

String szPass, szCode
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

sle_new_qty.Enabled = true
sle_new_qty.SetFocus()
cb_1.Enabled = true

end event

type st_4 from statictext within w_update_detail_qty
integer x = 137
integer y = 100
integer width = 283
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Operator"
boolean focusrectangle = false
end type

type st_um_pack from statictext within w_update_detail_qty
integer x = 1097
integer y = 472
integer width = 128
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "UM"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_qty_packed from singlelineedit within w_update_detail_qty
integer x = 517
integer y = 556
integer width = 535
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 77897888
boolean enabled = false
boolean border = false
boolean autohscroll = false
end type

type st_qty_pack from statictext within w_update_detail_qty
integer x = 137
integer y = 548
integer width = 366
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "Qty Packed"
boolean focusrectangle = false
end type

type st_um2 from statictext within w_update_detail_qty
integer x = 1097
integer y = 560
integer width = 128
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "UM"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_um from statictext within w_update_detail_qty
integer x = 1097
integer y = 384
integer width = 128
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "UM"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_update_detail_qty
integer x = 987
integer y = 832
integer width = 256
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
boolean cancel = true
end type

on clicked;Close(parent)
end on

type cb_1 from commandbutton within w_update_detail_qty
integer x = 677
integer y = 832
integer width = 247
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Ok"
end type

event clicked;Boolean bUpdate

bUpdate	= TRUE

If  (Not IsNumber(sle_new_qty.text)) OR (Dec(sle_new_qty.text) < 0) then
	MessageBox("Warning", "Invalid Data Entry")
	Return
End If
	
If Dec(sle_new_qty.text) = 0 then
	If MessageBox("Warning", "This will delete the current line item" + "~rOk to continue", StopSign!, YesNo!) = 2 then
		bUpdate	= 	FALSE
	End If
End If

If bUpdate then
	wf_reset_picklist_flag()
	w_shipping_dock.wf_set_detail_qty(sle_operator.Text, Dec(sle_new_qty.text))
	close(w_update_detail_qty)
End If

end event

type sle_new_qty from singlelineedit within w_update_detail_qty
integer x = 517
integer y = 672
integer width = 535
integer height = 88
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
boolean border = false
boolean autohscroll = false
end type

event modified;cb_1.Default = true

end event

type st_3 from statictext within w_update_detail_qty
integer x = 137
integer y = 664
integer width = 366
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "New Qty"
boolean focusrectangle = false
end type

type sle_orig_qty from singlelineedit within w_update_detail_qty
integer x = 517
integer y = 440
integer width = 535
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 77897888
boolean enabled = false
boolean border = false
boolean autohscroll = false
end type

type st_2 from statictext within w_update_detail_qty
integer x = 137
integer y = 432
integer width = 366
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "Original Qty"
boolean focusrectangle = false
end type

type sle_part from singlelineedit within w_update_detail_qty
integer x = 517
integer y = 324
integer width = 635
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 77897888
boolean enabled = false
boolean border = false
boolean autohscroll = false
end type

type st_1 from statictext within w_update_detail_qty
integer x = 137
integer y = 316
integer width = 247
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "Part"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_update_detail_qty
integer x = 73
integer width = 1189
integer height = 808
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
end type

