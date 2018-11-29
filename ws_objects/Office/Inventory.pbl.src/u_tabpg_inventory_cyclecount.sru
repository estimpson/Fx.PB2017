$PBExportHeader$u_tabpg_inventory_cyclecount.sru
forward
global type u_tabpg_inventory_cyclecount from u_panel_headerdetail
end type
end forward

global type u_tabpg_inventory_cyclecount from u_panel_headerdetail
end type
global u_tabpg_inventory_cyclecount u_tabpg_inventory_cyclecount

type variables

n_cst_inventory_cyclecount_controller Controller
u_tabpg_inventory_cyclecount_headers CycleCountheaders
u_tabpg_inventory_cyclecount_details CycleCountDetails

end variables

forward prototypes
public function integer setcontroller (ref n_cst_inventory_cyclecount_controller acontroller)
end prototypes

public function integer setcontroller (ref n_cst_inventory_cyclecount_controller acontroller);
if	not IsValid(aController) or IsNull(aController) then
	return -1
end if

Controller = aController

end function

event constructor;call super::constructor;
of_SetUpdateable(true)

end event

on u_tabpg_inventory_cyclecount.create
int iCurrent
call super::create
end on

on u_tabpg_inventory_cyclecount.destroy
call super::destroy
end on

type uo_2 from u_panel_headerdetail`uo_2 within u_tabpg_inventory_cyclecount
end type

type uo_1 from u_panel_headerdetail`uo_1 within u_tabpg_inventory_cyclecount
end type

type st_1 from u_panel_headerdetail`st_1 within u_tabpg_inventory_cyclecount
end type

