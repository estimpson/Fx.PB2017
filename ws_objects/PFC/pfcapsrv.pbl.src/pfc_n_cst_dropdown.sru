$PBExportHeader$pfc_n_cst_dropdown.sru
$PBExportComments$PFC DropDown Object service
forward
global type pfc_n_cst_dropdown from n_base
end type
end forward

global type pfc_n_cst_dropdown from n_base
end type
global pfc_n_cst_dropdown pfc_n_cst_dropdown

type variables
Protected:
userobject iu_requestor

Constant Integer DWSTYLE_BOX = 1
Constant Integer DWSTYLE_SHADOWBOX = 2
Constant Integer DWSTYLE_LOWERED = 3
Constant Integer DWSTYLE_RAISED = 4
Constant Integer STYLE_BOX = 5
Constant Integer STYLE_SHADOWBOX = 6
Constant Integer STYLE_LOWERED = 7
Constant Integer STYLE_RAISED = 8
Constant Integer DW_HSPLITBAR_WIDTH = 9
Constant Integer TAB_BORDER = 10
Constant Integer MISC_XPOSITION = 11
Constant Integer MISC_YPOSITION = 12
Constant Integer DWMISC_XPOSITION = 13
Constant Integer DWMISC_YPOSITION = 14
Constant Integer DWDETAIL_HEIGHT = 15
Constant Integer BORDER_CHECK = 16
end variables

forward prototypes
public function integer of_getparentposition (dragobject adrg_object, ref integer ai_x, ref integer ai_y)
protected function integer of_getparentwindow (dragobject adrg_object, ref window aw_parent)
protected function integer of_getsystemsetting (integer ai_option)
public function integer of_setrequestor (userobject au_requestor)
public function integer of_position (dragobject adrg_object, boolean ab_makevisible)
end prototypes

public function integer of_getparentposition (dragobject adrg_object, ref integer ai_x, ref integer ai_y);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetParentPosition
//
//	Access:  		public
//
//	Arguments:
//	adrg_object			The dragobject whose parent position is needed.
//	al_x(by reference) The x coordinate for the parent.
//	al_y(by reference) The y coordinate for the parent.
//
//	Returns:  		Integer
//						1 if it succeeds and -1 if an error occurs.
//
//	Description:	Calculates the parent position in relationship to the window.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

PowerObject	lpo_parent
UserObject	luo_parent
Tab			ltab_parent
Integer		li_parentx, li_parenty
Integer		li_x, li_y
Integer		li_border

// Validate required reference.
If IsNull(adrg_object) or Not IsValid(adrg_object) Then
	Return -1
End If

// Loop getting the parent of the object until it is of type window!
lpo_parent = adrg_object.GetParent()
do while IsValid (lpo_parent)
	If lpo_parent.TypeOf() = window! Then
		Exit
	End If
	li_border = 0
	CHOOSE CASE TypeOf(lpo_parent)
		CASE UserObject!
			luo_parent = lpo_parent
			li_parentx = luo_parent.X 
			li_parenty = luo_parent.Y 
			// Determine the Left/Upper Border.
			If luo_parent.Border Then
				CHOOSE CASE luo_parent.BorderStyle
					CASE StyleBox!
						li_border = of_GetSystemSetting(STYLE_BOX)
					CASE StyleShadowBox!
						li_border = of_GetSystemSetting(STYLE_SHADOWBOX)
					CASE StyleLowered!
						li_border = of_GetSystemSetting(STYLE_LOWERED)
					CASE StyleRaised!		
						li_border = of_GetSystemSetting(STYLE_RAISED)
				END CHOOSE				
			End If			
		CASE Tab!
			ltab_parent = lpo_parent
			li_parentx = ltab_parent.X 
			li_parenty = ltab_parent.Y 
			li_border = of_GetSystemSetting(TAB_BORDER)
	END CHOOSE
	li_x += li_parentx + li_border
	li_y += li_parenty + li_border
	lpo_parent = lpo_parent.GetParent()
