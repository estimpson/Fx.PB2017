$PBExportHeader$n_srv_versioncontrol.sru
forward
global type n_srv_versioncontrol from n_base
end type
end forward

global type n_srv_versioncontrol from n_base autoinstantiate
end type

type variables

private string Version = "$Rev: 319 $"

end variables

on n_srv_versioncontrol.create
call super::create
end on

on n_srv_versioncontrol.destroy
call super::destroy
end on

