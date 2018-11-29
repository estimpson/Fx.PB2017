$PBExportHeader$w_pallet.srw
forward
global type w_pallet from Window
end type
type st_2 from statictext within w_pallet
end type
type ddlb_2 from dropdownlistbox within w_pallet
end type
type em_pallet from editmask within w_pallet
end type
type rb_old from radiobutton within w_pallet
end type
type cb_clear from commandbutton within w_pallet
end type
type cb_8 from commandbutton within w_pallet
end type
type cb_0 from commandbutton within w_pallet
end type
type cb_9 from commandbutton within w_pallet
end type
type cb_12 from commandbutton within w_pallet
end type
type cb_7 from commandbutton within w_pallet
end type
type cb_6 from commandbutton within w_pallet
end type
type cb_5 from commandbutton within w_pallet
end type
type cb_4 from commandbutton within w_pallet
end type
type cb_3 from commandbutton within w_pallet
end type
type cb_2 from commandbutton within w_pallet
end type
type cb_1 from commandbutton within w_pallet
end type
type cb_35 from commandbutton within w_pallet
end type
type rb_new from radiobutton within w_pallet
end type
type st_1 from statictext within w_pallet
end type
type ddlb_1 from dropdownlistbox within w_pallet
end type
end forward

global type w_pallet from Window
int X=434
int Y=412
int Width=2016
int Height=1228
boolean TitleBar=true
string Title="Complete to Pallet"
long BackColor=77897888
boolean ControlMenu=true
WindowType WindowType=response!
st_2 st_2
ddlb_2 ddlb_2
em_pallet em_pallet
rb_old rb_old
cb_clear cb_clear
cb_8 cb_8
cb_0 cb_0
cb_9 cb_9
cb_12 cb_12
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
cb_35 cb_35
rb_new rb_new
st_1 st_1
ddlb_1 ddlb_1
end type
global w_pallet w_pallet

type variables
String	is_Operator
string	i_s_package_type
String          i_s_location
end variables

forward prototypes
public subroutine wf_buttons (boolean ab_mode)
public function boolean wf_check_pallet ()
public subroutine wf_get_package_types ()
public function long wf_create_pallet (string a_s_package_type)
public subroutine wf_get_locations ()
end prototypes

public subroutine wf_buttons (boolean ab_mode);cb_0.Enabled		= ab_Mode
cb_1.Enabled		= ab_Mode
cb_2.Enabled		= ab_Mode
cb_3.Enabled		= ab_Mode
cb_4.Enabled		= ab_Mode
cb_5.Enabled		= ab_Mode
cb_6.Enabled		= ab_Mode
cb_7.Enabled		= ab_Mode
cb_8.Enabled		= ab_Mode
cb_9.Enabled		= ab_Mode
cb_clear.Enabled	= ab_Mode
em_pallet.Enabled	= ab_Mode
if i_s_package_type = 'Y' then
	ddlb_1.Enabled		= Not ab_Mode
end if
end subroutine

public function boolean wf_check_pallet ();Long	l_Temp, &
		l_Pallet

l_Pallet = Long ( em_pallet.Text )

SELECT object.serial  
  INTO :l_Temp  
  FROM object  
 WHERE ( object.serial = :l_Pallet ) AND  
       ( object.type = 'S' )   ;

IF SQLCA.SQLCode = 0 THEN
	Return TRUE
ELSE
	Return FALSE
END IF

end function

public subroutine wf_get_package_types ();string	l_s_code

 DECLARE package_types CURSOR FOR  
  SELECT package_materials.code  
    FROM package_materials  
   WHERE package_materials.type = 'P'   
ORDER BY package_materials.code ASC  ;

Open package_types ;
Fetch package_types into :l_s_code ;
Do While sqlca.sqlcode = 0
	ddlb_1.AddItem ( l_s_code )
	Fetch package_types into :l_s_code ;
Loop
Close package_types ;
end subroutine

public function long wf_create_pallet (string a_s_package_type);Long		l_Serial
Date		d_Today
Dec		l_dec_weight
string		ls_locs

bFinish = FALSE
//OpenWithParm ( w_get_parm_value, "next_serial" )
//Do
//Loop While NOT bFinish
//l_Serial = Message.DoubleParm

IF SQLCA.of_getnextparmvalue ( 'next_serial', l_Serial )  THEN

	if a_s_package_type > '' then
  		SELECT 	package_materials.weight  
    	INTO 		:l_dec_weight  
    	FROM 		package_materials  
   	WHERE 	package_materials.code = :a_s_package_type   ;
	else
		l_dec_weight = 0
	end if

	if isnull(i_s_location,'') = '' then i_s_location = ddlb_2.text
	
	d_Today = Today ( )
