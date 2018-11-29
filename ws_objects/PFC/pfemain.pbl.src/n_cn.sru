$PBExportHeader$n_cn.sru
$PBExportComments$Extension Connection class
forward
global type n_cn from pfc_n_cn
end type
end forward

global type n_cn from pfc_n_cn
end type
global n_cn n_cn

on n_cn.create
call connection::create
triggerevent( this, "constructor" )
end on

on n_cn.destroy
call connection::destroy
triggerevent( this, "destructor" )
end on

