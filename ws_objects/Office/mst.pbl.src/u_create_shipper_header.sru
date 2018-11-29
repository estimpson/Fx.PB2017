$PBExportHeader$u_create_shipper_header.sru
forward
global type u_create_shipper_header from userobject
end type
type st_1 from statictext within u_create_shipper_header
end type
type p_note from picture within u_create_shipper_header
end type
type uo_header_note from uo_note within u_create_shipper_header
end type
type cb_exit from commandbutton within u_create_shipper_header
end type
type cb_save from commandbutton within u_create_shipper_header
end type
type dw_shipper_header from datawindow within u_create_shipper_header
end type
type gb_1 from groupbox within u_create_shipper_header
end type
end forward

global type u_create_shipper_header from userobject
integer width = 1966
integer height = 916
boolean border = true
long backcolor = 12632256
st_1 st_1
p_note p_note
uo_header_note uo_header_note
cb_exit cb_exit
cb_save cb_save
dw_shipper_header dw_shipper_header
gb_1 gb_1
end type
global u_create_shipper_header u_create_shipper_header

type variables
Window wHostWindow

String szHeadNote
end variables

forward prototypes
public subroutine uf_setup (ref window wwin, string szdestination, string szcustomer, string szplant)
end prototypes

public subroutine uf_setup (ref window wwin, string szdestination, string szcustomer, string szplant);String	szAETC
String	szFreightType
String	szTransMode
String	szTerms
String	szShipVia
String	szFOB
String	ls_csstatus
String	ls_currencyunit

wHostWindow	= wWin

SELECT scac_code,   
       trans_mode,   
       fob,   
       freight_type,   
       note_for_shipper  
  INTO :szShipVia,   
       :szTransMode,   
       :szFOB,   
       :szFreightType,   
       :szHeadNote  
  FROM destination_shipping  
 WHERE destination = :szDestination   ;

select	cs_status,
	default_currency_unit
into	:ls_csstatus,
	:ls_currencyunit
from	destination
where	destination = :szDestination;


SELECT terms  
  INTO :szTerms  
  FROM customer  
 WHERE customer = :szCustomer   ;

dw_shipper_header.SetTransObject(SQLCA)
dw_shipper_header.Reset ( )
dw_shipper_header.InsertRow(1)

dw_shipper_header.SetItem(1, "date_stamp", Today())
dw_shipper_header.SetItem(1, "freight_type", szFreightType)
dw_shipper_header.SetItem(1, "status", "O")
dw_shipper_header.SetItem(1, "ship_via", szShipVia)
dw_shipper_header.SetItem(1, "notes", szHeadNote)
dw_shipper_header.SetItem(1, "terms", szTerms)
dw_shipper_header.SetItem(1, "destination", szDestination)
dw_shipper_header.SetItem(1, "customer", szCustomer)
dw_shipper_header.SetItem(1, "location", szFOB)
dw_shipper_header.SetItem(1, "trans_mode", szTransMode)
dw_shipper_header.SetItem(1, "plant", szPlant)
dw_shipper_header.SetItem(1, "invoice_printed", 'N')
dw_shipper_header.SetItem(1, "freight", 0)

dw_shipper_header.SetItem(1, "cs_status", ls_csstatus)
dw_shipper_header.SetItem(1, "currency_unit", ls_currencyunit )

If szHeadNote > ' ' then
	p_note.PictureName	= 'noteyes.bmp'
Else
	p_note.PictureName	= 'noteno.bmp'
End If


end subroutine

on u_create_shipper_header.create
this.st_1=create st_1
this.p_note=create p_note
this.uo_header_note=create uo_header_note
this.cb_exit=create cb_exit
this.cb_save=create cb_save
this.dw_shipper_header=create dw_shipper_header
this.gb_1=create gb_1
this.Control[]={this.st_1,&
this.p_note,&
this.uo_header_note,&
this.cb_exit,&
this.cb_save,&
this.dw_shipper_header,&
this.gb_1}
end on

on u_create_shipper_header.destroy
destroy(this.st_1)
destroy(this.p_note)
destroy(this.uo_header_note)
destroy(this.cb_exit)
destroy(this.cb_save)
destroy(this.dw_shipper_header)
destroy(this.gb_1)
end on

type st_1 from statictext within u_create_shipper_header
integer x = 1445
integer y = 672
integer width = 238
integer height = 48
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Note"
boolean focusrectangle = false
end type

type p_note from picture within u_create_shipper_header
integer x = 1353
integer y = 672
integer width = 73
integer height = 60
boolean originalsize = true
string picturename = "noteno.bmp"
boolean focusrectangle = false
end type

on clicked;uo_header_note.visible	= TRUE
uo_header_note.uf_setup(wHostWindow, szHeadNote)
parent.cb_save.visible	= FALSE
parent.cb_exit.visible	= FALSE

end on

type uo_header_note from uo_note within u_create_shipper_header
boolean visible = false
integer x = 366
integer y = 32
integer width = 1193
integer height = 796
end type

on uo_header_note.destroy
call uo_note::destroy
end on

type cb_exit from commandbutton within u_create_shipper_header
integer x = 1573
integer y = 784
integer width = 256
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
end type

on clicked;wHostWindow.TriggerEvent("close_shipper_uo")
end on

type cb_save from commandbutton within u_create_shipper_header
integer x = 1262
integer y = 784
integer width = 247
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Save"
boolean default = true
end type

on clicked;wHostWindow.TriggerEvent("create_shipper_header")
end on

type dw_shipper_header from datawindow within u_create_shipper_header
integer x = 73
integer y = 80
integer width = 1792
integer height = 640
integer taborder = 10
string dataobject = "dw_shipper_header_info"
boolean border = false
boolean livescroll = true
end type

type gb_1 from groupbox within u_create_shipper_header
integer x = 18
integer width = 1920
integer height = 752
integer taborder = 50
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Shipper Header Information"
end type

