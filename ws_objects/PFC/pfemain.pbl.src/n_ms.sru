$PBExportHeader$n_ms.sru
$PBExportComments$Extension Mail Session class
forward
global type n_ms from pfc_n_ms
end type
end forward

global type n_ms from pfc_n_ms
end type
global n_ms n_ms

on n_ms.create
call mailsession::create
triggerevent( this, "constructor" )
end on

on n_ms.destroy
call mailsession::destroy
triggerevent( this, "destructor" )
end on

