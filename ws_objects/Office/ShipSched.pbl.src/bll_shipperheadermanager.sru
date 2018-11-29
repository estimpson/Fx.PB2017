$PBExportHeader$bll_shipperheadermanager.sru
forward
global type bll_shipperheadermanager from n_base
end type
end forward

global type bll_shipperheadermanager from n_base autoinstantiate
end type

on bll_shipperheadermanager.create
call super::create
end on

on bll_shipperheadermanager.destroy
call super::destroy
end on

