$PBExportHeader$n_cst_popup.sru
$PBExportComments$PFC DropDown Object service
forward
global type n_cst_popup from n_base
end type
end forward

global type n_cst_popup from n_base
end type
global n_cst_popup n_cst_popup

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
public function integer of_position (string columnheadername, datawindow dw, boolean makevisible)
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
//						1 if it succeeds and$$HEX1$$a000$$ENDHEX$$-1 if an error occurs.
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
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
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
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
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
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
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
//						1 if it succeeds and$$HEX1$$a000$$ENDHEX$$-1 if an error occurs.
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
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
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

public function integer of_position (string columnheadername, datawindow dw, boolean makevisible);
//	Validate the references.
if	IsNull(dw) or Not IsValid(dw) or IsNull(iu_requestor) or Not IsValid(iu_requestor) then
	return FAILURE
end if

//	Get the parent window.
window dwParentWindow
of_GetParentWindow(dw, dwParentWindow)
if	IsNull(dwParentWindow) or not IsValid(dwParentWindow) then
	return FAILURE
end if

// Get the X/Y coordinates for the parent object holding this datawindow.
int parentX, parentY
of_GetParentPosition(dw, parentX, parentY)

// Determine if this positioning is not supported.
if	dw.Titlebar then
	// Not supported.
	iu_requestor.Visible = False
	return NOT_IMPLEMENTED
	// Calculate Title Bar attributes.
	//li_dwtitlebar = ?
	//li_dwtitleborder = ?
end if

// Get exact pointers.
int pointerX, pointerY
pointerX = dw.PointerX()
pointerY = dw.PointerY()

// Get the DataWindow X/Y coordinates, Border width, and Title width.
int dwX, dwY, dwBorderWidth
dwX = dw.X
dwY = dw.Y

if	dw.Border then
	choose case dw.BorderStyle
		case StyleBox!
			dwBorderWidth = of_GetSystemSetting(DWSTYLE_BOX)
		case StyleShadowBox!
			dwBorderWidth = of_GetSystemSetting(DWSTYLE_SHADOWBOX)
		case StyleLowered!
			dwBorderWidth = of_GetSystemSetting(DWSTYLE_LOWERED)
		case StyleRaised!		
			dwBorderWidth = of_GetSystemSetting(DWSTYLE_RAISED)
	end choose
end if

// Get the X/Y point of the Left/Upper location for this column.
int headerX, headerY
headerX = Integer(dw.Describe(columnHeaderName+".X"))
headerY = Integer(dw.Describe(columnHeaderName+".Y"))

// Get the Height for this column and for the the Detail portion.
int headerHeight
headerHeight = Integer(dw.Describe(columnHeaderName+".Height"))

// Get Horizontal Scrollbar and Horizontal Split Scrolling variables.
int hPos, hSplit, hPos1, hPos2
hSplit = Integer (dw.Describe("DataWindow.HorizontalScrollSplit"))
hPos1 = Integer (dw.Describe("DataWindow.HorizontalScrollPosition"))
hPos2 = Integer (dw.Describe("DataWindow.HorizontalScrollPosition2"))

if	dw.hsplitscroll then
	if	hSplit > 4 and pointerX > hSplit then
		hPos = hPos2 - hSplit - of_GetSystemSetting(DW_HSPLITBAR_WIDTH)
	else
		hPos = hPos1
	end if
else
	hPos = hPos1
end if
	
// Calculate the X and Y Coordinates (check that it does not go past borders).
int x, y
x = parentX + dwX + dwBorderWidth + headerX - hPos + of_GetSystemSetting(DWMISC_XPOSITION)
y = parentY + dwY + dwBorderWidth + headerY + headerHeight + of_GetSystemSetting(DWMISC_YPOSITION)	

// Get the border check value.
int borderCheck
borderCheck = of_GetSystemSetting(BORDER_CHECK)

// Make sure the coordinates will not force the calendar past the Right border.
if	(dwParentWindow.WorkSpaceWidth() - iu_requestor.Width - borderCheck) > 0 then
	if	(x + iu_requestor.Width + borderCheck  > dwParentWindow.WorkSpaceWidth()) then
		// Position it at the extreme right without going past border.
		x = dwParentWindow.WorkSpaceWidth() - iu_requestor.Width - borderCheck
	end if
end if

// Position the requestor object to the calculated coordinates.
iu_requestor.Move (x, y)

// If requested, make the popup object visible.
if	makeVisible then
	iu_requestor.Visible = true
end if

return SUCCESS

end function

on n_cst_popup.create
call super::create
end on

on n_cst_popup.destroy
call super::destroy
end on

