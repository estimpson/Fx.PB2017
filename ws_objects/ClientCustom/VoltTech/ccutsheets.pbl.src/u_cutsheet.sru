$PBExportHeader$u_cutsheet.sru
forward
global type u_cutsheet from u_base
end type
type dw_manualcrimp from u_fxdw within u_cutsheet
end type
type dw_doubles from u_fxdw within u_cutsheet
end type
type dw_singles from u_fxdw within u_cutsheet
end type
end forward

global type u_cutsheet from u_base
integer width = 6112
integer height = 3196
boolean hscrollbar = true
boolean vscrollbar = true
dw_manualcrimp dw_manualcrimp
dw_doubles dw_doubles
dw_singles dw_singles
end type
global u_cutsheet u_cutsheet

type variables

string	_wireHarness

end variables
forward prototypes
public function integer refresh ()
public function integer setwireharness (string wireharness)
end prototypes

public function integer refresh ();
return dw_singles.Refresh() + dw_doubles.Refresh() + dw_manualcrimp.Refresh()

end function

public function integer setwireharness (string wireharness);
_wireHarness = wireHarness
return Refresh()

end function

on u_cutsheet.create
int iCurrent
call super::create
this.dw_manualcrimp=create dw_manualcrimp
this.dw_doubles=create dw_doubles
this.dw_singles=create dw_singles
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_manualcrimp
this.Control[iCurrent+2]=this.dw_doubles
this.Control[iCurrent+3]=this.dw_singles
end on

on u_cutsheet.destroy
call super::destroy
destroy(this.dw_manualcrimp)
destroy(this.dw_doubles)
destroy(this.dw_singles)
end on

event constructor;call super::constructor;
dw_singles.of_SetTransObject(SQLCA)
dw_doubles.of_SetTransObject(SQLCA)
dw_manualcrimp.of_SetTransObject(SQLCA)

end event

type dw_manualcrimp from u_fxdw within u_cutsheet
integer y = 1872
integer width = 6039
integer height = 1260
integer taborder = 30
string dataobject = "d_cutsheet_manualcrimp"
boolean vscrollbar = false
boolean showpowerfilter = false
end type

event retrieveend;call super::retrieveend;
//	Calculate the size of the datawindow and resize control appropriately.
string bands
bands = Object.DataWindow.Bands

long headerHeight
headerHeight = Long(Object.DataWindow.Header.Height)

long detailHeight
detailHeight = Long(Object.DataWindow.Detail.Height)

long totalHeight
totalHeight = headerHeight + rowcount * detailHeight + 10

long heightDelta
heightDelta = totalHeight - height

height += heightDelta

end event

event pfc_retrieve;call super::pfc_retrieve;
return dw_manualcrimp.Retrieve(_wireHarness)

end event

type dw_doubles from u_fxdw within u_cutsheet
integer y = 1420
integer width = 6039
integer height = 452
integer taborder = 20
string dataobject = "d_cutsheet_doubles"
boolean vscrollbar = false
boolean showpowerfilter = false
end type

event retrieveend;call super::retrieveend;
//	Calculate the size of the datawindow and resize control appropriately.
string bands
bands = Object.DataWindow.Bands

long headerHeight
headerHeight = Long(Object.DataWindow.Header.Height)

long detailHeight
detailHeight = Long(Object.DataWindow.Detail.Height)

long totalHeight
totalHeight = headerHeight + rowcount * detailHeight + 10

long heightDelta
heightDelta = totalHeight - height

height += heightDelta
dw_manualcrimp.y += heightDelta

end event

event pfc_retrieve;call super::pfc_retrieve;
return dw_doubles.Retrieve(_wireHarness)

end event

type dw_singles from u_fxdw within u_cutsheet
integer width = 6039
integer height = 1420
integer taborder = 10
string dataobject = "d_cutsheet_singles"
boolean vscrollbar = false
boolean showpowerfilter = false
end type

event retrieveend;call super::retrieveend;
//	Calculate the size of the datawindow and resize control appropriately.
string bands
bands = Object.DataWindow.Bands

long headerHeight
headerHeight = Long(Object.DataWindow.Header.Height)

long detailHeight
detailHeight = Long(Object.DataWindow.Detail.Height)

long totalHeight
totalHeight = headerHeight + rowcount * detailHeight + 10

long heightDelta
heightDelta = totalHeight - height

height += heightDelta
dw_doubles.y += heightDelta
dw_manualcrimp.y += heightDelta


end event

event pfc_retrieve;call super::pfc_retrieve;
return dw_singles.Retrieve(_wireHarness)

end event

