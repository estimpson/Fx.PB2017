$PBExportHeader$w_rma_admin_entry.srw
forward
global type w_rma_admin_entry from Window
end type
type cb_cancel from commandbutton within w_rma_admin_entry
end type
type cb_ok from commandbutton within w_rma_admin_entry
end type
type dw_entry from datawindow within w_rma_admin_entry
end type
end forward

global type w_rma_admin_entry from Window
int X=480
int Y=480
int Width=1984
int Height=976
boolean TitleBar=true
string Title="RMA Add/Update"
long BackColor=78682240
WindowType WindowType=response!
event error_message pbm_custom01
cb_cancel cb_cancel
cb_ok cb_ok
dw_entry dw_entry
end type
global w_rma_admin_entry w_rma_admin_entry

type variables
String		is_Message
String		is_ColumnName
string		is_status,&
		is_status_type
Boolean                bitemchanged = False, &
                            bitemsaved = False


end variables

forward prototypes
public function integer wf_save ()
end prototypes

on error_message;MessageBox ( "Error", is_Message, StopSign! )
dw_entry.SetColumn ( is_ColumnName )
end on

public function integer wf_save ();/* 01-28-2000 KAZ Modified to use 'of_getnextparmvalue' function instead of 'w_get_parm_value'
                  window to populate 'll_Serial' (next Shipper number).  */

Long		ll_Serial

// get the next shipper number for the new rma 
If dw_entry.Object.#1 [1] = 0  or isnull ( dw_entry.Object.#1 [1] ) Then

//	OpenWithParm ( w_get_parm_value, "shipper" )																				-  CHG 01-28-2000 KAZ
//	ll_Serial = Message.DoubleParm																								-  CHG 01-28-2000 KAZ

	if not sqlca.of_getnextparmvalue ( "shipper", ll_Serial ) then    // Failed to get current value 		-  ADD 01-28-2000 KAZ
		Rollback;																														// ADD 01-28-2000 KAZ
		MessageBox(monsys.msg_title, "Failed to get next Shipper number, Please try again", Exclamation! )	// ADD 01-28-2000 KAZ
		Return -1																														// ADD 01-28-2000 KAZ
	end if																																// ADD 01-28-2000 KAZ
	dw_entry.SetItem ( 1, 1, ll_Serial )
End if


// update the rma shipper info
If dw_entry.Update ( ) = -1 Then
	RollBack ;
	return -1
Else
	Commit ;
	return 1
End if

end function

event open;Long	ll_Rma
string	ls_customer,&
	ls_destination, &
	ls_csstatus

st_generic_structure	l_str_parm

// check if the power object is valid and get all the values passed.
if isvalid ( Message.PowerObjectParm ) then
	l_str_parm = Message.PowerObjectParm
	ll_Rma = long ( l_str_parm.value1 )
	ls_customer = string ( l_str_parm.value2 )
	ls_destination = string ( l_str_parm.value3 )
end if


// check if its a new rma or an existing one
if ll_rma <= 0  then	
	select	cs_status
	into	:ls_csstatus
	from	customer
	where	customer = :ls_customer;
	
	// insert rows and default values to the datawindow
	dw_entry.InsertRow ( 1 )
	dw_entry.SetItem ( 1, "destination", ls_destination )
	dw_entry.SetItem ( 1, "customer", ls_customer )
	dw_entry.SetItem ( 1, "status", "O" )
	dw_entry.SetItem ( 1, "type", "R" )
	dw_entry.SetItem ( 1, "date_stamp", today() )
	dw_entry.SetItem ( 1, "cs_status", ls_csstatus )	
	
else

	// retrieve the information for the rma
	dw_entry.Retrieve ( ll_Rma )

end if


end event

on w_rma_admin_entry.create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_entry=create dw_entry
this.Control[]={this.cb_cancel,&
this.cb_ok,&
this.dw_entry}
end on

on w_rma_admin_entry.destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_entry)
end on

type cb_cancel from commandbutton within w_rma_admin_entry
int X=965
int Y=760
int Width=270
int Height=100
int TabOrder=30
string Text="&Cancel"
boolean Cancel=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;bitemchanged = False
bitemsaved = True

ClosewithReturn ( Parent, 0 )
end event

type cb_ok from commandbutton within w_rma_admin_entry
int X=640
int Y=760
int Width=288
int Height=100
int TabOrder=20
boolean Enabled=false
string Text="&Ok"
boolean Default=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if wf_save ( ) = 1 then closewithreturn ( Parent, 1 )




end event

type dw_entry from datawindow within w_rma_admin_entry
int X=41
int Y=36
int Width=1879
int Height=692
int TabOrder=10
string DataObject="d_rma_admin_entry"
boolean Border=false
end type

event constructor;Settransobject ( sqlca )
end event

event itemchanged;// check if the operator password is valid 
string ls_operator

if dwo.name = 'password' then
	// to get the operator code in the operator column
	ls_operator = f_get_password ( data )
	if ls_operator > '' then
		object.operator[row] = ls_operator
		cb_ok.enabled = true
	else
		cb_ok.enabled = false
		setitem ( row, 'operator', '' )
		setitem ( row, 'password', '' )
		messagebox ( 'DataWindow Error', 'Invalid Operator Password!', Exclamation! )
		return 1
	end if	
end if

if ( dwo.name = 'notes' or dwo.name = 'date_stamp' ) and object.operator[row] > '' then
		cb_ok.enabled = true
end if

end event

event itemerror;return 1
end event

