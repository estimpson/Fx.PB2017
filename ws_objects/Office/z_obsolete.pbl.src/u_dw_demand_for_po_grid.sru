$PBExportHeader$u_dw_demand_for_po_grid.sru
$PBExportComments$(mrs)
forward
global type u_dw_demand_for_po_grid from u_jw_dw_super
end type
end forward

global type u_dw_demand_for_po_grid from u_jw_dw_super
end type
global u_dw_demand_for_po_grid u_dw_demand_for_po_grid

forward prototypes
public function integer uf_retrieve (date adate, string as_type, string as_value, transaction atransaction)
end prototypes

public function integer uf_retrieve (date adate, string as_type, string as_value, transaction atransaction);this.settransobject( atransaction )

if as_value > '' then
	return this.retrieve( adate, as_type, as_value )
else
	if as_type > '' then
		return this.retrieve( adate, as_type )
	else
		return this.retrieve( adate )
	end if
end if
end function

