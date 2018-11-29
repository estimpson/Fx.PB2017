$PBExportHeader$w_unit_conversion.srw
forward
global type w_unit_conversion from Window
end type
type dw_1 from datawindow within w_unit_conversion
end type
end forward

global type w_unit_conversion from Window
int X=673
int Y=265
int Width=1582
int Height=993
boolean TitleBar=true
string Title="Untitled"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
dw_1 dw_1
end type
global w_unit_conversion w_unit_conversion

on open;/////////////////////////////////////////////////
//  Declare Variables
//

st_unit_conversion stParm


/////////////////////////////////////////////////
//  Initialize Variables
//

stParm = Message.PowerObjectParm

dw_1.SetTransObject ( sqlca )
dw_1.Retrieve ( stParm.szPart, stParm.szNewUnit, stParm.szOriginalUnit )


/////////////////////////////////////////////////
//  Convert quantity to desired unit of measurement
//

If stParm.szNewUnit <> stParm.szOriginalUnit Then
	If stParm.szNewUnit = dw_1.GetItemString ( 1, "unit_conversion_unit1" ) Then
		dConvertedQty = stParm.dQuantity * dw_1.GetItemNumber ( 1, "unit_conversion_conversion" )
	Else
		dConvertedQty = stParm.dQuantity / dw_1.GetItemNumber ( 1, "unit_conversion_conversion" )
	End if
Else
	dConvertedQty = stParm.dQuantity
End if


/////////////////////////////////////////////////
//  Close window
//

Close ( w_unit_conversion )

end on

on w_unit_conversion.create
this.dw_1=create dw_1
this.Control[]={ this.dw_1}
end on

on w_unit_conversion.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within w_unit_conversion
int X=439
int Y=353
int Width=494
int Height=361
int TabOrder=1
string DataObject="d_unit_conversion"
boolean LiveScroll=true
end type

