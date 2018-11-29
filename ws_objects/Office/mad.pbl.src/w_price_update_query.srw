$PBExportHeader$w_price_update_query.srw
forward
global type w_price_update_query from Window
end type
type cb_3 from commandbutton within w_price_update_query
end type
type cbx_1 from checkbox within w_price_update_query
end type
type cbx_2 from checkbox within w_price_update_query
end type
type cbx_3 from checkbox within w_price_update_query
end type
type cb_1 from commandbutton within w_price_update_query
end type
type cb_2 from commandbutton within w_price_update_query
end type
type st_1 from statictext within w_price_update_query
end type
end forward

global type w_price_update_query from Window
int X=567
int Y=412
int Width=1806
int Height=788
long BackColor=80269524
WindowType WindowType=response!
cb_3 cb_3
cbx_1 cbx_1
cbx_2 cbx_2
cbx_3 cbx_3
cb_1 cb_1
cb_2 cb_2
st_1 st_1
end type
global w_price_update_query w_price_update_query

on w_price_update_query.create
this.cb_3=create cb_3
this.cbx_1=create cbx_1
this.cbx_2=create cbx_2
this.cbx_3=create cbx_3
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_1=create st_1
this.Control[]={this.cb_3,&
this.cbx_1,&
this.cbx_2,&
this.cbx_3,&
this.cb_1,&
this.cb_2,&
this.st_1}
end on

on w_price_update_query.destroy
destroy(this.cb_3)
destroy(this.cbx_1)
destroy(this.cbx_2)
destroy(this.cbx_3)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_1)
end on

event open;string ls_part, &
		 ls_customer, &
		 ls_temp, &
		 ls_window

st_generic_structure lst_values

lst_values = message.powerobjectparm

st_1.text = "Price has been changed for Part:   " + lst_values.value1 + "  and Customer: " +  &
					lst_values.value2 +	"  Would you like to:  "
					
if LenA (lst_values.value3 ) > 0 and lst_values.value3 = 'w_customer_price_matrix' then
	cbx_1.text = 'Update all open orders for this part with new price?'	
end if
		

end event

type cb_3 from commandbutton within w_price_update_query
int X=1015
int Y=596
int Width=247
int Height=108
int TabOrder=10
string Text="Cancel"
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_1 from checkbox within w_price_update_query
int X=69
int Y=248
int Width=1641
int Height=76
string Text="Update the setup for this part and customer with new price?"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_2 from checkbox within w_price_update_query
int X=64
int Y=360
int Width=1641
int Height=76
string Text="Update all open shippers for this part with new price?"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_3 from checkbox within w_price_update_query
int X=64
int Y=476
int Width=1641
int Height=76
string Text="Update all un-printed invoices for this part with new price?"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_price_update_query
int X=352
int Y=596
int Width=247
int Height=108
int TabOrder=10
string Text="Ok"
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;st_generic_structure lst_values

if cbx_1.checked then
	lst_values.value1  = 'Y'
else
	lst_values.value1  = 'N'
end if

if cbx_2.checked then
	lst_values.value2  = 'Y'
else
	lst_values.value2  = 'N'
end if

if cbx_3.checked then
	lst_values.value3  = 'Y'
else
	lst_values.value3  = 'N'
end if

closewithreturn ( w_price_update_query, lst_values )
end event

type cb_2 from commandbutton within w_price_update_query
int X=690
int Y=596
int Width=247
int Height=108
int TabOrder=20
string Text="No"
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;st_generic_structure lst_values

lst_values.value1  = 'N'
lst_values.value2  = 'N'
lst_values.value3  = 'N'

closewithreturn ( w_price_update_query, lst_values )
end event

type st_1 from statictext within w_price_update_query
int X=82
int Y=48
int Width=1641
int Height=164
boolean Enabled=false
string Text="Price has been changed on this part, customer. Would you like to:"
boolean FocusRectangle=false
long BackColor=80269524
int TextSize=-9
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

