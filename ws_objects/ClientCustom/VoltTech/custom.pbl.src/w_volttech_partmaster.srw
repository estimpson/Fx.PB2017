$PBExportHeader$w_volttech_partmaster.srw
forward
global type w_volttech_partmaster from w_sheet_4t
end type
end forward

global type w_volttech_partmaster from w_sheet_4t
end type
global w_volttech_partmaster w_volttech_partmaster

on w_volttech_partmaster.create
call super::create
end on

on w_volttech_partmaster.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

