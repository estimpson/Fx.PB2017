$PBExportHeader$u_tabpg_inventory_quality.sru
forward
global type u_tabpg_inventory_quality from u_panel_headerdetail
end type
end forward

global type u_tabpg_inventory_quality from u_panel_headerdetail
end type
global u_tabpg_inventory_quality u_tabpg_inventory_quality

type variables

n_cst_inventory_quality_controller Controller
u_tabpg_inventory_quality_headers QualityHeaders
u_tabpg_inventory_quality_details QualityDetails

end variables

forward prototypes
public function integer setcontroller (ref n_cst_inventory_quality_controller acontroller)
end prototypes

public function integer setcontroller (ref n_cst_inventory_quality_controller acontroller);
if	not IsValid(aController) or IsNull(aController) then
	return -1
end if

Controller = aController

end function

event constructor;call super::constructor;
of_SetUpdateable(true)

end event

on u_tabpg_inventory_quality.create
int iCurrent
call super::create
end on

on u_tabpg_inventory_quality.destroy
call super::destroy
end on

type uo_2 from u_panel_headerdetail`uo_2 within u_tabpg_inventory_quality
end type

type uo_1 from u_panel_headerdetail`uo_1 within u_tabpg_inventory_quality
end type

type st_1 from u_panel_headerdetail`st_1 within u_tabpg_inventory_quality
end type

