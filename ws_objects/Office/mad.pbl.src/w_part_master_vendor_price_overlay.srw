$PBExportHeader$w_part_master_vendor_price_overlay.srw
forward
global type w_part_master_vendor_price_overlay from Window
end type
type dw_2 from datawindow within w_part_master_vendor_price_overlay
end type
type dw_1 from datawindow within w_part_master_vendor_price_overlay
end type
type gb_2 from groupbox within w_part_master_vendor_price_overlay
end type
type gb_1 from groupbox within w_part_master_vendor_price_overlay
end type
end forward

global type w_part_master_vendor_price_overlay from Window
int X=50
int Y=948
int Width=2825
int Height=824
boolean TitleBar=true
string Title="Vendor Price Matrix"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=child!
dw_2 dw_2
dw_1 dw_1
gb_2 gb_2
gb_1 gb_1
end type
global w_part_master_vendor_price_overlay w_part_master_vendor_price_overlay

type variables
String szPart, szVendor
end variables

on close;If gnv_App.of_GetFrame().MenuName <> "m_part_master" Then &
	gnv_App.of_GetFrame().ChangeMenu ( m_part_master )

end on

on open;//
//  Initialize Variables
//

szPart = Message.StringParm

//
//  Set Transaction objects
//

dw_1.SetTransObject ( sqlca )
dw_2.SetTransObject ( sqlca )


//
//  Grab vendors setup for part
//

dw_1.Retrieve ( szPart )

If dw_1.RowCount ( ) > 0 Then

	szVendor = dw_1.GetItemString ( 1, "vendor" )

	dw_2.Retrieve ( szPart, szVendor )

End if

end on

on deactivate;gnv_App.of_GetFrame().ChangeMenu ( mMenu )
end on

on w_part_master_vendor_price_overlay.create
this.dw_2=create dw_2
this.dw_1=create dw_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.dw_2,&
this.dw_1,&
this.gb_2,&
this.gb_1}
end on

on w_part_master_vendor_price_overlay.destroy
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.gb_2)
destroy(this.gb_1)
end on

on activate;gnv_App.of_GetFrame().ChangeMenu ( m_part_master_vendor_matrix )
end on

type dw_2 from datawindow within w_part_master_vendor_price_overlay
int X=1938
int Y=64
int Width=841
int Height=640
int TabOrder=20
string DataObject="d_part_master_vendor_price_matrix"
boolean Border=false
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_1 from datawindow within w_part_master_vendor_price_overlay
int X=37
int Y=64
int Width=1792
int Height=640
int TabOrder=10
string DataObject="d_part_master_vendor_part_list"
boolean Border=false
boolean VScrollBar=true
boolean LiveScroll=true
end type

on clicked;//
//  Declare variables
//

Long lRow


//
//  Initialize Variables
//

lRow = dw_1.GetClickedRow ( )

If lRow < 1 Then Return

SelectRow ( dw_1, 0, False )
SelectRow ( dw_1, lRow, True )

dw_2.Retrieve ( szPart, dw_1.GetItemString ( lRow, "vendor" ) )


end on

type gb_2 from groupbox within w_part_master_vendor_price_overlay
int X=1902
int Width=914
int Height=736
string Text="Pricing:"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_part_master_vendor_price_overlay
int Width=1865
int Height=736
string Text="Vendor's List of Parts:"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

