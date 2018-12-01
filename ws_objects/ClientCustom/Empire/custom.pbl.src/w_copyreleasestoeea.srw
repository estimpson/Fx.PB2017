$PBExportHeader$w_copyreleasestoeea.srw
forward
global type w_copyreleasestoeea from w_sheet_4t
end type
end forward

global type w_copyreleasestoeea from w_sheet_4t
boolean visible = false
integer width = 2779
integer height = 1976
end type
global w_copyreleasestoeea w_copyreleasestoeea

on w_copyreleasestoeea.create
call super::create
end on

on w_copyreleasestoeea.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;
if	msgbox("Customer releases will be copied to EEA.  Press OK to continue or Cancel.", Question!, OkCancel!, 2) = 2 then
	post close(this)
	return
end if

long procReturn = FAILURE
n_cst_blanketorders blanketOrders

blanketOrders.CopyEEAReleasesToEEH(procReturn)
if	procReturn = 0 then
	msgbox("Releases copied to EEA successfully")
end if

//	Return.
post close(this)

end event

