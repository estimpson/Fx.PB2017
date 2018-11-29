$PBExportHeader$n_srv_currentsvnversion.sru
forward
global type n_srv_currentsvnversion from n_base
end type
end forward

global type n_srv_currentsvnversion from n_base autoinstantiate
end type

type variables

long SVNVERSION = 320
datetime LASTCHECKINDT = DateTime('2009/07/31 17:35:34')
datetime CURRENTDT = DateTime('2009/07/31 17:36:18')

end variables

on n_srv_currentsvnversion.create
call super::create
end on

on n_srv_currentsvnversion.destroy
call super::destroy
end on

