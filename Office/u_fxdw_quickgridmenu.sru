HA$PBExportHeader$u_fxdw_quickgridmenu.sru
forward
global type u_fxdw_quickgridmenu from u_fxdw
end type
end forward

global type u_fxdw_quickgridmenu from u_fxdw
integer width = 421
integer height = 80
string dataobject = "d_quickgridmenu"
boolean vscrollbar = false
boolean livescroll = false
event newclicked ( )
event deleteclicked ( )
event saveclicked ( )
event cancelclicked ( )
end type
global u_fxdw_quickgridmenu u_fxdw_quickgridmenu

type variables

public:
int DeleteRowEnabled = 1
int InsertRowEnabled = 1
int SaveEnabled = 1
int CancelEnabled = 1

end variables
forward prototypes
public function integer updateview ()
end prototypes

public function integer updateview ();
if	RowCount() < 1 then
	return FAILURE
end if

object.DeleteRowEnabled[1] = DeleteRowEnabled
object.InsertRowEnabled[1] = InsertRowEnabled
object.SaveEnabled[1] = SaveEnabled
object.CancelEnabled[1] = CancelEnabled

return SUCCESS

end function

on u_fxdw_quickgridmenu.create
call super::create
end on

on u_fxdw_quickgridmenu.destroy
call super::destroy
end on

event itemchanged;call super::itemchanged;
post UpdateView()

end event

event constructor;call super::constructor;
post UpdateView()

end event

event clicked;call super::clicked;
choose case dwo.Name
	case "p_delete"
		event deleteclicked()
	case "p_new"
		event newclicked()
	case "p_save"
		event saveclicked()
	case "p_cancel"
		event cancelclicked()
end choose

end event