// included location in the insert & as well as to the audit_trail

	INSERT INTO object  
	          ( serial,   
	            part,   
	            location,   
	            last_date,   
	            unit_measure,   
	            operator,   
	            status,   
	            destination,   
	            station,   
	            origin,   
	            cost,   
	            weight,   
	            parent_serial,   
	            note,   
	            quantity,   
	            last_time,   
	            date_due,   
	            customer,   
	            sequence,   
	            shipper,   
	            lot,   
	            type,   
	            po_number,   
	            name,   
	            plant,   
	            start_date,   
	            std_quantity,   
	            package_type,   
	            field1,   
	            field2,   
	            custom1,   
	            custom2,   
	            custom3,   
	            custom4,   
	            custom5,   
	            show_on_shipper,   
	            tare_weight,   
	            suffix )  
	   VALUES ( :l_Serial,   
	            'PALLET',   
	            :i_s_location,   
	            :d_Today,   
	            null,   
	            :is_Operator,   
	            'A',   
	            null,   
	            null,   
	            null,   
	            null,   
	            null,   
	            null,   
	            null,   
	            null,   
	            null,   
	            null,   
	            null,   
	            null,   
	            null,   
	            null,   
	            'S',   
	            null,   
	            null,   
	            null,   
	            null,   
	            null,   
	            :a_s_package_type,   
	            null,   
	            null,   
	            null,   
	            null,   
	            null,   
	            null,   
	            null,   
	            'Y',   
	            :l_dec_weight,   
	            null )  ;
	
	IF SQLCA.SQLCode = 0 THEN
		if f_create_audit_trail ( l_serial, "P", i_s_location, '', '', "", '', '', "", "", "", "No Commit" ) then
			COMMIT ;
			Return l_Serial
		else
			Rollback;
			return -1
		end if
	ELSE
		ROLLBACK ;
		Return -1
	END IF
else
	rollback ;
	return -1
END IF

end function

public subroutine wf_get_locations ();string	ls_code

 DECLARE locs CURSOR FOR  
  SELECT machine.machine_no
    FROM machine
ORDER BY machine_no ASC  ;

Open locs ;
Fetch locs into :ls_code ;
Do While sqlca.sqlcode = 0
	ddlb_2.AddItem ( ls_code )
	Fetch locs into :ls_code ;
Loop
Close locs ;
end subroutine

event open;st_generic_structure	lstr_parm

if IsValid ( Message.PowerObjectParm ) then

	lstr_parm = Message.PowerObjectParm
	is_Operator = lstr_parm.value1
	if f_get_string_value ( lstr_parm.value2 ) > "" then &
		Title = "Complete to Pallet for Part:  " + lstr_parm.value2
   // included the 3rd parameter as the location		
   i_s_location = lstr_parm.value3
else

	is_Operator = Message.StringParm

end if

SELECT 	parameters.pallet_package_type  
INTO 		:i_s_package_type  
FROM 		parameters  ;

if i_s_package_type = 'Y' then
	wf_get_package_types ( )
	ddlb_1.Enabled = TRUE
end if
wf_get_locations ()


end event

on w_pallet.create
this.st_2=create st_2
this.ddlb_2=create ddlb_2
this.em_pallet=create em_pallet
this.rb_old=create rb_old
this.cb_clear=create cb_clear
this.cb_8=create cb_8
this.cb_0=create cb_0
this.cb_9=create cb_9
this.cb_12=create cb_12
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_35=create cb_35
this.rb_new=create rb_new
this.st_1=create st_1
this.ddlb_1=create ddlb_1
this.Control[]={this.st_2,&
this.ddlb_2,&
this.em_pallet,&
this.rb_old,&
this.cb_clear,&
this.cb_8,&
this.cb_0,&
this.cb_9,&
this.cb_12,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.cb_35,&
this.rb_new,&
this.st_1,&
this.ddlb_1}
end on

on w_pallet.destroy
destroy(this.st_2)
destroy(this.ddlb_2)
destroy(this.em_pallet)
destroy(this.rb_old)
destroy(this.cb_clear)
destroy(this.cb_8)
destroy(this.cb_0)
destroy(this.cb_9)
destroy(this.cb_12)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_35)
destroy(this.rb_new)
destroy(this.st_1)
destroy(this.ddlb_1)
end on

