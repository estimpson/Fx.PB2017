$PBExportHeader$w_part_package_materials.srw
forward
global type w_part_package_materials from w_sheet_4t
end type
type sle_2 from singlelineedit within w_part_package_materials
end type
type sle_1 from singlelineedit within w_part_package_materials
end type
type dw_2 from datawindow within w_part_package_materials
end type
type dw_1 from datawindow within w_part_package_materials
end type
end forward

global type w_part_package_materials from w_sheet_4t
integer height = 1560
string title = "Packaging Materials Setup"
string menuname = "m_part_package_materials"
sle_2 sle_2
sle_1 sle_1
dw_2 dw_2
dw_1 dw_1
end type
global w_part_package_materials w_part_package_materials

type variables
String szPart, szCode, szUnit1, szUnit2

Boolean bDw1, bDw2, bDrag
Boolean		ib_Open
end variables

event activate;call super::activate;IF ib_Open THEN
	If szReturnedString <> "-1" Then &
		dw_1.Retrieve ( szPart )
	ib_Open = FALSE
END IF
end event

event open;call super::open;szPart = Message.StringParm

this.title = this.title + "  Part: " + szpart

dw_1.SetTransObject ( sqlca )
dw_2.SetTransObject ( sqlca )

dw_1.Retrieve ( szPart )
dw_2.Retrieve ( )

end event

on w_part_package_materials.create
int iCurrent
call super::create
if this.MenuName = "m_part_package_materials" then this.MenuID = create m_part_package_materials
this.sle_2=create sle_2
this.sle_1=create sle_1
this.dw_2=create dw_2
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_2
this.Control[iCurrent+2]=this.sle_1
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.dw_1
end on

on w_part_package_materials.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.dw_2)
destroy(this.dw_1)
end on

type sle_2 from singlelineedit within w_part_package_materials
integer x = 1463
integer y = 32
integer width = 1385
integer height = 96
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean enabled = false
string text = "Standard Packaging Materials"
boolean autohscroll = false
borderstyle borderstyle = styleraised!
end type

type sle_1 from singlelineedit within w_part_package_materials
integer x = 37
integer y = 32
integer width = 1385
integer height = 96
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean enabled = false
string text = "Package Materials For Part"
boolean autohscroll = false
borderstyle borderstyle = styleraised!
end type

type dw_2 from datawindow within w_part_package_materials
integer x = 1463
integer y = 128
integer width = 1385
integer height = 1280
integer taborder = 20
string dragicon = "MONITOR.ICO"
string dataobject = "d_packaging_materials"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

on dragdrop;bDrag = True

If bDw1 = True Then
	bDw1 = False
Else
	Return
End if

  DELETE FROM part_packaging  
   WHERE ( part = :szPart ) AND  
         ( code = :szCode )   ;

If SQLCA.SQLCode = -1 Then
	RollBack ;
Else
	Commit ;
End if

dw_1.Reset ( )
dw_1.Retrieve ( szPart )
end on

on clicked;Long lRow

lRow = dw_2.GetClickedRow ( )

If lRow < 1 Then Return


SelectRow ( dw_2, 0, False )
SelectRow ( dw_2, lRow, True )

szCode = dw_2.GetItemString ( lRow, "package_materials_code" )

bDw2 = True
dw_2.Drag ( Begin! )


end on

type dw_1 from datawindow within w_part_package_materials
integer x = 37
integer y = 128
integer width = 1385
integer height = 1280
integer taborder = 10
string dragicon = "MONITOR.ICO"
string dataobject = "d_packaging_per_part"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

on doubleclicked;st_generic_structure	str_Parm
Long lRow

lRow = dw_1.GetClickedRow ( )

If lRow < 1 Then Return

SelectRow ( dw_1, 0, False )
SelectRow ( dw_1, lRow, True )

szCode = dw_1.GetItemString ( lRow, "package_materials_code" )

str_Parm.Value1 = szPart
str_Parm.Value2 = szCode

ib_Open = TRUE

OpenWithParm ( w_package_qty, str_Parm )
end on

event dragdrop;st_generic_structure	str_Parm

bDrag = True

If bDw2 = True Then
	bDw2 = False
Else
	Return
End if

If dw_1.Find ( "package_materials_code = ~"" + szCode + "~"", 1, dw_1.RowCount ( ) ) > 0 Then
	MessageBox ( "Error", "You Can Not Add Same~rCode To Packaging List!", StopSign! )
	Return
End if

str_Parm.Value1 = szPart
str_Parm.Value2 = szCode
str_Parm.Value3 = "Add"

ib_Open = TRUE

OpenWithParm ( w_package_qty, str_Parm )


end event

on clicked;Long lRow

lRow = dw_1.GetClickedRow ( )

If lRow < 1 Then Return

SelectRow ( dw_1, 0, False )
SelectRow ( dw_1, lRow, True )

szCode = dw_1.GetItemString ( lRow, "package_materials_code" )

bDw1 = True
dw_1.Drag ( Begin! )
end on

