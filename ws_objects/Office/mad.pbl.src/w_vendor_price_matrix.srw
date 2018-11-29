$PBExportHeader$w_vendor_price_matrix.srw
forward
global type w_vendor_price_matrix from w_sheet_4t
end type
type st_add_title from statictext within w_vendor_price_matrix
end type
type dw_add_profile from datawindow within w_vendor_price_matrix
end type
type cb_add_cancel from commandbutton within w_vendor_price_matrix
end type
type cb_add_ok from commandbutton within w_vendor_price_matrix
end type
type cb_add_back from commandbutton within w_vendor_price_matrix
end type
type st_2 from statictext within w_vendor_price_matrix
end type
type st_1 from statictext within w_vendor_price_matrix
end type
type lb_temp from listbox within w_vendor_price_matrix
end type
type dw_part_info from datawindow within w_vendor_price_matrix
end type
type dw_vendor_part_list from datawindow within w_vendor_price_matrix
end type
type dw_price_matrix from datawindow within w_vendor_price_matrix
end type
end forward

global type w_vendor_price_matrix from w_sheet_4t
integer width = 3342
integer height = 2056
string title = "Vendor Price Matrix"
string menuname = "m_vendor_price_matrix_menu"
event add_item pbm_custom01
event add_price pbm_custom02
event save_item pbm_custom04
event delete_vendor pbm_custom03
event delete_price pbm_custom05
event ue_exit pbm_custom06
st_add_title st_add_title
dw_add_profile dw_add_profile
cb_add_cancel cb_add_cancel
cb_add_ok cb_add_ok
cb_add_back cb_add_back
st_2 st_2
st_1 st_1
lb_temp lb_temp
dw_part_info dw_part_info
dw_vendor_part_list dw_vendor_part_list
dw_price_matrix dw_price_matrix
end type
global w_vendor_price_matrix w_vendor_price_matrix

type variables
String is_Part

Dec dBreakQty    // Current Break Qty Displayed

Long lRow

Boolean 	bAdd, &
	ib_vend_save_change = TRUE, &
	ib_Price_save_change = TRUE

DataWindowChild dwcUnitList
end variables

forward prototypes
public function boolean wf_find_po_detail (string vendor, string part)
public subroutine wf_get_units (string part)
public subroutine wf_add_mode (boolean bmode)
public subroutine wf_screen_mode (boolean bmode)
end prototypes

event add_item;dw_add_profile.Modify("vendor.tabsequence = 10")
wf_add_mode ( True )
end event

event add_price;String	ls_Vendor
Dec	ld_Price
Dec	ld_cost

If dw_vendor_part_list.RowCount ( ) < 1 Then

	MessageBox ( "Error", "No vendors exist for adding price matrix!", StopSign! )
	Return

Elseif dw_vendor_part_list.GetRow ( ) < 1 Or Not dw_vendor_part_list.IsSelected ( dw_vendor_part_list.GetRow ( ) ) Then

	MessageBox ( "Error", "Please select a vendor to add price matrix to!", StopSign! )
	Return

End if

ls_Vendor = dw_vendor_part_list.GetItemString ( dw_vendor_part_list.GetRow ( ), "vendor" )

SelectRow ( dw_price_matrix, 0, False )

SELECT	price,
	cost_cum
INTO	:ld_Price,
	:ld_cost
FROM	part_standard  
WHERE	part = :is_Part;

dw_price_matrix.InsertRow ( 0 )
dw_price_matrix.SetItem ( dw_price_matrix.RowCount ( ), 2, 0 )
dw_price_matrix.SetItem ( dw_price_matrix.RowCount ( ), "vendor", ls_Vendor )
dw_price_matrix.SetItem ( dw_price_matrix.RowCount ( ), "part", is_Part )
dw_price_matrix.SetItem ( dw_price_matrix.RowCount ( ), "alternate_price", ld_Price )
dw_price_matrix.SetItem ( dw_price_matrix.RowCount ( ), "part_standard_cost_cum", ld_cost )

