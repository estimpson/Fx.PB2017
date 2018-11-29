$PBExportHeader$u_tabpg_mes_manufacturedparts_partlist.sru
forward
global type u_tabpg_mes_manufacturedparts_partlist from u_tabpg_dw
end type
type cb_1 from commandbutton within u_tabpg_mes_manufacturedparts_partlist
end type
type cb_2 from commandbutton within u_tabpg_mes_manufacturedparts_partlist
end type
end forward

global type u_tabpg_mes_manufacturedparts_partlist from u_tabpg_dw
integer width = 2309
cb_1 cb_1
cb_2 cb_2
end type
global u_tabpg_mes_manufacturedparts_partlist u_tabpg_mes_manufacturedparts_partlist

type variables

Private:
//	Controller reference.
n_MES_manufacturedparts_controller _myController

end variables

forward prototypes
public function integer generateserials ()
public function integer generatepallets ()
end prototypes

public function integer generateserials ();
if	not IsValid(_myController) then return FAILURE

dw_1.AcceptText()
int selectedRows[]
selectedRows = dw_1.object.isselected.primary

int i
for i = 1 to UpperBound(selectedRows)
	if	selectedRows[i] = 1 then
		
		//	See if there are new boxes to be created.
		long newBoxes
		
		newBoxes = dw_1.Object.NewBoxes[i]
		if	newBoxes > 0 then
			//	Get necessary details to generate objects and print labels.
			decimal standardPack
			long WODID, primarySalesOrder
			string partCode, machineCode, boxPackageType, boxLabelFormat
			
			partCode = dw_1.Object.PartCode[i]
			WODID = dw_1.Object.WODID[i]
			primarySalesOrder = dw_1.Object.PrimarySalesOrder[i]
			machineCode = dw_1.Object.MachineCode[i]
			standardPack = dw_1.Object.StandardPack[i]
			boxPackageType = dw_1.Object.BoxPackageType[i]
			boxLabelFormat = dw_1.Object.BoxLabelFormat[i]
			
			_myController.GenerateSerials(newBoxes, partCode, WODID, primarySalesOrder, machineCode, standardPack, boxPackageType, boxLabelFormat)
		end if
	end if
next

return SUCCESS
end function

public function integer generatepallets ();
if	not IsValid(_myController) then return FAILURE

dw_1.AcceptText()
int selectedRows[]
selectedRows = dw_1.object.isselected.primary

int i
for i = 1 to UpperBound(selectedRows)
	if	selectedRows[i] = 1 then
		
		//	See if there are new boxes to be created.
		long newPallets
		
		newPallets = dw_1.Object.NewPallets[i]
		if	newPallets > 0 then
			//	Get necessary details to generate objects and print labels.
			long WODID, primarySalesOrder
			string partCode, machineCode, palletPackageType, palletLabelFormat
			
			partCode = dw_1.Object.PartCode[i]
			WODID = dw_1.Object.WODID[i]
			primarySalesOrder = dw_1.Object.PrimarySalesOrder[i]
			machineCode = dw_1.Object.MachineCode[i]
			palletPackageType = dw_1.Object.PalletPackageType[i]
			palletLabelFormat = dw_1.Object.PalletLabelFormat[i]
			
			_myController.GeneratePallets(newpallets, partCode, WODID, primarySalesOrder, machineCode, palletPackageType, palletLabelFormat)
		end if
	end if
next

return SUCCESS

end function

on u_tabpg_mes_manufacturedparts_partlist.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
end on

on u_tabpg_mes_manufacturedparts_partlist.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_1.X + (cb_1.X - gb_1.X - gb_1.Width) + cb_1.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_1, 100, 0, 0, 0)
inv_Resize.of_Register(cb_2, 100, 0, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_mes_manufacturedparts_partlist
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_mes_manufacturedparts_partlist
string dataobject = "d_mes_manufacturedpartlist"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject (SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

event dw_1::clicked;call super::clicked;
choose case lower(dwo.Name)
	case lower("StandardPack")
		object.StandardPack.TabSequence = 1
end choose

end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;
choose case lower(dwo.Name)
	case lower("StandardPack")
	case else
		object.StandardPack.TabSequence = 0
end choose

end event

type cb_1 from commandbutton within u_tabpg_mes_manufacturedparts_partlist
integer x = 1806
integer y = 8
integer width = 489
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Generate Serials"
end type

event clicked;GenerateSerials()

end event

type cb_2 from commandbutton within u_tabpg_mes_manufacturedparts_partlist
integer x = 1806
integer y = 136
integer width = 489
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Create Pallets"
end type

event clicked;GeneratePallets()

end event

