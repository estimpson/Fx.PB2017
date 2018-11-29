$PBExportHeader$n_cst_windowdimensions.sru
forward
global type n_cst_windowdimensions from n_base
end type
end forward

global type n_cst_windowdimensions from n_base autoinstantiate
end type

type variables

constant int DWSTYLE_BOX = 1
constant int DWSTYLE_SHADOWBOX = 2
constant int DWSTYLE_LOWERED = 3
constant int DWSTYLE_RAISED = 4
constant int STYLE_BOX = 5
constant int STYLE_SHADOWBOX = 6
constant int STYLE_LOWERED = 7
constant int STYLE_RAISED = 8
constant int DW_HSPLITBAR_WIDTH = 9
constant int TAB_BORDER = 10
constant int MISC_XPOSITION = 11
constant int MISC_YPOSITION = 12
constant int DWMISC_XPOSITION = 13
constant int DWMISC_YPOSITION = 14
constant int DWDETAIL_HEIGHT = 15
constant int BORDER_CHECK = 16

end variables

forward prototypes
public function integer getparentwindow (dragobject _requestordo, ref window _parentwindow)
public function integer getsystemsetting (integer _setting)
public function integer getparentposition (dragobject _requestordo, ref integer _parentx, ref integer _parenty)
end prototypes

public function integer getparentwindow (dragobject _requestordo, ref window _parentwindow);
powerobject parentPO

parentPO = _requestorDO.GetParent()

// Loop getting the parent of the object until it is of type window!
do	while IsValid (parentPO) 
	if	parentPO.TypeOf() <> window! then
		parentPO = parentPO.GetParent()
	else
		exit
	end if
loop

if	isnull(parentPO) or not isvalid(parentPO) then
	setnull(_parentWindow)	
	return FAILURE
end If

_parentWindow = parentPO
do while IsValid(_parentWindow.ParentWindow())
	_parentWindow = _parentWindow.ParentWindow()
loop

if	isnull(_parentWindow) or not isvalid(_parentWindow) then
	setnull(_parentWindow)
	return FAILURE
end if

return SUCCESS

end function

public function integer getsystemsetting (integer _setting);
Environment localEnvironment

GetEnvironment(localEnvironment)

if	localEnvironment.ostype = Windows! then
	choose case _setting
		case DWSTYLE_BOX
			return 3
		case DWSTYLE_SHADOWBOX
			return 3			
		case DWSTYLE_LOWERED
			return 6			
		case DWSTYLE_RAISED
			return 6		
		case DWDETAIL_HEIGHT
			return 0
			return -1
		case STYLE_BOX
			return 3			
		case STYLE_SHADOWBOX
			return 3			
		case STYLE_LOWERED
			return 6					
		case STYLE_RAISED
			return 6			
		case DW_HSPLITBAR_WIDTH
			return 12					
		case TAB_BORDER
			return 0		
		case MISC_XPOSITION
			return 0						
		case MISC_YPOSITION
			return 0		
		case DWMISC_XPOSITION
			return 0						
		case DWMISC_YPOSITION
			return 3			
		case BORDER_CHECK 			
			return 3
	end choose
else
	choose case _setting
		case DWSTYLE_BOX
			return 3
		case DWSTYLE_SHADOWBOX
			return 3			
		case DWSTYLE_LOWERED
			return 6			
		case DWSTYLE_RAISED
			return 6		
		case DWDETAIL_HEIGHT
			return 0
		case STYLE_BOX
			return 3			
		case STYLE_SHADOWBOX
			return 3			
		case STYLE_LOWERED
			return 6					
		case STYLE_RAISED
			return 6			
		case DW_HSPLITBAR_WIDTH
			return 12					
		case TAB_BORDER
			return 0		
		case MISC_XPOSITION
			return 0						
		case MISC_YPOSITION
			return 0		
		case DWMISC_XPOSITION
			return 0						
		case DWMISC_YPOSITION
			return 3			
		case BORDER_CHECK 			
			return 3
	end choose
end if

return 0

end function

public function integer getparentposition (dragobject _requestordo, ref integer _parentx, ref integer _parenty);
PowerObject parentPO
UserObject parentUO
Tab parentTab
Window parentW
int parentX, parentY
int x, y
int border

//	Validate required reference.
if	IsNull(_requestorDO) or Not IsValid(_requestorDO) then
	Return -1
end if

//	Loop getting the parent of the object until it is of type window!
parentPO = _requestorDO.GetParent()
do while IsValid (parentPO)
	if	parentPO.TypeOf() = window! then
		exit
	end if
	border = 0
	choose case TypeOf(parentPO)
		case UserObject!
			parentUO = parentPO
			parentX = parentUO.X 
			parentY = parentUO.Y 
			//	Determine the Left/Upper Border.
			if	parentUO.Border then
				choose case parentUO.BorderStyle
					case StyleBox!
						border = GetSystemSetting(STYLE_BOX)
					case StyleShadowBox!
						border = GetSystemSetting(STYLE_SHADOWBOX)
					case StyleLowered!
						border = GetSystemSetting(STYLE_LOWERED)
					case StyleRaised!		
						border = GetSystemSetting(STYLE_RAISED)
				end choose				
			end if			
		case Tab!
			parentTab = parentPO
			parentX = parentTab.X 
			parentY = parentTab.Y 
			border = GetSystemSetting(TAB_BORDER)
	end choose
	x += parentX + border
	y += parentY + border
	parentPO = parentPO.GetParent()
loop

if	not IsValid (parentPO) then
	return FAILURE
end if

parentW = parentPO
do while IsValid(parentW.ParentWindow())
	x += parentW.X
	y += parentW.Y
	parentW = parentW.ParentWindow()
loop

if	isnull(parentW) then
	return FAILURE
end if

if	parentW.WindowType = MDI! or parentW.WindowType = MDIHelp! then
	x += gnv_App.of_GetFrame().mdi_1.X + 25
	y += gnv_App.of_GetFrame().mdi_1.Y + 101
end if

_parentX = x
_parentY = y
return SUCCESS

end function

on n_cst_windowdimensions.create
call super::create
end on

on n_cst_windowdimensions.destroy
call super::destroy
end on

