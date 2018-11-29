$PBExportHeader$u_tab_4t.sru
forward
global type u_tab_4t from u_tab
end type
end forward

global type u_tab_4t from u_tab
integer width = 2642
integer height = 1620
long backcolor = 1073741824
event shown ( )
end type
global u_tab_4t u_tab_4t

event shown();if	SelectedTab > 0 and SelectedTab <= UpperBound(control) then
	control[SelectedTab].TriggerEvent("shown")
end if

end event

event selectionchanged;call super::selectionchanged;BringToTop = true
if	newIndex > 0 and newIndex <= UpperBound(control) then
	control[newIndex].TriggerEvent("shown")
end if

end event