loop

if not IsValid (lpo_parent) then
	Return -1
end If

ai_x = li_x
ai_y = li_y
Return 1


end function

protected function integer of_getparentwindow (dragobject adrg_object, ref window aw_parent);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetParentWindow
//
//	Access:  protected
//
//	Arguments:
//	adrg_object	The dragobject for which to find the parent window.
//	aw_parent   The Parent window for this object (passed by reference).
//	   If a parent window is not found, aw_parent is NULL
//
//	Returns:  integer
//	 1 = success
//	-1 = error
//
//	Description:	 Calculates the parent window of a window object
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

powerobject	lpo_parent

lpo_parent = adrg_object.GetParent()

// Loop getting the parent of the object until it is of type window!
do while IsValid (lpo_parent) 
	if lpo_parent.TypeOf() <> window! then
		lpo_parent = lpo_parent.GetParent()
	else
		exit
	end if
loop

if IsNull(lpo_parent) Or not IsValid (lpo_parent) then
	setnull(aw_parent)	
	return -1
end If

aw_parent = lpo_parent
return 1

end function

protected function integer of_getsystemsetting (integer ai_option);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetSystemSetting
//
//	Scope:	Protected
//
//	Arguments:
//		ai_option	The name of the desired setting.
//
//	Returns:  Integer
//		The setting.
//
//	Description:  Get the platform specific setting.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Environment lenv_object

GetEnvironment(lenv_object)

If lenv_object.ostype = Windows! Then

	CHOOSE CASE ai_option
		CASE DWSTYLE_BOX
			Return 3
		CASE DWSTYLE_SHADOWBOX
			Return 3			
		CASE DWSTYLE_LOWERED
			Return 6			
		CASE DWSTYLE_RAISED
			Return 6		
		CASE DWDETAIL_HEIGHT
			Return 0
			Return -1
		CASE STYLE_BOX
			Return 3			
		CASE STYLE_SHADOWBOX
			Return 3			
		CASE STYLE_LOWERED
			Return 6					
		CASE STYLE_RAISED
			Return 6			
		CASE DW_HSPLITBAR_WIDTH
			Return 12					
		CASE TAB_BORDER
			Return 0		
		CASE MISC_XPOSITION
			Return 0						
		CASE MISC_YPOSITION
			Return 0		
		CASE DWMISC_XPOSITION
			Return 0						
		CASE DWMISC_YPOSITION
			Return 3			
		CASE BORDER_CHECK 			
			Return 3
	END CHOOSE

Else
	CHOOSE CASE ai_option
		CASE DWSTYLE_BOX
			Return 3
		CASE DWSTYLE_SHADOWBOX
			Return 3			
		CASE DWSTYLE_LOWERED
			Return 6			
		CASE DWSTYLE_RAISED
			Return 6		
		CASE DWDETAIL_HEIGHT
			Return 0
			Return -1
		CASE STYLE_BOX
			Return 3			
		CASE STYLE_SHADOWBOX
			Return 3			
		CASE STYLE_LOWERED
			Return 6					
		CASE STYLE_RAISED
			Return 6			
		CASE DW_HSPLITBAR_WIDTH
			Return 12					
		CASE TAB_BORDER
			Return 0		
		CASE MISC_XPOSITION
			Return 0						
		CASE MISC_YPOSITION
			Return 0		
		CASE DWMISC_XPOSITION
			Return 0						
		CASE DWMISC_YPOSITION
			Return 3			
		CASE BORDER_CHECK 			
			Return 3
	END CHOOSE


End If

Return 0
end function

public function integer of_setrequestor (userobject au_requestor);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_SetRequestor
//
//	Access:  		public
//
//	Arguments:		
//	au_requestor	The userobject requesting this service
//
//	Returns:  		Integer
//						1 if it succeeds and -1 if an error occurs.
//
//	Description:  	Associates an userobject with this service.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

If IsNull(au_requestor) Or Not IsValid(au_requestor) Then
	Return -1
