$PBExportHeader$u_fxdw_edi_tradingpartners.sru
forward
global type u_fxdw_edi_tradingpartners from u_tabpg_dw
end type
end forward

global type u_fxdw_edi_tradingpartners from u_tabpg_dw
string text = "Trading Partners"
end type
global u_fxdw_edi_tradingpartners u_fxdw_edi_tradingpartners

on u_fxdw_edi_tradingpartners.create
call super::create
end on

on u_fxdw_edi_tradingpartners.destroy
call super::destroy
end on

type gb_1 from u_tabpg_dw`gb_1 within u_fxdw_edi_tradingpartners
end type

type dw_1 from u_tabpg_dw`dw_1 within u_fxdw_edi_tradingpartners
string dataobject = "d_editradingpartnercodes"
end type

