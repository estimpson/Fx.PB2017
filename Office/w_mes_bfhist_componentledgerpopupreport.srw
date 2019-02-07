HA$PBExportHeader$w_mes_bfhist_componentledgerpopupreport.srw
forward
global type w_mes_bfhist_componentledgerpopupreport from w_popup
end type
type dw_1 from u_fxdw within w_mes_bfhist_componentledgerpopupreport
end type
end forward

global type w_mes_bfhist_componentledgerpopupreport from w_popup
dw_1 dw_1
end type
global w_mes_bfhist_componentledgerpopupreport w_mes_bfhist_componentledgerpopupreport

type variables

private:
string _componentPart

end variables

forward prototypes
public function integer setcomponentpart (string componentpart)
end prototypes

public function integer setcomponentpart (string componentpart);
_componentPart = componentPart
return dw_1.event pfc_retrieve()


end function

on w_mes_bfhist_componentledgerpopupreport.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_mes_bfhist_componentledgerpopupreport.destroy
call super::destroy
destroy(this.dw_1)
end on

event pfc_postopen;call super::pfc_postopen;
of_SetResize(true)
inv_resize.of_SetOrigSize(dw_1.X * 2 + dw_1.Width, dw_1.Y * 2 + dw_1.height)
inv_resize.of_Register(dw_1, 0, 0, 100, 100)

end event

event deactivate;call super::deactivate;
Close(this)

end event

type dw_1 from u_fxdw within w_mes_bfhist_componentledgerpopupreport
integer x = 9
integer y = 12
integer width = 2437
integer height = 1356
integer taborder = 10
string dataobject = "d_mes_bfhistory_componentledgerreport"
end type

event pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_componentPart)

end event

event constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

