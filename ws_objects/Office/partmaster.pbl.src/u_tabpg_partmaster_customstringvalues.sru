$PBExportHeader$u_tabpg_partmaster_customstringvalues.sru
forward
global type u_tabpg_partmaster_customstringvalues from u_tabpg_dw
end type
type cb_new from commandbutton within u_tabpg_partmaster_customstringvalues
end type
end forward

global type u_tabpg_partmaster_customstringvalues from u_tabpg_dw
integer width = 2350
cb_new cb_new
end type
global u_tabpg_partmaster_customstringvalues u_tabpg_partmaster_customstringvalues

type variables

string CustomFieldName

end variables

forward prototypes
public function integer newstringvalue ()
end prototypes

public function integer newstringvalue ();
long newRow
newRow = dw_1.InsertRow(0)
dw_1.object.CustomFieldName[newRow] = CustomFieldName
return newRow

end function

on u_tabpg_partmaster_customstringvalues.create
int iCurrent
call super::create
this.cb_new=create cb_new
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_new
end on

on u_tabpg_partmaster_customstringvalues.destroy
call super::destroy
destroy(this.cb_new)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_new.X + (cb_new.X - gb_1.X - gb_1.Width) + cb_new.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_new, 100, 0, 0, 0)

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_partmaster_customstringvalues
string text = "Values"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_partmaster_customstringvalues
string dataobject = "d_dbo_partmaster_customstringvalues"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(CustomFieldName)

end event

event dw_1::updateend;call super::updateend;
//	Commit changes.
commit using sqlca  ;

end event

type cb_new from commandbutton within u_tabpg_partmaster_customstringvalues
integer x = 1806
integer y = 8
integer width = 407
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "New Value"
end type

event clicked;
NewStringValue()

end event

