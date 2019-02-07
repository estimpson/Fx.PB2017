HA$PBExportHeader$w_custom_siloinventory.srw
forward
global type w_custom_siloinventory from w_sheet_4t
end type
type uo_1 from u_panel within w_custom_siloinventory
end type
end forward

global type w_custom_siloinventory from w_sheet_4t
integer width = 4037
integer height = 2520
string title = "Silo Inventory"
uo_1 uo_1
end type
global w_custom_siloinventory w_custom_siloinventory

type variables

private:
u_tabpg_custom_siloinventory uo_siloinventory

end variables

event pfc_preopen;call super::pfc_preopen;
//	Resize.
of_SetResize(false)
of_SetResize(true)
inv_Resize.of_SetOrigSize(uo_1.X + uo_1.Width, uo_1.Y + uo_1.Height)
inv_Resize.of_Register(uo_1, 0, 0, 100, 100)

//	Move bill to and ship to edit screens to the panel.
OpenUserObject(uo_siloinventory, "u_tabpg_custom_siloinventory")
uo_1.AddPanelControl(uo_siloinventory)
uo_1.ShowControl(uo_siloinventory)

end event

on w_custom_siloinventory.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on w_custom_siloinventory.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_1)
end on

event pfc_refresh;call super::pfc_refresh;
//	Refresh all tab pages that inherit from u_tabpg_dw unless they inherit from u_tabpg_dwchild.
int i
for	i = 1 to UpperBound(uo_1.panelcontrols)
	ClassDefinition tabPageClassDefinition
	tabPageClassDefinition = uo_1.panelcontrols[i].ClassDefinition
	boolean dwTabPage; dwTabPage = false
	ClassDefinition parentDef
	parentDef = tabPageClassDefinition
	do while IsValid(parentDef) and not dwTabPage
		choose case parentDef.Name
			case "u_tabpg_dwchild"
				dwTabPage = true
			case "u_tabpg_dw"
				dwTabPage = true
				u_tabpg_dw headerTabPg
				headerTabPg = uo_1.panelcontrols[i]
				headerTabPg.Refreshing = true
				headerTabPg.Refresh()
			case "u_tabpg_headerdetail"
				dwTabPage = true
				u_tabpg_headerdetail headerDetailTabPg
				headerDetailTabPg = uo_1.panelcontrols[i]
				headerDetailTabPg.event pfc_refresh ()
		end choose
		parentDef = parentDef.Ancestor
	loop
next

end event

type uo_1 from u_panel within w_custom_siloinventory
integer x = 9
integer y = 8
integer taborder = 10
end type

on uo_1.destroy
call u_panel::destroy
end on