dw_price_matrix.SetRow ( dw_price_matrix.RowCount ( ) )
dw_price_matrix.SetColumn(1)
dw_price_matrix.SetFocus ( )
end event

on save_item;Long l_Row

Int  i_Count

Int  i_qty

/* Routine to check if the qty break is < zero */

If dw_price_matrix.AcceptText ( ) = -1 Then Return

For i_Count = 1 to dw_price_matrix.RowCount ( ) 

   i_qty = dw_price_matrix.GetItemNumber ( i_Count, "break_qty" )

	If IsNull(String(i_qty)) Then

	   MessageBox ( "DataWindow Error", "'Qty Break' cannot be null!", Exclamation!)
      dw_price_matrix.SetRow ( i_Count )
      Return
  
   End If

Next

/* Save Routine */

If dw_vendor_part_list.Update ( ) = -1 Then

	RollBack ;
	w_vendor_price_matrix.SetMicroHelp ( "Save of vendor/part list failed!" )

Else

	If dw_price_matrix.Update ( ) = -1 Then
		RollBack ;
		w_vendor_price_matrix.SetMicroHelp ( "Save of price matrix failed!" )
	Else
		Commit ;
      ib_price_save_change = True
      w_vendor_price_matrix.SetMicroHelp ( "Price Matrix saved..." )
	End if

End if
end on

on delete_vendor;//  Declare Variables
Long		ll_Row
String	ls_Vendor
Int		li_RtnCode
Boolean	bDeleteMatrix

//  Initialize Variables
ll_Row = dw_vendor_part_list.GetRow ( )

//  Main
If ll_Row < 1 Then
	w_vendor_price_matrix.SetMicroHelp ( "You must select a vendor to delete!" )
	Return
End if

ls_Vendor = dw_vendor_part_list.GetItemString ( ll_Row, "vendor" )

If dw_price_matrix.RowCount ( ) > 0 Then
	li_RtnCode = MessageBox ( "Delete Vendor", "Are you sure about deleting " + ls_Vendor + "~r and the price matrix associated with them?", Question!, YesNo!, 2 )
	bDeleteMatrix = True
Else
	li_RtnCode = MessageBox ( "Delete Vendor", "Are you sure about deleting " + ls_Vendor + "?", Question!, YesNo!, 2 )
End if


If li_RtnCode = 1 Then
	If bDeleteMatrix Then
		DELETE FROM part_vendor_price_matrix  
		 WHERE ( vendor = :ls_Vendor ) AND  
       		 ( part = :is_Part )   ;

		If SQLCA.SQLCode <> 0 Then
			RollBack ;
			w_vendor_price_matrix.SetMicroHelp( "Deletion of price matrix failed!  Unable to delete vendor." )
			Return
		End if
	End if
		DELETE FROM part_vendor  
		 WHERE ( part = :is_Part ) AND  
		       ( vendor = :ls_Vendor )   ;

		If SQLCA.SQLCode <> 0 Then
			RollBack ;
			w_vendor_price_matrix.SetMicroHelp ( "Deletion of vendor " + ls_Vendor + " failed!")
			Return
		Else
			Commit ;
		End if	

	dw_vendor_part_list.Retrieve ( is_Part )
	If bDeleteMatrix Then dw_price_matrix.Retrieve ( is_Part, ls_Vendor )

End if


end on

on delete_price;//  Declare Variables
Long	ll_Row
Int	li_RtnCode
Dec	{2} ld_BreakQty

//  Initialize Variables
ll_Row = dw_price_matrix.GetRow ( )

//  Main
If ll_Row < 1 Then
	w_vendor_price_matrix.SetMicroHelp ( "You must choose a break quantity to delete!" )
	Return
End if

