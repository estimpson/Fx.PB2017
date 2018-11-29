$PBExportHeader$u_boxes_on_pallet.sru
forward
global type u_boxes_on_pallet from UserObject
end type
type p_1 from picture within u_boxes_on_pallet
end type
type st_1 from statictext within u_boxes_on_pallet
end type
type dw_boxes_on_pallet from datawindow within u_boxes_on_pallet
end type
end forward

global type u_boxes_on_pallet from UserObject
int Width=1705
int Height=540
boolean Border=true
long BackColor=12632256
long PictureMaskColor=25166016
long TabBackColor=67108864
p_1 p_1
st_1 st_1
dw_boxes_on_pallet dw_boxes_on_pallet
end type
global u_boxes_on_pallet u_boxes_on_pallet

type variables
Boolean		ib_DragObject
Long		il_Serial, &
		il_PalletSerial
end variables

forward prototypes
public subroutine uf_setup (boolean ab_mode, long al_serial)
end prototypes

public subroutine uf_setup (boolean ab_mode, long al_serial);IF ab_Mode THEN
	dw_boxes_on_pallet.SetTransObject ( sqlca )
	dw_boxes_on_pallet.Retrieve ( al_Serial )
	st_1.Text = "Boxes On Pallet: " + String ( al_Serial )
	il_PalletSerial = al_Serial
ELSE
	dw_boxes_on_pallet.Reset ( )
END IF

end subroutine

on u_boxes_on_pallet.create
this.p_1=create p_1
this.st_1=create st_1
this.dw_boxes_on_pallet=create dw_boxes_on_pallet
this.Control[]={this.p_1,&
this.st_1,&
this.dw_boxes_on_pallet}
end on

on u_boxes_on_pallet.destroy
destroy(this.p_1)
destroy(this.st_1)
destroy(this.dw_boxes_on_pallet)
end on

type p_1 from picture within u_boxes_on_pallet
int Width=73
int Height=60
boolean Visible=false
string PictureName="exit1.bmp"
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
boolean FocusRectangle=false
end type

on clicked;Parent.TriggerEvent ( "ue_hide" )
end on

type st_1 from statictext within u_boxes_on_pallet
int Width=1682
int Height=64
boolean Enabled=false
string Text="Boxes On Pallet:"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=12632256
long BackColor=8421504
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_boxes_on_pallet from datawindow within u_boxes_on_pallet
int Y=64
int Width=1682
int Height=464
int TabOrder=1
string DragIcon="BOX.ICO"
string DataObject="dw_boxes_on_pallet_pl"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event clicked;Long	ll_Row

ll_Row = GetClickedRow ( )

IF ll_Row < 1 THEN Return

il_Serial = GetItemNumber ( ll_Row, "serial" )

SelectRow(0, FALSE)
SelectRow(ll_Row, TRUE)

ib_DragObject = TRUE

Parent.TriggerEvent ( "ue_drag" )

Drag ( Begin! )

end event

