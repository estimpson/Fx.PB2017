$PBExportHeader$u_crosstab_po_grid_list_of_dropship.sru
$PBExportComments$(mrs) user object listing dropship
forward
global type u_crosstab_po_grid_list_of_dropship from u_crosstab_po_grid_po_creation_ancestor
end type
end forward

global type u_crosstab_po_grid_list_of_dropship from u_crosstab_po_grid_po_creation_ancestor
long BackColor=78682240
end type
global u_crosstab_po_grid_list_of_dropship u_crosstab_po_grid_list_of_dropship

type variables
boolean	ib_success = TRUE
end variables

on u_crosstab_po_grid_list_of_dropship.create
call super::create
end on

on u_crosstab_po_grid_list_of_dropship.destroy
call super::destroy
end on

type uo_release from u_crosstab_po_grid_po_creation_ancestor`uo_release within u_crosstab_po_grid_list_of_dropship
long BackColor=78682240
end type

type dw_selection from u_crosstab_po_grid_po_creation_ancestor`dw_selection within u_crosstab_po_grid_list_of_dropship
int X=55
int Width=1207
end type

type st_1 from u_crosstab_po_grid_po_creation_ancestor`st_1 within u_crosstab_po_grid_list_of_dropship
long TextColor=33554432
long BackColor=78682240
end type

