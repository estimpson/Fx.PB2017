$PBExportHeader$w_recalc_objects_onhand.srw
forward
global type w_recalc_objects_onhand from Window
end type
type st_message from statictext within w_recalc_objects_onhand
end type
type st_process from statictext within w_recalc_objects_onhand
end type
type cb_exit from commandbutton within w_recalc_objects_onhand
end type
type cb_start from commandbutton within w_recalc_objects_onhand
end type
type st_percentage from statictext within w_recalc_objects_onhand
end type
type sle_percentage from singlelineedit within w_recalc_objects_onhand
end type
type sle_base from singlelineedit within w_recalc_objects_onhand
end type
type dw_objects from datawindow within w_recalc_objects_onhand
end type
type gb_1 from groupbox within w_recalc_objects_onhand
end type
end forward

global type w_recalc_objects_onhand from Window
int X=1
int Y=1
int Width=2926
int Height=1921
boolean TitleBar=true
string Title="Reconcile Onhand"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
st_message st_message
st_process st_process
cb_exit cb_exit
cb_start cb_start
st_percentage st_percentage
sle_percentage sle_percentage
sle_base sle_base
dw_objects dw_objects
gb_1 gb_1
end type
global w_recalc_objects_onhand w_recalc_objects_onhand

type variables
st_generic_structure stParm
end variables

on open;dw_objects.SetTransObject(sqlca)

end on

on timer;st_message.visible	= (Not st_message.visible)
end on

on w_recalc_objects_onhand.create
this.st_message=create st_message
this.st_process=create st_process
this.cb_exit=create cb_exit
this.cb_start=create cb_start
this.st_percentage=create st_percentage
this.sle_percentage=create sle_percentage
this.sle_base=create sle_base
this.dw_objects=create dw_objects
this.gb_1=create gb_1
this.Control[]={ this.st_message,&
this.st_process,&
this.cb_exit,&
this.cb_start,&
this.st_percentage,&
this.sle_percentage,&
this.sle_base,&
this.dw_objects,&
this.gb_1}
end on

on w_recalc_objects_onhand.destroy
destroy(this.st_message)
destroy(this.st_process)
destroy(this.cb_exit)
destroy(this.cb_start)
destroy(this.st_percentage)
destroy(this.sle_percentage)
destroy(this.sle_base)
destroy(this.dw_objects)
destroy(this.gb_1)
end on

type st_message from statictext within w_recalc_objects_onhand
int X=1902
int Y=977
int Width=567
int Height=337
boolean Visible=false
boolean Enabled=false
string Text="Retrieving objects, please wait"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=255
long BackColor=12632256
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_process from statictext within w_recalc_objects_onhand
int X=2634
int Y=353
int Width=247
int Height=73
boolean Visible=false
boolean Enabled=false
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_exit from commandbutton within w_recalc_objects_onhand
int X=2067
int Y=833
int Width=247
int Height=109
int TabOrder=50
string Text="Exit"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Close(parent)
end on

type cb_start from commandbutton within w_recalc_objects_onhand
int X=2067
int Y=673
int Width=247
int Height=109
int TabOrder=40
string Text="Start"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Long	 	iRow
Long		iSerial
Long		iShipper
Long		lPartRow
Dec		dOnHand
String	szPart

szPart = ""

st_message.visible		= TRUE
dw_objects.Retrieve ( )
st_message.visible		= FALSE
st_percentage.text		= "0 %"
sle_percentage.visible	= FALSE
sle_percentage.width		= 0
sle_percentage.visible	= TRUE

UPDATE part_online  
   SET on_hand = 0  ;

If SQLCA.SQLCode <> 0 Then
	MessageBox ( "Error", "Unable to reset part on hand balances to 0!", StopSign! )
	RollBack ;
	Return
Else
	Commit ;
End if

For iRow	= 1 to dw_objects.RowCount()
	
	Yield ( )

	st_percentage.text	= String(Truncate(100 * iRow / dw_objects.RowCount(), 0)) + " %"
	sle_percentage.width	= sle_base.width * iRow / dw_objects.RowCount()

	If f_get_string_value ( dw_objects.GetItemString ( iRow, "type" ) ) <> 'S' Then

		If Upper ( dw_objects.GetItemString ( iRow, "part" ) ) <> szPart Then

			If szPart <> "" Then

				UPDATE part_online  
				   SET on_hand = :dOnHand  
				 WHERE part = :szPart   ;
	
				If SQLCA.SQLCode <> 0 Then
					RollBack ;
				Else
					Commit ;
				End if

			End if
	
			dOnHand = f_get_value ( dw_objects.GetItemNumber ( iRow, "std_quantity" ) )
			szPart = Upper ( f_get_string_value ( dw_objects.GetItemString ( iRow, "part" ) ) )

		Else

			dOnHand = dOnHand + f_get_value ( dw_objects.GetItemNumber ( iRow, "std_quantity" ) )

		End If
	
	End if

Next			


end on

type st_percentage from statictext within w_recalc_objects_onhand
int X=2085
int Y=545
int Width=257
int Height=49
boolean Enabled=false
string Text="0% done"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_percentage from singlelineedit within w_recalc_objects_onhand
int X=1994
int Y=465
int Width=37
int Height=65
int TabOrder=30
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=255
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_base from singlelineedit within w_recalc_objects_onhand
int X=1994
int Y=465
int Width=403
int Height=65
int TabOrder=20
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_objects from datawindow within w_recalc_objects_onhand
int X=494
int Y=353
int Width=1390
int Height=1025
int TabOrder=10
string DataObject="d_recalc_object_onhand"
boolean VScrollBar=true
boolean LiveScroll=true
end type

type gb_1 from groupbox within w_recalc_objects_onhand
int X=385
int Y=257
int Width=2122
int Height=1201
int TabOrder=60
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

