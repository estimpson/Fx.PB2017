$PBExportHeader$n_cst_winsrv_ddelabellibrary.sru
forward
global type n_cst_winsrv_ddelabellibrary from n_cst_winsrv
end type
end forward

global type n_cst_winsrv_ddelabellibrary from n_cst_winsrv
end type
global n_cst_winsrv_ddelabellibrary n_cst_winsrv_ddelabellibrary

type variables

Private:
long	il_DDEChannelHandle

end variables

forward prototypes
public function integer of_openchannel ()
public function integer of_print (string as_printcommand)
end prototypes

public function integer of_openchannel ();

//	Attempt to start a hot link to a DDE Server for label printing.
il_DDEChannelHandle = OpenChannel("LabelLibrary", "LabelLibrary", Handle(iw_requestor))

if il_DDEChannelHandle > 0 then
	return SUCCESS
else
	return failure
end if

end function

public function integer of_print (string as_printcommand);
return ExecRemote("as_PrintCommand", il_DDEChannelHandle, Handle(iw_requestor))


end function

on n_cst_winsrv_ddelabellibrary.create
call super::create
end on

on n_cst_winsrv_ddelabellibrary.destroy
call super::destroy
end on

event destructor;call super::destructor;
if il_DDEChannelHandle > 0 then CloseChannel(il_DDEChannelHandle, Handle(iw_requestor))

end event

