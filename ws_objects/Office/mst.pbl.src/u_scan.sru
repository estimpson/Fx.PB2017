$PBExportHeader$u_scan.sru
$PBExportComments$Ancestor user object for scanning object.
forward
global type u_scan from userobject
end type
type mle_title from multilineedit within u_scan
end type
type cb_1 from commandbutton within u_scan
end type
type sle_serial from singlelineedit within u_scan
end type
type st_name from statictext within u_scan
end type
type ddlb_part from dropdownlistbox within u_scan
end type
end forward

global type u_scan from userobject
integer width = 983
integer height = 636
boolean border = true
long backcolor = 16776960
mle_title mle_title
cb_1 cb_1
sle_serial sle_serial
st_name st_name
ddlb_part ddlb_part
end type
global u_scan u_scan

type variables
Private:

Window	i_w_ParentWindow
end variables

forward prototypes
public subroutine uf_set_title_and_name (string l_s_title, string l_s_name)
end prototypes

public subroutine uf_set_title_and_name (string l_s_title, string l_s_name);mle_Title.text	= l_s_Title
st_Name.text	= l_s_Name

sle_serial.SetFocus()

//ddlb_part.SetFocus()

end subroutine

on constructor;i_w_ParentWindow	= Parent
//
//String s_part
//int    i_no
//
//DECLARE part_cur CURSOR FOR
//	SELECT part.part
//	  FROM part ; 
//
//OPEN part_cur ;
//
//FETCH part_cur INTO :s_part ;
//
//IF sqlca.sqlcode <> 0 then
//   messagebox("System Message","Parts doesn't exist in the database")
//   return
//END if
//
//Do 
//	i_no = ddlb_part.additem(s_part) 
//   
//	FETCH next part_cur INTO :s_part ;
//
//Loop while (sqlca.sqlcode = 0)
//
//CLOSE part_cur ;
//
end on

on u_scan.create
this.mle_title=create mle_title
this.cb_1=create cb_1
this.sle_serial=create sle_serial
this.st_name=create st_name
this.ddlb_part=create ddlb_part
this.Control[]={this.mle_title,&
this.cb_1,&
this.sle_serial,&
this.st_name,&
this.ddlb_part}
end on

on u_scan.destroy
destroy(this.mle_title)
destroy(this.cb_1)
destroy(this.sle_serial)
destroy(this.st_name)
destroy(this.ddlb_part)
end on

event destructor;
//	Prevent "CAPS" windows message from appearing when the form is closing.
st_name.SetFocus()

end event

type mle_title from multilineedit within u_scan
integer x = 37
integer y = 16
integer width = 805
integer height = 176
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16776960
boolean enabled = false
boolean border = false
alignment alignment = center!
end type

type cb_1 from commandbutton within u_scan
integer x = 585
integer y = 368
integer width = 247
integer height = 108
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Exit"
end type

on clicked;i_w_ParentWindow.PostEvent("ue_close_uo_scan")
end on

type sle_serial from singlelineedit within u_scan
integer x = 475
integer y = 224
integer width = 439
integer height = 80
integer taborder = 1
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

event modified;i_w_ParentWindow.PostEvent("ue_scan")



end event

type st_name from statictext within u_scan
integer x = 18
integer y = 224
integer width = 366
integer height = 64
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16776960
boolean enabled = false
string text = "Name"
boolean focusrectangle = false
end type

type ddlb_part from dropdownlistbox within u_scan
boolean visible = false
integer x = 18
integer y = 512
integer width = 933
integer height = 384
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean vscrollbar = true
integer limit = 5
end type

on selectionchanged;//sle_serial.text = this.text
//i_w_ParentWindow.PostEvent("ue_scan")
//
end on

