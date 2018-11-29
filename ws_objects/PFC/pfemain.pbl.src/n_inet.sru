$PBExportHeader$n_inet.sru
$PBExportComments$Extension inet class
forward
global type n_inet from pfc_n_inet
end type
end forward

global type n_inet from pfc_n_inet
end type
global n_inet n_inet

on n_inet.create
call inet::create
triggerevent( this, "constructor" )
end on

on n_inet.destroy
call inet::destroy
triggerevent( this, "destructor" )
end on

