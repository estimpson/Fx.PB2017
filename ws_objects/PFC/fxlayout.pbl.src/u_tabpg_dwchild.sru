$PBExportHeader$u_tabpg_dwchild.sru
forward
global type u_tabpg_dwchild from u_tabpg_dw
end type
type dw_parent from u_dw within u_tabpg_dwchild
end type
type gb_parent from groupbox within u_tabpg_dwchild
end type
end forward

global type u_tabpg_dwchild from u_tabpg_dw
integer width = 2139
integer height = 1352
dw_parent dw_parent
gb_parent gb_parent
end type
global u_tabpg_dwchild u_tabpg_dwchild

on u_tabpg_dwchild.create
int iCurrent
call super::create
this.dw_parent=create dw_parent
this.gb_parent=create gb_parent
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_parent
this.Control[iCurrent+2]=this.gb_parent
end on

on u_tabpg_dwchild.destroy
call super::destroy
destroy(this.dw_parent)
destroy(this.gb_parent)
end on

event constructor;call super::constructor;
of_SetResize(true)
inv_Resize.of_Register(dw_parent, 0, 0, 100, 0)
inv_Resize.of_Register(gb_parent, 0, 0, 100, 0)

//	Get necessary notifications.
string parentDWRowChangeParm [2] = {"ParentDW.dataobject"}
parentDWRowChangeParm[2] = dw_parent.tag + ".ParentDWRowData"
gnv_App.inv_StateMSGRouter.Register(dw_parent.tag + ".ParentDWRowChange", parentDWRowChangeParm, this)

end event

event pfd_event;call super::pfd_event;
choose case eventName
	case dw_parent.tag + ".ParentDWRowChange"
		string parentDWdataobject
		parentDWdataobject = eventMessage.of_GetItem("ParentDW.dataobject")
		if	parentDWdataobject = dw_parent.dataobject then
			dw_parent.SetRedraw(false)
			dw_parent.Reset()
			any rowData[]
			rowData = eventMessage.of_GetItem(dw_parent.tag + ".ParentDWRowData")
			if	UpperBound (rowData) > 0 then
				dw_parent.object.data.primary[1] = rowData
				if	isvalid(dw_parent.inv_RowSelect) then
					dw_parent.SelectRow(1, true)
				end if
				dw_parent.SetItemStatus(1, 0, Primary!, DataModified!)
			end if
			dw_parent.SetRedraw(true)
			dw_parent.post event rowchanged()
		end if
end choose

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_dwchild
integer y = 252
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_dwchild
integer x = 5
integer y = 332
integer width = 1737
end type

type dw_parent from u_dw within u_tabpg_dwchild
event rowchanged ( )
integer x = 5
integer y = 64
integer width = 1737
integer height = 164
integer taborder = 20
boolean bringtotop = true
boolean enabled = false
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

type gb_parent from groupbox within u_tabpg_dwchild
integer width = 1751
integer height = 240
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "Parent Row"
end type

