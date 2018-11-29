$PBExportHeader$w_inventory_location_list.srw
forward
global type w_inventory_location_list from Window
end type
type cb_cancel from commandbutton within w_inventory_location_list
end type
type cb_save from commandbutton within w_inventory_location_list
end type
type cbx_1 from checkbox within w_inventory_location_list
end type
type st_3 from statictext within w_inventory_location_list
end type
type st_2 from statictext within w_inventory_location_list
end type
type dw_2 from datawindow within w_inventory_location_list
end type
type dw_1 from datawindow within w_inventory_location_list
end type
end forward

global type w_inventory_location_list from Window
int X=672
int Y=264
int Width=2766
int Height=1456
boolean TitleBar=true
string Title="Limit Locations for "
long BackColor=79741120
WindowType WindowType=popup!
event save_dw3 pbm_custom01
cb_cancel cb_cancel
cb_save cb_save
cbx_1 cbx_1
st_3 st_3
st_2 st_2
dw_2 dw_2
dw_1 dw_1
end type
global w_inventory_location_list w_inventory_location_list

type variables
Boolean	bAdd
Boolean	bDelete
String	szLocation
String	szTrans
Long	lRow1
Long	lRow2
end variables

forward prototypes
public subroutine wf_reset_indicators ()
end prototypes

public subroutine wf_reset_indicators ();bAdd 		= False
bDelete	= False
end subroutine

event open;Int	iCount
Environment	lenv_Test

szTrans = Message.StringParm

GetEnvironment ( lenv_Test )

Move ( PixelsToUnits ( ( lenv_Test.ScreenWidth - UnitsToPixels ( Width, XUnitsToPixels! ) ) / 2, XPixelsToUnits! ), &
	PixelsToUnits ( ( lenv_Test.ScreenHeight - UnitsToPixels ( Height, YUnitsToPixels! ) ) / 2, YPixelsToUnits! ) )

If szTrans = 'J' Then 
	This.Title = This.Title + "Job Completion"
Elseif szTrans = 'M' Then
	This.Title = This.Title + "Material Issue"
Elseif szTrans = 'M' Then
	This.Title = This.Title + "Break Out"
Elseif szTrans = 'T' Then
	This.Title = This.Title + "Transfer"
End if

dw_1.SetTransObject ( sqlca )
dw_2.SetTransObject ( sqlca )

dw_1.Retrieve ( )
If dw_2.Retrieve ( szTrans ) > 0 Then
	cbx_1.Checked = True
Else
	cbx_1.Checked = False
End if
end event

on activate;If gnv_App.of_GetFrame().MenuName <> "m_inventory_location_list" Then &
	gnv_App.of_GetFrame().ChangeMenu ( m_inventory_location_list )
end on

on w_inventory_location_list.create
this.cb_cancel=create cb_cancel
this.cb_save=create cb_save
this.cbx_1=create cbx_1
this.st_3=create st_3
this.st_2=create st_2
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.cb_cancel,&
this.cb_save,&
this.cbx_1,&
this.st_3,&
this.st_2,&
this.dw_2,&
this.dw_1}
end on

on w_inventory_location_list.destroy
destroy(this.cb_cancel)
destroy(this.cb_save)
destroy(this.cbx_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event deactivate;Close ( This )
end event

type cb_cancel from commandbutton within w_inventory_location_list
int X=283
int Y=1252
int Width=247
int Height=96
int TabOrder=21
string Text="Cancel"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Parent.TriggerEvent ( Deactivate! )
end event

type cb_save from commandbutton within w_inventory_location_list
int X=18
int Y=1252
int Width=247
int Height=96
int TabOrder=30
string Text="Save"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;IF dw_2.Update ( ) = -1 THEN
	MessageBox ( 'Warning', 'Unable to save!' )
END IF
commit ;
end event

type cbx_1 from checkbox within w_inventory_location_list
int X=1417
int Y=52
int Width=229
int Height=64
string Text="Limit"
BorderStyle BorderStyle=StyleLowered!
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;IF Checked THEN
	dw_2.Retrieve ( szTrans )
ELSE
	DO WHILE dw_2.RowCount ( ) > 0
		dw_2.DeleteRow ( 1 )
	LOOP
END IF
end event

type st_3 from statictext within w_inventory_location_list
int X=18
int Y=48
int Width=1317
int Height=80
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Complete List Of Locations/Machines"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_inventory_location_list
int X=1408
int Y=48
int Width=1317
int Height=80
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Limited Locations List"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_2 from datawindow within w_inventory_location_list
int X=1408
int Y=128
int Width=1317
int Height=1104
int TabOrder=20
string DragIcon="monitor.ico"
string DataObject="d_location_list_per_trans"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event dragdrop;Long	lCheckRow

If bAdd Then
	szLocation = dw_1.GetItemString ( lRow1, "code" )
	lCheckRow = Find ( "code = '" + szLocation + "'", 1, RowCount ( ) )	
	If lCheckRow > 0 Then
		Return
	End if
	InsertRow ( 0 )
	SetItem ( RowCount ( ), "location_code", szLocation )
	SetItem ( RowCount ( ), "trans_code", szTrans )
	SetItem ( RowCount ( ), "code", dw_1.GetItemString ( lRow1, "code" ) )
	SetItem ( RowCount ( ), "location_name", dw_1.GetItemString ( lRow1, "name" ) )
	SetSort ( "code A" )
	Sort ( )
End if
end event

on clicked;If cbx_1.Checked  Then

	wf_reset_indicators ( )

	lRow2 = This.GetClickedRow ( )

	SelectRow ( This, 0, False )

	If lRow2 < 1 Then Return

	bDelete = True

	SelectRow ( This, lRow2, True )

	This.Drag ( Begin! )

End if
end on

type dw_1 from datawindow within w_inventory_location_list
int X=18
int Y=128
int Width=1317
int Height=1104
int TabOrder=10
string DragIcon="monitor.ico"
string DataObject="d_inventory_location_list"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

on clicked;If cbx_1.Checked  Then

	wf_reset_indicators ( )

	lRow1 = This.GetClickedRow ( )

	SelectRow ( This, 0, False )

	If lRow1 < 1 Then Return

	bAdd = True

	SelectRow ( This, lRow1, True )

	This.Drag ( Begin! )

End if
end on

event dragdrop;If bDelete Then
	dw_2.DeleteRow ( lRow2 )
End if
end event