ld_BreakQty = f_get_value ( dw_price_matrix.GetItemNumber ( ll_Row, "break_qty" ) )
li_RtnCode = MessageBox ( "Delete Break Quantity", "Are you sure about deleting break quantity ~r " + String ( ld_BreakQty ) + "?", Question!, YesNo!, 2 )

If li_RtnCode = 1 Then
	dw_price_matrix.DeleteRow ( ll_Row )
	If dw_price_matrix.Update ( ) = -1 Then
		RollBack ;
		w_vendor_price_matrix.SetMicroHelp ( "Deletion of break quantity failed!" )
	Else
		Commit ;
	End if
End if
end on

on ue_exit;Integer imess1, imess2

If NOT ib_vend_save_change Then
	imess1 = Messagebox ("Warning", "Do you want to save the changes?", &
								Exclamation!, YesNoCancel!, 1)
	If imess1 = 1 Then
      cb_add_ok.TriggerEvent ( Clicked! )

	Elseif imess1 = 2 Then
		ib_vend_save_change= TRUE

	Else
		Return

	End If
End If

If NOT ib_price_save_change Then
	imess2 = Messagebox ("Warning", "Do you want to save the changes?", &
								Exclamation!, YesNoCancel!, 1)
	If imess2 = 1 Then
      w_vendor_price_matrix.TriggerEvent ( "save_item" )

	Elseif imess2 = 2 Then
		ib_price_save_change = TRUE

	Else
		Return

	End If
End If

If ib_vend_save_change AND ib_price_save_change Then

	Close (This)

End If
end on

public function boolean wf_find_po_detail (string vendor, string part);Long	ll_Temp

SELECT po_number  
  INTO :ll_Temp  
  FROM po_detail  
 WHERE ( vendor_code = :vendor ) AND  
       ( part_number = :part )   ;

If SQLCA.SQLCode <> 0 Then
	Return False
Else
	Return True
End if
end function

public subroutine wf_get_units (string part);Int	li_count

lb_temp.Reset ( )
dwcUnitList.SetTransObject ( sqlca )
dwcUnitList.Reset ( )

lb_temp = f_get_units_for_part ( "", Part, lb_temp )

For li_count = 1 to lb_temp.TotalItems ( )
	lb_temp.SelectItem ( li_count )
	dwcUnitList.InsertRow ( 0 )
	dwcUnitList.SetItem ( dwcUnitList.RowCount ( ), "data", lb_temp.SelectedItem ( ) )
Next
end subroutine

public subroutine wf_add_mode (boolean bmode);If bMode Then
	wf_screen_mode ( False )
	cb_add_back.Show ( )
	cb_add_ok.Show ( )
	cb_add_cancel.Show ( )
	st_add_title.Show ( )
	dw_add_profile.SetTransObject ( sqlca )
	dw_add_profile.InsertRow ( 1 )
	dw_add_profile.Show ( )
	dw_add_profile.SetFocus ( )
Else
	cb_add_ok.Hide ( )
	cb_add_cancel.Hide ( )
	st_add_title.Hide ( )
	dw_add_profile.Hide ( )
	cb_add_back.Hide ( )
	wf_screen_mode ( True )
End if
end subroutine

public subroutine wf_screen_mode (boolean bmode);dw_vendor_part_list.Enabled = bMode
dw_price_matrix.Enabled = bMode
m_vendor_price_matrix_menu.m_file.m_add.Enabled = bMode
m_vendor_price_matrix_menu.m_file.m_addprice.Enabled = bMode
m_vendor_price_matrix_menu.m_file.m_delete.Enabled = bMode
m_vendor_price_matrix_menu.m_file.m_deleteprice.Enabled = bMode
m_vendor_price_matrix_menu.m_file.m_save.Enabled = bMode
m_vendor_price_matrix_menu.m_file.m_close.Enabled = bMode

end subroutine

event open;call super::open;
//  Set Hourglass
SetPointer ( HourGlass! )