End If

iu_requestor = au_requestor
Return 1
end function

public function integer of_position (dragobject adrg_object, boolean ab_makevisible);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_Position
//
//	Access:    Public
//
//	Arguments:	
//		adrg_object 	The object that is used to calculate the new position.
//		ab_makevisible If true then the DropDown object will be made visible
//				after a valid position is calculated.
//
//	Returns:  Integer
//		1 if it succeeds.
//		-1 if an error occurs.
//		-2 if the requested functionality is not supported.
//		-3 if a valid position could not be calculated.
//
//	Description:
//		Updates the position of the requestor object based on the 
//		current location of the adrg_object.  The adrg_object is the object
// 	to which the "actual dropdown object" is associated. 
//		If adrg_object is a datawindow, it is based on the current column/row
//		within the datawindow.
//
// Note:
// Title Bar on datawindows are not supported.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Integer	li_x, li_y
Integer	li_objheight
Integer	li_parentx, li_parenty
integer	li_rc
Integer	li_colx, li_coly, li_colheight
Integer	li_detailheight
Integer	li_dwx, li_dwy, li_dwborder, li_dwtitlebar, li_dwtitleborder
Integer	li_colheaderheight
String	ls_colname
String	ls_tempheaderheight
Integer	li_rowsafterfirst	
Integer	li_counter
Integer	li_hsplit, li_hpos, li_hpos1, li_hpos2
Integer	li_pointerx, li_pointery
Integer	li_bordercheck
window	lw_parent
datawindow ldw_object

// Validate the references.
If IsNull(adrg_object) or Not IsValid(adrg_object) Or &
	IsNull(iu_requestor) or Not IsValid(iu_requestor) Then
	Return -1
End If

// Get the parent window.
of_GetParentWindow(adrg_object, lw_parent)
If IsNull(lw_parent) or Not IsValid(lw_parent) Then
	Return -1
End If

// Get the X/Y coordinates for the parent object holding this datawindow.
of_GetParentPosition(adrg_object, li_parentx, li_parenty)

