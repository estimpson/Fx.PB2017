$PBExportHeader$w_newreleasepopup.srw
forward
global type w_newreleasepopup from Window
end type
type cb_cancel from commandbutton within w_newreleasepopup
end type
type dw_new_release from datawindow within w_newreleasepopup
end type
type cb_ok from commandbutton within w_newreleasepopup
end type
end forward

type str_new_release from structure
	datetime		due_date
	decimal {6}	quantity
	string		order_queue
	string		notes
	string		forecast_type
end type

global type w_newreleasepopup from Window
int X=471
int Y=576
int Width=1138
int Height=544
boolean TitleBar=true
string Title="Enter information to create new release..."
long BackColor=78682240
WindowType WindowType=response!
cb_cancel cb_cancel
dw_new_release dw_new_release
cb_ok cb_ok
end type
global w_newreleasepopup w_newreleasepopup

type variables
Private:
long	il_OrderNo
end variables

on w_newreleasepopup.create
this.cb_cancel=create cb_cancel
this.dw_new_release=create dw_new_release
this.cb_ok=create cb_ok
this.Control[]={this.cb_cancel,&
this.dw_new_release,&
this.cb_ok}
end on

on w_newreleasepopup.destroy
destroy(this.cb_cancel)
destroy(this.dw_new_release)
destroy(this.cb_ok)
end on

event open;//	Initialize order number.
il_OrderNo = message.DoubleParm
end event

type cb_cancel from commandbutton within w_newreleasepopup
int X=782
int Y=104
int Width=297
int Height=84
int TabOrder=30
string Text="Cancel"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn ( parent, -1 )
end event

type dw_new_release from datawindow within w_newreleasepopup
int X=5
int Y=8
int Width=741
int Height=396
int TabOrder=10
string DataObject="d_new_release"
boolean Border=false
boolean LiveScroll=true
end type

event itemchanged;AcceptText ( )

//	Enable ok button if quantity has been entered and is greater than 0.
if object.quantity [ 1 ] > 0 then
	cb_ok.Enabled = true
end if
end event

type cb_ok from commandbutton within w_newreleasepopup
int X=782
int Y=4
int Width=297
int Height=84
int TabOrder=20
boolean Enabled=false
string Text="Ok"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//  Update releases from EDI data.

//  Declarations.
constant string	MESSAGE862 = '862-Release created thru stored procedure'
constant string MESSAGE830 = '830-Release created thru stored procedure'

string	ls_Note

str_new_release	lst_NewRelease

lst_NewRelease = dw_new_release.object.data [ 1 ]

//  As long as new quantity is more than zero, create new inserted release for this order, date, and quantity.
if lst_NewRelease.quantity > 0 then
	//  Assign appropriate note.
	choose case lst_NewRelease.notes
		case '862'
			ls_Note = MESSAGE862
		case '830'
			ls_Note = MESSAGE830
		case else
			SetNull ( ls_Note )
	end choose
	choose case SQLCA.of_CreateInsertedRelease ( il_OrderNo, lst_NewRelease.due_date, lst_NewRelease.quantity, lst_NewRelease.order_queue, ls_Note, lst_NewRelease.forecast_type )
		case 0
			SQLCA.uf_Commit ( )
		case 100
			MessageBox ( monsys.msg_title, 'Order not found.' )
		case -1
			MessageBox ( monsys.msg_title, 'Error adding release.' )
	end choose
end if

CloseWithReturn ( parent, 0 )
end event

