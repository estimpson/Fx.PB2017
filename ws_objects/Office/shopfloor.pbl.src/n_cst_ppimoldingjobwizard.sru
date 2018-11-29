$PBExportHeader$n_cst_ppimoldingjobwizard.sru
forward
global type n_cst_ppimoldingjobwizard from n_base
end type
end forward

global type n_cst_ppimoldingjobwizard from n_base autoinstantiate
end type

type variables

Protected:
long	WindowHandle

end variables

event constructor;call super::constructor;
WindowHandle = Handle(GetParent())

//	Get notifications of changes to job status.
gnv_App.inv_StateMSGRouter.Register(String(WindowHandle) + ".JobState", this, false)

end event

on n_cst_ppimoldingjobwizard.create
call super::create
end on

on n_cst_ppimoldingjobwizard.destroy
call super::destroy
end on

