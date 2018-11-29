$PBExportHeader$u_pallet_contents.sru
$PBExportComments$This user object displays graphically, the objects on a particular pallet.
forward
global type u_pallet_contents from UserObject
end type
type st_85 from statictext within u_pallet_contents
end type
type dw_objects from datawindow within u_pallet_contents
end type
end forward

global type u_pallet_contents from UserObject
int Width=1162
int Height=777
boolean Border=true
long BackColor=12632256
st_85 st_85
dw_objects dw_objects
end type
global u_pallet_contents u_pallet_contents

type variables
Window		iw_Parent
Boolean		ib_DragObject
Long		il_Serial











end variables

forward prototypes
public subroutine uf_setup (long ai_palletserial)
end prototypes

public subroutine uf_setup (long ai_palletserial);dw_objects.SetTransObject ( sqlca )
dw_objects.Retrieve ( ai_PalletSerial )

end subroutine

on dragleave;//DragObject	ldo_Object
//Picture		lp_CurrentObject
//Int			li_TabOrder
//
//ldo_Object = DraggedObject ( )
//
//Choose Case TypeOf ( ldo_Object )
//	Case Picture!
//		lp_CurrentObject	= ldo_Object
//		li_TabOrder			= lp_CurrentObject.TabOrder / 10
//		il_Serial			= Long ( ist_Serial[li_TabOrder].Text )
//End Choose
//
ib_DragObject = TRUE

TriggerEvent ( "ue_drag" )

end on

on u_pallet_contents.create
this.st_85=create st_85
this.dw_objects=create dw_objects
this.Control[]={ this.st_85,&
this.dw_objects}
end on

on u_pallet_contents.destroy
destroy(this.st_85)
destroy(this.dw_objects)
end on

type st_85 from statictext within u_pallet_contents
int X=19
int Width=1025
int Height=65
boolean Enabled=false
string Text="Objects On Pallet:"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_objects from datawindow within u_pallet_contents
int Y=65
int Width=1153
int Height=705
int TabOrder=10
string DragIcon="BOX.ICO"
string DataObject="d_pallet_objects"
boolean Border=false
boolean VScrollBar=true
boolean LiveScroll=true
end type

on dragleave;ib_DragObject = TRUE

Parent.TriggerEvent ( "ue_drag" )
end on

on clicked;Long		ll_Row, &
			ll_Column

ll_Row 		= GetClickedRow ( )
ll_Column	= GetClickedColumn ( )

If ll_Row < 1 Or ll_Column < 1 Then Return

il_Serial = GetItemNumber ( ll_Row, "serial" )

Drag ( Begin! )
end on