type st_2 from statictext within w_pallet
int X=55
int Y=596
int Width=293
int Height=56
boolean Enabled=false
string Text="Location:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ddlb_2 from dropdownlistbox within w_pallet
int X=55
int Y=656
int Width=1115
int Height=456
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
long BackColor=16777215
int TextSize=-18
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_pallet from editmask within w_pallet
int X=55
int Y=448
int Width=1024
int Height=132
int TabOrder=20
boolean Enabled=false
BorderStyle BorderStyle=StyleLowered!
string Mask="###########"
long BackColor=16777215
int TextSize=-18
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_old from radiobutton within w_pallet
int X=55
int Y=328
int Width=1024
int Height=116
string Text="Existing Pallet"
long TextColor=33554432
long BackColor=77897888
int TextSize=-20
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_buttons ( TRUE )
em_pallet.SetFocus ( )
end on

type cb_clear from commandbutton within w_pallet
int X=1458
int Y=592
int Width=512
int Height=192
boolean Enabled=false
string Text="Clear"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;em_pallet.Text = ""

end on

type cb_8 from commandbutton within w_pallet
int X=1458
int Y=16
int Width=256
int Height=192
boolean Enabled=false
string Text="8"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;em_pallet.Text = em_Pallet.Text + "8"

end on

type cb_0 from commandbutton within w_pallet
int X=1202
int Y=592
int Width=256
int Height=192
boolean Enabled=false
string Text="0"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;IF f_get_string_value ( em_pallet.Text ) > "" THEN &
	em_pallet.Text = em_Pallet.Text + "0"


end on

type cb_9 from commandbutton within w_pallet
int X=1714
int Y=16
int Width=256
int Height=192
boolean Enabled=false
string Text="9"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;em_pallet.Text = em_Pallet.Text + "9"


end on

type cb_12 from commandbutton within w_pallet
int X=27
int Y=928
int Width=965
int Height=192
int TabOrder=40
string Text="Cancel"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;CloseWithReturn ( Parent, 0 )
end on

type cb_7 from commandbutton within w_pallet
int X=1202
int Y=16
int Width=256
int Height=192
boolean Enabled=false
string Text="7"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;em_pallet.Text = em_Pallet.Text + "7"

end on

type cb_6 from commandbutton within w_pallet
int X=1714
int Y=208
int Width=256
int Height=192
boolean Enabled=false
string Text="6"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;em_pallet.Text = em_Pallet.Text + "6"

end on

type cb_5 from commandbutton within w_pallet
int X=1458
int Y=208
int Width=256
int Height=192
boolean Enabled=false
string Text="5"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;em_pallet.Text = em_Pallet.Text + "5"

end on

type cb_4 from commandbutton within w_pallet
int X=1202
int Y=208
int Width=256
int Height=192
boolean Enabled=false
string Text="4"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;em_pallet.Text = em_Pallet.Text + "4"

end on

type cb_3 from commandbutton within w_pallet
int X=1714
int Y=400
int Width=256
int Height=192
boolean Enabled=false
string Text="3"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;em_pallet.Text = em_Pallet.Text + "3"

end on

type cb_2 from commandbutton within w_pallet
int X=1458
int Y=400
int Width=256
int Height=192
boolean Enabled=false
string Text="2"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;em_pallet.Text = em_Pallet.Text + "2"

end on

type cb_1 from commandbutton within w_pallet
int X=1202
int Y=400
int Width=256
int Height=192
boolean Enabled=false
string Text="1"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;em_pallet.Text = em_Pallet.Text + "1"

end on

type cb_35 from commandbutton within w_pallet
int X=997
int Y=928
int Width=983
int Height=192
int TabOrder=30
string Text="Enter"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;IF rb_new.Checked THEN
	if isnull(i_s_location,'')='' and isnull(ddlb_2.text,'') = '' then 
		Messagebox(Monsys.msg_title, "Please select a valid location!")
		return 
	end if 	
	CloseWithReturn ( Parent, wf_create_pallet ( ddlb_1.Text ) )
ELSE
	IF wf_check_pallet ( ) THEN
		CloseWithReturn ( Parent, Long ( em_pallet.Text ) )
	ELSE
		MessageBox ( "Error", "Invalid pallet number!  Please enter a valid one.", StopSign! )
	END IF
END IF
end event

type rb_new from radiobutton within w_pallet
int X=55
int Y=16
int Width=745
int Height=100
string Text="New Pallet"
boolean Checked=true
long TextColor=33554432
long BackColor=77897888
int TextSize=-20
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_buttons ( FALSE )

end on

type st_1 from statictext within w_pallet
int X=55
int Y=124
int Width=585
int Height=64
boolean Enabled=false
string Text="Package Type:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ddlb_1 from dropdownlistbox within w_pallet
int X=55
int Y=192
int Width=1115
int Height=800
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
long BackColor=16777215
int TextSize=-16
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