// Determine which type of processing is needed.
If adrg_object.TypeOf() = DataWindow! Then
	// Cast to the appropriate variable type.
	ldw_object = adrg_object

	// Determine if this positioning is not supported.
	If ldw_object.Titlebar Then
		// Not supported.
		iu_requestor.Visible = False
		Return -2
		// Calculate Title Bar attributes.
		//li_dwtitlebar = ?
		//li_dwtitleborder = ?
	End If

	// Get the column name.
	ls_colname = ldw_object.GetColumnName()

	// Get exact pointers.
	li_pointerx = ldw_object.PointerX()
	li_pointery = ldw_object.PointerY()

	// Get the DataWindow X/Y coordinates, Border width, and Title width. 
	li_dwx = ldw_object.X
	li_dwy = ldw_object.Y
	If ldw_object.Border Then
		CHOOSE CASE ldw_object.BorderStyle
			CASE StyleBox!
				If Not ldw_object.Titlebar Then
					li_dwborder = of_GetSystemSetting(DWSTYLE_BOX)
				End If
			CASE StyleShadowBox!
				If Not ldw_object.Titlebar Then
					li_dwborder = of_GetSystemSetting(DWSTYLE_SHADOWBOX)
				End If
			CASE StyleLowered!
				li_dwborder = of_GetSystemSetting(DWSTYLE_LOWERED)
			CASE StyleRaised!		
				li_dwborder = of_GetSystemSetting(DWSTYLE_RAISED)
		END CHOOSE
	End If

	// Get the X/Y point of the Left/Upper location for this column.
	li_colx = Integer(ldw_object.Describe(ls_colname+".X"))
	li_coly = Integer(ldw_object.Describe(ls_colname+".Y"))

	// Get the Height for this column and for the the Detail portion.
	li_colheight = Integer(ldw_object.Describe(ls_colname+".Height"))
	li_detailheight = Integer(ldw_object.Describe("DataWindow.Detail.Height")) + &
		of_GetSystemSetting(DWDETAIL_HEIGHT)

	// Get the height of the column header(s).
	ls_tempheaderheight = ldw_object.Describe("DataWindow.Header.Height")
	DO WHILE Pos(ls_tempheaderheight,"!") = 0
		li_colheaderheight += Integer(ls_tempheaderheight)
		li_counter ++
		ls_tempheaderheight = ldw_object.Describe("DataWindow.Header"+string(li_counter)+".Height")
	LOOP

	// Get the on-screen row number.
	li_rowsafterfirst = ldw_object.GetRow() - Long(ldw_object.Describe("DataWindow.FirstRowOnPage"))
	If li_rowsafterfirst < 0 Then
		// Hide the object since the row is not visible on the screen.
		iu_requestor.Visible = False
		Return -3
	End If

	// Get Horizontal Scrollbar and Horizontal Split Scrolling variables.
	li_hsplit = Integer (ldw_object.Describe("DataWindow.HorizontalScrollSplit"))
	li_hpos1 = Integer (ldw_object.Describe("DataWindow.HorizontalScrollPosition"))
	li_hpos2 = Integer (ldw_object.Describe("DataWindow.HorizontalScrollPosition2"))
	If ldw_object.hsplitscroll Then
		If li_hsplit > 4 and li_pointerx > li_hsplit Then
			li_hpos = li_hpos2 - li_hsplit - of_GetSystemSetting(DW_HSPLITBAR_WIDTH)
		Else
			li_hpos = li_hpos1
		End If
	Else
		li_hpos = li_hpos1
	End If

	// Determine the Height of the column holding the dropdown.
	li_objheight = li_colheight
	
	// Calculate the X and Y Coordinates (check that it does not go past borders).
	li_x = li_parentx + li_dwx + li_dwborder + li_dwtitleborder + &
		li_colx - li_hpos + of_GetSystemSetting(DWMISC_XPOSITION)
	li_y = li_parenty + li_dwy + li_dwborder + li_dwtitleborder + li_dwtitlebar + &
		li_coly + li_colheaderheight +  (li_detailheight * li_rowsafterfirst ) + &
		li_colheight + of_GetSystemSetting(DWMISC_YPOSITION)	
Else
	// Determine the Object Height of the control holding the dropdown.
	li_objheight = adrg_object.Height
	
	// Calculate the preffered X and Y Coordinates.
	li_x = li_parentx + adrg_object.X + of_GetSystemSetting(MISC_XPOSITION)
	li_y = li_parenty + adrg_object.Y + li_objheight + of_GetSystemSetting(MISC_YPOSITION)
End If

// Get the border check value.
li_bordercheck = of_GetSystemSetting(BORDER_CHECK)

// Make sure the coordinates will not force the calendar past the Right border.
If (lw_parent.WorkSpaceWidth() - iu_requestor.Width - li_bordercheck) > 0 Then
	If (li_x + iu_requestor.Width +li_bordercheck  > lw_parent.WorkSpaceWidth()) Then
		// Position it at the extreme right without going past border.
		li_x = lw_parent.WorkSpaceWidth() - iu_requestor.Width - li_bordercheck
	End If
End If

// Make sure this coordinates will not force the calendar past the Bottom border.
If (li_y - li_objheight - iu_requestor.Height) > 0 Then
	If (li_y + iu_requestor.Height +li_bordercheck > lw_parent.WorkSpaceHeight()) Then
		// Position on top of the field.
		li_y = li_y - li_objheight - iu_requestor.Height
	End If
End If

// Position the requestor object to the calculated coordinates.
iu_requestor.Move (li_x, li_y)

// If requested, make the dropdown object visible.
If ab_makevisible Then
	iu_requestor.Visible = True
End If
Return 1

end function

on pfc_n_cst_dropdown.create
TriggerEvent( this, "constructor" )
end on

on pfc_n_cst_dropdown.destroy
TriggerEvent( this, "destructor" )
end on

