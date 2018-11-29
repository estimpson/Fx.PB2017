$PBExportHeader$w_sheet_4t.srw
forward
global type w_sheet_4t from w_sheet
end type
end forward

global type w_sheet_4t from w_sheet
integer height = 1560
string menuname = "m_sheet_4t"
boolean controlmenu = false
boolean minbox = false
windowstate windowstate = maximized!
end type
global w_sheet_4t w_sheet_4t

type variables

boolean	Closing = false
u_sheet_tabpg	SheetTabPage
protectedwrite string OriginalTitle

end variables

on w_sheet_4t.create
call super::create
if this.MenuName = "m_sheet_4t" then this.MenuID = create m_sheet_4t
end on

on w_sheet_4t.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preopen;call super::pfc_preopen;
//	Default position of toolbar.
SetToolbarPos(1, 1, 66, false)

//	Set preferences.
of_SetPreference(true)
inv_Preference.of_SetWindow(false)

//	Disable update service.
of_SetUpdateable(false)

//
//  If show program name parameter is 'Y' then append title with class name.
OriginalTitle = Title
SetPointer ( HourGlass! )

integer	showProgramName = 0

select	1
into	:showProgramName  
from	parameters
where	parameters.show_program_name = 'Y'  ;

if	showProgramName = 1 then
	ClassDefinition thisClass
	thisClass = this.ClassDefinition
	Title = Title + " [" + thisClass.Name + "]"
End if

SetPointer ( Arrow! )

end event

event close;call super::close;
//	Notify frame that sheet is closing.
Closing = true
w_sheet_4t	thisSheet
thisSheet = this
gnv_App.of_GetFrame().dynamic event SheetClosing(thisSheet)

end event

event activate;call super::activate;
//	Notify frame that sheet has focus.
if Closing then return
w_sheet_4t	thisSheet
thisSheet = this
gnv_App.of_GetFrame().dynamic event SheetHasFocus(thisSheet)

end event

event pfd_event;call super::pfd_event;
choose case eventName
	case "pfc_refresh"
		event pfc_refresh()
end choose

end event

event pfc_postopen;call super::pfc_postopen;
//	Listen for refresh state.
gnv_App.inv_StateMSGRouter.Register("pfc_refresh", this, false)
post event pfc_refresh()
end event

