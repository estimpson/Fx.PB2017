$PBExportHeader$w_shippingdock_asnexceptionhandler_old.srw
forward
global type w_shippingdock_asnexceptionhandler_old from w_response
end type
type dw_1 from u_fxdw within w_shippingdock_asnexceptionhandler_old
end type
end forward

global type w_shippingdock_asnexceptionhandler_old from w_response
integer x = 214
integer y = 221
integer width = 2615
integer height = 1508
boolean clientedge = true
dw_1 dw_1
end type
global w_shippingdock_asnexceptionhandler_old w_shippingdock_asnexceptionhandler_old

type variables

private:

//	Model data.
long _shipperID

end variables

on w_shippingdock_asnexceptionhandler_old.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_shippingdock_asnexceptionhandler_old.destroy
call super::destroy
destroy(this.dw_1)
end on

event pfc_preopen;call super::pfc_preopen;
of_SetResize(true)
inv_resize.of_Register(dw_1, 0, 0, 100, 100)

n_cst_associative_array parm
parm = Message.PowerObjectParm

_shipperID = parm.of_GetItem("ShipperID", -1)
string exceptionHandler
exceptionHandler = parm.of_GetItem("ExceptionHandler", "")

string dwName
string pblName

select
	rl.object_name
,	rl.library_name
into
	:dwName
,	:pblName
from
	dbo.report_library rl
where
	name = :exceptionHandler  ;

if	not (pblName > "" and dwName > "") then return

string dwSyntax
dwSyntax = libraryexport(pblName, dwName, ExportDataWindow!)

if	not (dwSyntax > "") then return
if	not (dw_1.Create(dwSyntax) = 1) then return
dw_1.event pfc_retrieve()




end event

type dw_1 from u_fxdw within w_shippingdock_asnexceptionhandler_old
integer width = 2080
integer height = 1412
integer taborder = 10
end type

event pfc_retrieve;call super::pfc_retrieve;
SetTransObject(SQLCA)
if	Retrieve(_shipperID) = -1 then
	Retrieve(string(_shipperID))
end if

return SUCCESS


end event

