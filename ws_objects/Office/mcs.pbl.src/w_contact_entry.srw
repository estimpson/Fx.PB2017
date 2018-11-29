$PBExportHeader$w_contact_entry.srw
forward
global type w_contact_entry from Window
end type
type st_1 from statictext within w_contact_entry
end type
type dw_2 from datawindow within w_contact_entry
end type
type cb_2 from commandbutton within w_contact_entry
end type
type cb_1 from commandbutton within w_contact_entry
end type
type dw_1 from datawindow within w_contact_entry
end type
end forward

global type w_contact_entry from Window
int X=832
int Y=360
int Width=2496
int Height=1508
boolean TitleBar=true
string Title="Contact Entry"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
st_1 st_1
dw_2 dw_2
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_contact_entry w_contact_entry

type variables
string	is_customer, &
	is_destination
boolean	ib_modified=true

end variables

on w_contact_entry.create
this.st_1=create st_1
this.dw_2=create dw_2
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.dw_2,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_contact_entry.destroy
destroy(this.st_1)
destroy(this.dw_2)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;st_generic_structure	l_str_parm

l_str_parm = Message.PowerObjectParm

IF isnull ( l_str_parm.value1, '' ) > '' THEN
	dw_1.Retrieve ( l_str_parm.value1 )
	dw_2.Retrieve ( l_str_parm.value1 )
ELSE
	dw_1.InsertRow ( 1 )
	if l_str_parm.value2 = 'Customer Service' then 
		dw_1.SetItem ( 1, "customer", l_str_parm.value3 )
		dw_1.SetItem ( 1, "destination", '')		
		is_customer = l_str_parm.value3
		is_destination = ''
	else
		dw_1.SetItem ( 1, "customer", l_str_parm.value2 )	
		dw_1.SetItem ( 1, "destination", l_str_parm.value3 )		
		is_customer = l_str_parm.value2
		is_destination = l_str_parm.value3
	end if 	
END IF

end event

event closequery;int	l_i_returncode
//if dw_1.ModifiedCount ( ) > 0 then
if ib_Modified then	
	l_i_returncode = MessageBox ( "Contact Entry", "Would you like to save your changes?", Question!, YesNoCancel!, 1 )
	Choose Case l_i_returncode
		Case 1
			if dw_1.Update ( ) = -1 then
				rollback;
				MessageBox ( monsys.msg_title, "Unable to save contact!", Exclamation! )
				return 1
			else
				commit;
				return 0
			end if
		Case 2
			return 0
		Case 3
			return 1
	End Choose
end if
end event

type st_1 from statictext within w_contact_entry
int X=18
int Y=720
int Width=512
int Height=64
boolean Enabled=false
string Text="Previous Calls:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_2 from datawindow within w_contact_entry
int X=18
int Y=800
int Width=2432
int Height=480
int TabOrder=20
string DataObject="d_call_log_per_contact"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type

event constructor;SetTransObject ( sqlca )
end event

type cb_2 from commandbutton within w_contact_entry
int X=293
int Y=1296
int Width=279
int Height=108
int TabOrder=40
string Text="&Cancel"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn ( Parent, 0 )
end event

type cb_1 from commandbutton within w_contact_entry
int X=18
int Y=1296
int Width=247
int Height=108
int TabOrder=30
string Text="&Ok"
boolean Default=true
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.AcceptText ( )

//if dw_1.ModifiedCount ( ) > 0 then
if ib_Modified then	
	if dw_1.Update ( ) = -1 then
		rollback;
		MessageBox ( monsys.msg_title, "Unable to save contact!", StopSign! )
	else
		commit;
	end if
end if

CloseWithReturn ( Parent, 1 )

end event

type dw_1 from datawindow within w_contact_entry
int X=18
int Y=16
int Width=2231
int Height=688
int TabOrder=10
string DataObject="d_contact_entry"
boolean Border=false
boolean LiveScroll=true
end type

event constructor;SetTransObject ( sqlca )
end event

event itemchanged;string	ls_name, &
	ls_message
int	li_count
ib_modified = true
if dwo.name = 'name' then 
	ls_name = data
	if is_destination = 'Customer Service' then is_destination = ''
	// Check with customer and destination level if not found 
	select	isnull(count(name),0)
	into	:li_count
	from	contact
	where	name = :ls_name and
		customer = :is_customer and
		destination = :is_destination;
	ls_message = "Contact '"+ls_name+"' already exist for customer - '" + is_customer +"' and destination - '" + is_destination + "'"
	// check with only customer level if not found	
	if li_count = 0 then 
		select	isnull(count(name),0)
		into	:li_count
		from	contact
		where	name = :ls_name and
			customer = :is_customer;
		ls_message = "Contact '"+ls_name+"' already exist for customer - '" + is_customer +"'"
	end if 	
	// check just for the existence of the contact name in the table as that's 
	//  part of the key
	if li_count = 0 then 
		select	isnull(count(name),0)
		into	:li_count
		from	contact
		where	name = :ls_name;
		ls_message = "Contact '"+ls_name+"' already exist "
	end if 	
	if li_count > 0 then 
		Messagebox ( monsys.msg_title, ls_message)
		setitem ( row, 'name',"" ) 
		ib_modified = false
		return 1
	else
		ib_modified = true
	end if 	
end if
end event

event itemerror;return 1
end event

