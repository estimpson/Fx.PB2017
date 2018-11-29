$PBExportHeader$w_edi_asn_parameter_setups.srw
forward
global type w_edi_asn_parameter_setups from Window
end type
type st_edi_directory from statictext within w_edi_asn_parameter_setups
end type
type st_asn_directory from statictext within w_edi_asn_parameter_setups
end type
type lb_2 from ulb_smart_directory within w_edi_asn_parameter_setups
end type
type lb_1 from ulb_smart_directory within w_edi_asn_parameter_setups
end type
type st_4 from statictext within w_edi_asn_parameter_setups
end type
type sle_days from editmask within w_edi_asn_parameter_setups
end type
type st_3 from statictext within w_edi_asn_parameter_setups
end type
type st_2 from statictext within w_edi_asn_parameter_setups
end type
type ddlb_auto from dropdownlistbox within w_edi_asn_parameter_setups
end type
type st_1 from statictext within w_edi_asn_parameter_setups
end type
end forward

global type w_edi_asn_parameter_setups from Window
int X=1
int Y=1
int Width=2917
int Height=1937
boolean TitleBar=true
string Title="EDI / ASN Parameter Setups"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event updt pbm_custom01
st_edi_directory st_edi_directory
st_asn_directory st_asn_directory
lb_2 lb_2
lb_1 lb_1
st_4 st_4
sle_days sle_days
st_3 st_3
st_2 st_2
ddlb_auto ddlb_auto
st_1 st_1
end type
global w_edi_asn_parameter_setups w_edi_asn_parameter_setups

type variables
Boolean bitemchanged = False

STRING	is_INIFileName
end variables

on updt;String	szAutoScan

Integer	iDays

iDays		= Long(sle_days.text)

If Sign(iDays) = -1 Then

  MessageBox ( "Data Error", "Days cannot be negative!", StopSign! )
  bitemchanged = True
  sle_days.Text =  "" 
  Return

End If

szAutoScan	= ddlb_auto.text

If szAutoScan > '' Then
	If szAutoScan = 'Yes' Then
		szAutoScan = 'Y'
	Else
		szAutoScan = 'N'
	End If
End If



  UPDATE parameters  
     SET edi_process_days = :iDays,   
         set_asn_uop = :szAutoScan  ;

If SQLCA.SQLCode = 0 then
	Commit;
	bitemchanged = False
Else
	Rollback;
	MessageBox ( "SQL Error", SQLCA.SQLErrText, StopSign! )
End If

IF SetProfileString ( is_INIFileName, 'EDI PARMS', 'ASNDirectory', st_asn_directory.Text ) = -1 THEN
	MessageBox ( 'Error', 'Unable to write ASN directory to Monitor INI file!' )
END IF
IF SetProfileString ( is_INIFileName, 'EDI PARMS', 'EDIDirectory', st_edi_directory.Text ) = -1 THEN
	MessageBox ( 'Error', 'Unable to write EDI directory to Monitor INI file!' )
END IF

end on

event open;Integer iDays

String	szAutoScan

  SELECT parameters.edi_process_days,   
         parameters.set_asn_uop   
    INTO :iDays,   
         :szAutoScan  
    FROM parameters  ;

ddlb_auto.text			= szAutoScan
sle_days.text			= String(iDays)

is_INIFileName = monsys.root + '\monitor.ini'
IF NOT FileExists ( is_INIFileName ) THEN
	is_INIFileName = 'c:\windows\monitor.ini'
	IF NOT FileExists ( is_INIFileName ) THEN
		MessageBox ( 'Error', 'Unable to locate Monitor INI File!' )
		Return
	END IF
END IF

