$PBExportHeader$cu_tabpg_jobdetails.sru
forward
global type cu_tabpg_jobdetails from u_tabpg_jobdetails
end type
end forward

global type cu_tabpg_jobdetails from u_tabpg_jobdetails
end type
global cu_tabpg_jobdetails cu_tabpg_jobdetails

on cu_tabpg_jobdetails.create
call super::create
end on

on cu_tabpg_jobdetails.destroy
call super::destroy
end on

type gb_1 from u_tabpg_jobdetails`gb_1 within cu_tabpg_jobdetails
end type

type dw_1 from u_tabpg_jobdetails`dw_1 within cu_tabpg_jobdetails
end type

event dw_1::clicked;call super::clicked;
choose case Lower(dwo.Name)
	case Lower("BoxLabelFormat")
		object.BoxLabelFormat.TabSequence = 10
	case Lower("PalletPackageType")
		object.PalletPackageType.TabSequence = 10
	case Lower("PalletLabelFormat")
		object.PalletLabelFormat.TabSequence = 10
end choose

end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;
choose case Lower(dwo.Name)
	case Lower("BoxLabelFormat")
		object.PalletPackageType.TabSequence = 0
		object.PalletLabelFormat.TabSequence = 0
	case Lower("PalletPackageType")
		object.BoxLabelFormat.TabSequence = 0
		object.PalletLabelFormat.TabSequence = 0
	case Lower("PalletLabelFormat")
		object.BoxLabelFormat.TabSequence = 0
		object.PalletPackageType.TabSequence = 0
	case else
		object.BoxLabelFormat.TabSequence = 0
		object.PalletPackageType.TabSequence = 0
		object.PalletLabelFormat.TabSequence = 0
end choose

end event

type cb_generate from u_tabpg_jobdetails`cb_generate within cu_tabpg_jobdetails
end type

type cbx_print from u_tabpg_jobdetails`cbx_print within cu_tabpg_jobdetails
end type

type cb_manualjob from u_tabpg_jobdetails`cb_manualjob within cu_tabpg_jobdetails
end type

type cb_closejob from u_tabpg_jobdetails`cb_closejob within cu_tabpg_jobdetails
end type

type cb_movejob from u_tabpg_jobdetails`cb_movejob within cu_tabpg_jobdetails
end type

