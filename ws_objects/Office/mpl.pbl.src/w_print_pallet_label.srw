$PBExportHeader$w_print_pallet_label.srw
forward
global type w_print_pallet_label from Window
end type
type cb_2 from commandbutton within w_print_pallet_label
end type
type sle_1 from singlelineedit within w_print_pallet_label
end type
type st_1 from statictext within w_print_pallet_label
end type
end forward

global type w_print_pallet_label from Window
int X=1166
int Y=924
int Width=1312
int Height=544
boolean TitleBar=true
string Title="Print Pallet Label"
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=response!
cb_2 cb_2
sle_1 sle_1
st_1 st_1
end type
global w_print_pallet_label w_print_pallet_label

type variables
long	i_l_shipper
end variables

forward prototypes
public subroutine wf_print_pallet_label (long iserial)
end prototypes

public subroutine wf_print_pallet_label (long iserial);st_generic_structure	stparm

String szPalletLabel
Long		ll_Order

SetNull(szPalletLabel)

SELECT shipper_detail.order_no  
  INTO :ll_Order
  FROM shipper_detail  
 WHERE shipper_detail.shipper = :i_l_shipper   ;

If SQLCA.SQLCode = 0 Then
	SELECT order_header.pallet_label  
 	  INTO :szPalletLabel
  	  FROM order_header  
	 WHERE order_header.order_no = :ll_Order   ;
End if

If f_get_string_value ( szPalletLabel ) = "" Then

	SELECT report_library.object_name  
	  INTO :szPalletLabel  
	  FROM report_library  
	 WHERE report_library.name = 'PALLET' ;

End if

stParm.Value1 = String ( iSerial )

If IsNull(szPalletLabel) then
	stparm.value12 = 'NOLABEL'
Else
	stparm.value12 = 'PALLET'
End If

f_print_label ( stparm )
end subroutine

on open;i_l_shipper = Message.DoubleParm

end on

on w_print_pallet_label.create
this.cb_2=create cb_2
this.sle_1=create sle_1
this.st_1=create st_1
this.Control[]={this.cb_2,&
this.sle_1,&
this.st_1}
end on

on w_print_pallet_label.destroy
destroy(this.cb_2)
destroy(this.sle_1)
destroy(this.st_1)
end on

type cb_2 from commandbutton within w_print_pallet_label
int X=457
int Y=304
int Width=293
int Height=128
int TabOrder=20
string Text="&Cancel"
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;CloseWithReturn ( Parent, -1 )
end on

type sle_1 from singlelineedit within w_print_pallet_label
int X=219
int Y=112
int Width=805
int Height=160
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long BackColor=16777215
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;long		l_l_serial
string	l_s_type

if upper ( LeftA ( Text, 1 ) ) = 'S' then
	Text = RightA ( Text, LenA ( Text ) - 1 )
end if

l_l_serial = Long ( Text )

SELECT	type
INTO		:l_s_type
FROM		object
WHERE		serial = :l_l_serial ;

if f_get_string_value ( l_s_type ) <> 'S' then
	MessageBox ( monsys.msg_title, "This object is not a pallet!", StopSign! )
	Text = ""
	return
end if

wf_print_pallet_label ( Long ( Text ) )

MessageBox(monsys.msg_title, "Pallet Label " + String(Long ( Text )) + " has been printed")

CloseWithReturn ( Parent, 1 )
end event

type st_1 from statictext within w_print_pallet_label
int Y=16
int Width=1298
int Height=80
boolean Enabled=false
string Text="Scan or Enter Pallet Serial Number:"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