lb_1.is_Path = ProfileString ( is_INIFileName, 'EDI PARMS', 'ASNDirectory', 'c:\' )
lb_2.is_Path = ProfileString ( is_INIFileName, 'EDI PARMS', 'EDIDirectory', 'c:\' )

IF LenA ( lb_1.is_Path ) > 3 THEN lb_1.is_Path += '\'
IF LenA ( lb_2.is_Path ) > 3 THEN lb_2.is_Path += '\'

lb_1.PostEvent ( 'ue_open' )
lb_2.PostEvent ( 'ue_open' )
end event

event close;lb_1.DirList (  monsys.root + '\*.ini', 0 )
end event

on closequery;/* This is to check if the item has been changed in the window */

Int iRtnCode

If Sign(Long(sle_days.Text)) = -1 Then 

  MessageBox ( "Data Error", "Days cannot be negative!", StopSign! )
  bitemchanged = True
  sle_days.Text =  "" 
  Message.Returnvalue = 1
  Return

End If

sle_days.TriggerEvent ( LoseFocus! )  /* to check if sle has been edited*/

If bitemchanged = True Then

	iRtnCode = messagebox( 'Warning', 'Do you want to save the changes?', &
						Exclamation!, YesNoCancel! , 3 )

	CHOOSE Case iRtnCode 

     Case 1

			This.TriggerEvent( 'updt' )

          If bitemchanged = True AND iRtnCode = 1 Then
				  Message.Returnvalue = 1   
	       End If

	  Case 2 

        close ( this )
  
     Case 3

		  Message.Returnvalue = 1       

     End Choose

Else

      close ( this )
     
End If
	




end on

on resize;lb_1.PostEvent ( 'ue_resize' )
lb_2.PostEvent ( 'ue_resize' )
end on

on activate;String cShow_name

SELECT parameters.show_program_name  
INTO :cShow_name  
FROM parameters  ;

If cShow_name	= 'Y' then
	this.title	= this.title + "[w_edi_asn_parameter_setups]"
End If

gnv_App.of_GetFrame().ChangeMenu(m_edi_asn_parameter_setups)
end on

on w_edi_asn_parameter_setups.create
this.st_edi_directory=create st_edi_directory
this.st_asn_directory=create st_asn_directory
this.lb_2=create lb_2
this.lb_1=create lb_1
this.st_4=create st_4
this.sle_days=create sle_days
this.st_3=create st_3
this.st_2=create st_2
this.ddlb_auto=create ddlb_auto
this.st_1=create st_1
this.Control[]={ this.st_edi_directory,&
this.st_asn_directory,&
this.lb_2,&
this.lb_1,&
this.st_4,&
this.sle_days,&
this.st_3,&
this.st_2,&
this.ddlb_auto,&
this.st_1}
end on

on w_edi_asn_parameter_setups.destroy
destroy(this.st_edi_directory)
destroy(this.st_asn_directory)
destroy(this.lb_2)
destroy(this.lb_1)
destroy(this.st_4)
destroy(this.sle_days)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.ddlb_auto)
destroy(this.st_1)
end on

type st_edi_directory from statictext within w_edi_asn_parameter_setups
int X=1569
int Y=509
int Width=1143
int Height=73
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_asn_directory from statictext within w_edi_asn_parameter_setups
int X=101
int Y=509
int Width=1143
int Height=73
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type lb_2 from ulb_smart_directory within w_edi_asn_parameter_setups
int X=1569
int Y=629
int Width=1143
int Height=1145
int TabOrder=30
end type

on doubleclicked;call ulb_smart_directory::doubleclicked;bitemchanged = True
end on

on ue_resize;call ulb_smart_directory::ue_resize;Height = Parent.Height - 792
end on

on constructor;call ulb_smart_directory::constructor;ib_Subdirectory = TRUE
ib_Drive = TRUE
ib_ExcludeReadWrite = TRUE

ib_StaticText = TRUE
ist_Path = st_edi_directory
end on

type lb_1 from ulb_smart_directory within w_edi_asn_parameter_setups
int X=101
int Y=629
int Width=1143
int Height=1145
int TabOrder=20
end type

on doubleclicked;call ulb_smart_directory::doubleclicked;bitemchanged = True
end on

on ue_resize;call ulb_smart_directory::ue_resize;Height = Parent.Height - 792
end on

on constructor;call ulb_smart_directory::constructor;ib_Subdirectory = TRUE
ib_Drive = TRUE
ib_ExcludeReadWrite = TRUE

ib_StaticText = TRUE
ist_Path = st_asn_directory
end on

type st_4 from statictext within w_edi_asn_parameter_setups
int X=1569
int Y=413
int Width=1143
int Height=73
boolean Enabled=false
string Text="Directory to read EDI flat file"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_days from editmask within w_edi_asn_parameter_setups
int X=1962
int Y=177
int Width=247
int Height=93
int TabOrder=40
BorderStyle BorderStyle=StyleLowered!
string Mask="###,###"
long BackColor=16777215
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;bitemchanged = True
end on

type st_3 from statictext within w_edi_asn_parameter_setups
int X=1441
int Y=89
int Width=1308
int Height=73
boolean Enabled=false
string Text="Days to process EDI raw data"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_edi_asn_parameter_setups
int X=101
int Y=413
int Width=1143
int Height=73
boolean Enabled=false
string Text="Directory to save ASN flat file"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ddlb_auto from dropdownlistbox within w_edi_asn_parameter_setups
int X=499
int Y=177
int Width=366
int Height=257
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Yes",&
"No"}
end type

on selectionchanged;bitemchanged = True
end on

type st_1 from statictext within w_edi_asn_parameter_setups
int X=42
int Y=85
int Width=1308
int Height=73
boolean Enabled=false
string Text="Send ASN automatically after scanning to truck"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

