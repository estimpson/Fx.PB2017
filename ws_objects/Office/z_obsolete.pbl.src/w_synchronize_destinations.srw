$PBExportHeader$w_synchronize_destinations.srw
forward
global type w_synchronize_destinations from window
end type
type cb_2 from commandbutton within w_synchronize_destinations
end type
type cb_1 from commandbutton within w_synchronize_destinations
end type
type dw_1 from datawindow within w_synchronize_destinations
end type
type rb_2 from radiobutton within w_synchronize_destinations
end type
type rb_1 from radiobutton within w_synchronize_destinations
end type
type st_title from statictext within w_synchronize_destinations
end type
type st_percentage from statictext within w_synchronize_destinations
end type
type sle_percentage from singlelineedit within w_synchronize_destinations
end type
type sle_base from singlelineedit within w_synchronize_destinations
end type
type gb_1 from groupbox within w_synchronize_destinations
end type
end forward

global type w_synchronize_destinations from window
integer width = 2930
integer height = 1952
boolean titlebar = true
string title = "Synchronize Destinations"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 12632256
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
rb_2 rb_2
rb_1 rb_1
st_title st_title
st_percentage st_percentage
sle_percentage sle_percentage
sle_base sle_base
gb_1 gb_1
end type
global w_synchronize_destinations w_synchronize_destinations

forward prototypes
public subroutine wf_dest ()
end prototypes

public subroutine wf_dest ();/*  Declare Variables  */

String szDestination
String szTemp

Long lRow


/*  Initialize Variables  */

dw_1.Retrieve ( )

sle_percentage.width		= 0
sle_percentage.visible	= TRUE
cb_1.Enabled				= FALSE

/*  Main  */

For lRow = 1 to dw_1.RowCount ( )

	rb_1.checked	= FALSE
	rb_2.checked	= FALSE

	sle_percentage.width	= (sle_base.width * lRow / dw_1.RowCount())
	st_percentage.text	= String(Truncate(100 * lRow / dw_1.RowCount(), 0)) + "%"

	
	szDestination 	= dw_1.GetItemString ( lRow, "destination" )
	st_title.text	= "Processing " + szDestination

	rb_1.checked	= TRUE

   SELECT destination_shipping.scac_code  
     INTO :szTemp  
     FROM destination_shipping  
    WHERE destination_shipping.destination = :szDestination   ;
	
	If SQLCA.SQLCode <> 0 Then

	  INSERT INTO destination_shipping  
		         ( destination,   
		           scac_code,   
		           trans_mode,   
		           dock_code_flag,   
		           model_year_flag,   
		           fob,   
		           freight_type,   
		           note_for_shipper,   
		           note_for_bol,   
		           print_shipper_note,   
		           print_bol_note )  
		  VALUES ( :szDestination,   
		           '',   
		           '',   
		           '',   
		           null,   
		           null,   
		           null,   
		           null,   
		           null,   
		           null,   
		           null )  ;
		
		If SQLCA.SQLCode = -1 Then
			RollBack ;
		Else
			Commit ;
		End if

	End if


	rb_2.checked	= TRUE

   SELECT edi_setups.supplier_code  
     INTO :szTemp  
     FROM edi_setups  
    WHERE edi_setups.destination = :szDestination   ;

	If SQLCA.SQLCode <> 0 Then

	  INSERT INTO edi_setups  
		         ( destination,   
		           supplier_code,   
		           trading_partner_code,   
		           release_flag,   
		           auto_create_asn,   
		           asn_overlay_group,   
		           equipment_description,   
		           pool_flag,   
		           pool_code,   
		           material_issuer,   
		           id_code_type )  
		  VALUES ( :szDestination,   
		           '',   
		           '',   
		           '',   
		           '',   
		           null,   
		           null,   
		           '',   
		           null,   
		           null,   
		           null )  ;
		
		If SQLCA.SQLCode = -1 Then
			RollBack ;
		Else
			Commit ;
		End if

	End if


Next

cb_1.Enabled				= TRUE
sle_percentage.width		= 0
sle_percentage.visible	= FALSE
st_title.text				= "Ready"



end subroutine

on open;dw_1.SetTransObject(sqlca)

end on

on w_synchronize_destinations.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.rb_2=create rb_2
this.rb_1=create rb_1
this.st_title=create st_title
this.st_percentage=create st_percentage
this.sle_percentage=create sle_percentage
this.sle_base=create sle_base
this.gb_1=create gb_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_1,&
this.rb_2,&
this.rb_1,&
this.st_title,&
this.st_percentage,&
this.sle_percentage,&
this.sle_base,&
this.gb_1}
end on

on w_synchronize_destinations.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.st_title)
destroy(this.st_percentage)
destroy(this.sle_percentage)
destroy(this.sle_base)
destroy(this.gb_1)
end on

type cb_2 from commandbutton within w_synchronize_destinations
integer x = 2158
integer y = 1248
integer width = 247
integer height = 108
integer taborder = 60
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Exit"
end type

on clicked;Close(parent)
end on

type cb_1 from commandbutton within w_synchronize_destinations
integer x = 1847
integer y = 1248
integer width = 247
integer height = 108
integer taborder = 50
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Start"
end type

on clicked;wf_dest()
end on

type dw_1 from datawindow within w_synchronize_destinations
boolean visible = false
integer x = 402
integer y = 1168
integer width = 494
integer height = 360
integer taborder = 40
string dataobject = "dw_list_of_destinations"
boolean livescroll = true
end type

type rb_2 from radiobutton within w_synchronize_destinations
integer x = 1701
integer y = 688
integer width = 603
integer height = 64
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "EDI Setups"
end type

type rb_1 from radiobutton within w_synchronize_destinations
integer x = 1701
integer y = 608
integer width = 603
integer height = 64
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Destination Shipping"
end type

type st_title from statictext within w_synchronize_destinations
integer x = 402
integer y = 368
integer width = 805
integer height = 64
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Ready"
boolean focusrectangle = false
end type

type st_percentage from statictext within w_synchronize_destinations
integer x = 1152
integer y = 640
integer width = 165
integer height = 64
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "0 %"
boolean focusrectangle = false
end type

type sle_percentage from singlelineedit within w_synchronize_destinations
integer x = 494
integer y = 640
integer width = 37
integer height = 80
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 255
boolean enabled = false
boolean autohscroll = false
end type

type sle_base from singlelineedit within w_synchronize_destinations
integer x = 494
integer y = 640
integer width = 640
integer height = 80
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
boolean autohscroll = false
end type

type gb_1 from groupbox within w_synchronize_destinations
integer x = 384
integer y = 368
integer width = 2048
integer height = 608
integer taborder = 10
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