//  Declare Local Variables
String	ls_Vendor

//  Initialize Variables
is_Part = Message.StringParm

//  Declare DataWindows
dw_vendor_part_list.SetTransObject ( sqlca )
dw_price_matrix.SetTransObject ( sqlca )
dw_part_info.SetTransObject ( sqlca )

dw_part_info.Retrieve ( is_Part )

dw_add_profile.GetChild ( "receiving_um", dwcUnitList )
wf_get_units ( is_Part )

//
//  Retrieve All Of the Possible Combos
//

If dw_vendor_part_list.Retrieve ( is_Part ) > 0 Then
	dw_vendor_part_list.SetRow ( 1 )
	SelectRow ( dw_vendor_part_list, 1, True )
	ls_Vendor = f_get_string_value ( dw_vendor_part_list.GetItemString ( 1, "vendor" ) )
	dw_price_matrix.Retrieve ( is_Part, ls_Vendor )
End if
end event

on w_vendor_price_matrix.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_vendor_price_matrix_menu" then this.MenuID = create m_vendor_price_matrix_menu
this.st_add_title=create st_add_title
this.dw_add_profile=create dw_add_profile
this.cb_add_cancel=create cb_add_cancel
this.cb_add_ok=create cb_add_ok
this.cb_add_back=create cb_add_back
this.st_2=create st_2
this.st_1=create st_1
this.lb_temp=create lb_temp
this.dw_part_info=create dw_part_info
this.dw_vendor_part_list=create dw_vendor_part_list
this.dw_price_matrix=create dw_price_matrix
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_add_title
this.Control[iCurrent+2]=this.dw_add_profile
this.Control[iCurrent+3]=this.cb_add_cancel
this.Control[iCurrent+4]=this.cb_add_ok
this.Control[iCurrent+5]=this.cb_add_back
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.lb_temp
this.Control[iCurrent+9]=this.dw_part_info
this.Control[iCurrent+10]=this.dw_vendor_part_list
this.Control[iCurrent+11]=this.dw_price_matrix
end on

on w_vendor_price_matrix.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_add_title)
destroy(this.dw_add_profile)
destroy(this.cb_add_cancel)
destroy(this.cb_add_ok)
destroy(this.cb_add_back)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.lb_temp)
destroy(this.dw_part_info)
destroy(this.dw_vendor_part_list)
destroy(this.dw_price_matrix)
end on

type st_add_title from statictext within w_vendor_price_matrix
boolean visible = false
integer x = 338
integer y = 432
integer width = 997
integer height = 84
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Add Part / Vendor Profile"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_add_profile from datawindow within w_vendor_price_matrix
boolean visible = false
integer x = 247
integer y = 524
integer width = 2519
integer height = 644
integer taborder = 80
string dataobject = "d_add_vendor_part_profile"
boolean border = false
end type

on editchanged;ib_vend_save_change = False
end on

on itemerror;dw_add_profile.SetText ( "" )
end on

on itemchanged;ib_vend_save_change = False
end on

event constructor;settransobject(sqlca)
end event

type cb_add_cancel from commandbutton within w_vendor_price_matrix
boolean visible = false
integer x = 869
integer y = 1184
integer width = 293
integer height = 100
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancel"
end type

on clicked;ib_vend_save_change = TRUE

wf_add_mode ( False )
end on

type cb_add_ok from commandbutton within w_vendor_price_matrix
boolean visible = false
integer x = 507
integer y = 1184
integer width = 293
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Ok"
boolean default = true
end type

event clicked;String	ls_Vendor
String	ls_VendorPart
Long		ll_Row

dw_add_profile.SetItem ( 1, "part", is_Part )

If dw_add_profile.AcceptText ( ) = -1 Then 
   dw_add_profile.SetFocus ( )
	Return 
End If

ls_Vendor = dw_add_profile.GetItemString ( 1, "vendor" )
ls_VendorPart = dw_add_profile.GetItemString ( 1, "vendor_part" )

wf_add_mode ( False )

If dw_add_profile.Update ( ) = -1 Then
	RollBack ;
Else
	Commit ;
   ib_vend_save_change = True
End if

If dw_vendor_part_list.Retrieve ( is_Part ) > 0 Then
	ll_Row = dw_vendor_part_list.Find ( "vendor = '" + ls_Vendor + "' and " + &
		"vendor_part = '" + ls_VendorPart + "'", 1, dw_vendor_part_list.RowCount ( ) )
	If ll_Row > 0 Then
		dw_vendor_part_list.SetRow ( ll_Row )
		SelectRow ( dw_vendor_part_list, 0, False )
		SelectRow ( dw_vendor_part_list, ll_Row, True )
		dw_price_matrix.Retrieve ( is_Part, ls_Vendor )
	End if
End if

end event

type cb_add_back from commandbutton within w_vendor_price_matrix
boolean visible = false
integer x = 238
integer y = 392
integer width = 2565
integer height = 928
integer taborder = 70
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
end type

type st_2 from statictext within w_vendor_price_matrix
integer x = 1335
integer y = 124
integer width = 1486
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Price Matrix"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_1 from statictext within w_vendor_price_matrix
integer x = 18
integer y = 128
integer width = 1280
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Part / Vendor List"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type lb_temp from listbox within w_vendor_price_matrix
boolean visible = false
integer x = 823
integer y = 720
integer width = 494
integer height = 360
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type dw_part_info from datawindow within w_vendor_price_matrix
integer x = 37
integer y = 16
integer width = 1262
integer height = 96
integer taborder = 10
boolean enabled = false
string dataobject = "d_vendor_matrix_part_info"
boolean border = false
end type

type dw_vendor_part_list from datawindow within w_vendor_price_matrix
integer x = 14
integer y = 204
integer width = 1280
integer height = 1200
integer taborder = 60
string dataobject = "d_part_vendor_list_for_matrix"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;String	s_vendor

//	Initialize Variables

If row < 1 Then Return

s_vendor = This.GetItemString ( row, "vendor" ) 

dw_price_matrix.Retrieve ( is_Part, s_vendor )

cb_add_back.Show ( )
cb_add_ok.Show ( )
cb_add_cancel.Show ( )
st_add_title.Show ( )
dw_add_profile.Show ( )
dw_add_profile.SetFocus ( )

dw_add_profile.Retrieve ( s_vendor, is_Part )
dw_add_profile.Modify("vendor.tabsequence = 0")
end event

on itemchanged;ib_vend_save_change = FALSE
end on

on editchanged;ib_vend_save_change = FALSE
end on

event clicked;//	Declare Local Variables
String	ls_Vendor

//	Initialize Variables
SelectRow ( This, 0, False )
If row < 1 Then Return
SelectRow ( This, row, True )
ls_Vendor = f_get_string_value ( This.GetItemString ( row, "vendor" ) )
dw_price_matrix.SetTransObject ( sqlca )
dw_price_matrix.Retrieve ( is_Part, ls_Vendor )

end event

type dw_price_matrix from datawindow within w_vendor_price_matrix
integer x = 1335
integer y = 208
integer width = 1486
integer height = 1200
integer taborder = 20
string dataobject = "d_part_vendor_price_matrix"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

on itemchanged;ib_price_save_change = FALSE
end on

on itemerror;dw_price_matrix.SetText ( "" )
end on

event clicked;//  Declare Variables
Long	ll_Row

//  Initialize Variables
ll_Row = This.GetClickedRow ( )

//  Main
If row< 1 Then Return

//This.SetRow ( row )

SelectRow ( This, 0, False )
SelectRow ( This, row, True )


end event

on editchanged;ib_price_save_change = FALSE
end on

event constructor;this.settransobject(sqlca)
end event

