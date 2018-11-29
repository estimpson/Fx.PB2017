$PBExportHeader$w_user_definable_labels.srw
forward
global type w_user_definable_labels from Window
end type
type dw_labels from datawindow within w_user_definable_labels
end type
type dw_parameters from datawindow within w_user_definable_labels
end type
type cbx_validate_lot from checkbox within w_user_definable_labels
end type
type st_9 from statictext within w_user_definable_labels
end type
type st_8 from statictext within w_user_definable_labels
end type
type cbx_validate5 from checkbox within w_user_definable_labels
end type
type cbx_validate4 from checkbox within w_user_definable_labels
end type
type cbx_validate3 from checkbox within w_user_definable_labels
end type
type cbx_validate2 from checkbox within w_user_definable_labels
end type
type cbx_validate1 from checkbox within w_user_definable_labels
end type
type mle_1 from multilineedit within w_user_definable_labels
end type
type cbx_user5 from checkbox within w_user_definable_labels
end type
type cbx_user4 from checkbox within w_user_definable_labels
end type
type cbx_user3 from checkbox within w_user_definable_labels
end type
type cbx_user2 from checkbox within w_user_definable_labels
end type
type st_7 from statictext within w_user_definable_labels
end type
type cbx_user1 from checkbox within w_user_definable_labels
end type
type st_6 from statictext within w_user_definable_labels
end type
type st_5 from statictext within w_user_definable_labels
end type
type st_4 from statictext within w_user_definable_labels
end type
type st_3 from statictext within w_user_definable_labels
end type
type st_2 from statictext within w_user_definable_labels
end type
type st_1 from statictext within w_user_definable_labels
end type
type sle_user5 from singlelineedit within w_user_definable_labels
end type
type sle_user4 from singlelineedit within w_user_definable_labels
end type
type sle_user3 from singlelineedit within w_user_definable_labels
end type
type sle_user2 from singlelineedit within w_user_definable_labels
end type
type sle_user1 from singlelineedit within w_user_definable_labels
end type
end forward

global type w_user_definable_labels from Window
int X=0
int Y=0
int Width=2949
int Height=1936
boolean TitleBar=true
string Title="Customer Definable Fields"
long BackColor=77897888
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event save pbm_custom01
dw_labels dw_labels
dw_parameters dw_parameters
cbx_validate_lot cbx_validate_lot
st_9 st_9
st_8 st_8
cbx_validate5 cbx_validate5
cbx_validate4 cbx_validate4
cbx_validate3 cbx_validate3
cbx_validate2 cbx_validate2
cbx_validate1 cbx_validate1
mle_1 mle_1
cbx_user5 cbx_user5
cbx_user4 cbx_user4
cbx_user3 cbx_user3
cbx_user2 cbx_user2
st_7 st_7
cbx_user1 cbx_user1
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
sle_user5 sle_user5
sle_user4 sle_user4
sle_user3 sle_user3
sle_user2 sle_user2
sle_user1 sle_user1
end type
global w_user_definable_labels w_user_definable_labels

type variables
SingleLineEdit 	sLabel[]
CheckBox       	cbCalc[]
CheckBox	cbValidate[]
end variables

forward prototypes
public subroutine wf_initialize_lables ()
public subroutine wf_save_labels ()
end prototypes

on save;wf_save_labels()
end on

public subroutine wf_initialize_lables ();Integer iRow

String  szCalculated

sLabel[1]	= sle_user1
sLabel[2]	= sle_user2
sLabel[3]	= sle_user3
sLabel[4]	= sle_user4
sLabel[5]	= sle_user5

cbCalc[1]	= cbx_user1
cbCalc[2]	= cbx_user2
cbCalc[3]	= cbx_user3
cbCalc[4]	= cbx_user4
cbCalc[5]	= cbx_user5

cbValidate[1] = cbx_validate1
cbValidate[2] = cbx_validate2
cbValidate[3] = cbx_validate3
cbValidate[4] = cbx_validate4
cbValidate[5] = cbx_validate5
cbValidate[6] = cbx_validate_lot

dw_labels.Retrieve("RD")

For iRow = 1 to dw_labels.RowCount()
	sLabel[iRow].text	= dw_labels.GetItemString(iRow, "label")
	szCalculated		= dw_labels.GetItemString(iRow, "calculated_field")
	If szCalculated = "Y" then
		cbCalc[iRow].checked	= TRUE
	End If

	If iRow = 5 then
		iRow	= dw_labels.RowCount() + 1
	End If
Next

dw_parameters.SetTransObject ( sqlca )
dw_parameters.Retrieve ( )

If f_get_string_value ( dw_parameters.GetItemString ( 1, "custom1" ) ) = 'Y' Then
	cbValidate[1].Checked = True
Else
	cbValidate[1].Checked = False
End if
If f_get_string_value ( dw_parameters.GetItemString ( 1, "custom2" ) ) = 'Y' Then
	cbValidate[2].Checked = True
Else
	cbValidate[2].Checked = False
End if
If f_get_string_value ( dw_parameters.GetItemString ( 1, "custom3" ) ) = 'Y' Then
	cbValidate[3].Checked = True
Else
	cbValidate[3].Checked = False
End if
If f_get_string_value ( dw_parameters.GetItemString ( 1, "custom4" ) ) = 'Y' Then
	cbValidate[4].Checked = True
Else
	cbValidate[4].Checked = False
End if
If f_get_string_value ( dw_parameters.GetItemString ( 1, "custom5" ) ) = 'Y' Then
	cbValidate[5].Checked = True
Else
	cbValidate[5].Checked = False
End if
If f_get_string_value ( dw_parameters.GetItemString ( 1, "lot" ) ) = 'Y' Then
	cbValidate[6].Checked = True
Else
	cbValidate[6].Checked = False
End if

end subroutine

public subroutine wf_save_labels ();Integer	iCount, irow


DELETE FROM user_definable_module_labels  
WHERE module = 'RD'   ;

If SQLCA.SQLCode = 0 then
	Commit;
Else
	Rollback;
End If

dw_labels.Reset()

For iCount	= 1 to 5
	If sLabel[iCount].text > " " then
		irow = dw_labels.InsertRow(0)
		dw_labels.SetItem(irow, "module", 	'RD')
		dw_labels.SetItem(irow, "sequence", iCount)
		dw_labels.SetItem(irow, "label", sLabel[iCount].text)
		If cbCalc[iCount].checked then
			dw_labels.SetItem(irow, "calculated_field", "Y")
		Else
			dw_labels.SetItem(irow, "calculated_field", "N")
		End If
	End If
Next

If dw_labels.Update() > 0 then
	Commit;
Else
	Rollback;
End If		

If cbValidate[1].Checked Then
	dw_parameters.SetItem ( 1, "custom1", 'Y' )
Else
	dw_parameters.SetItem ( 1, "custom1", 'N' )
End if
If cbValidate[2].Checked Then
	dw_parameters.SetItem ( 1, "custom2", 'Y' )
Else
	dw_parameters.SetItem ( 1, "custom2", 'N' )
End if
If cbValidate[3].Checked Then
	dw_parameters.SetItem ( 1, "custom3", 'Y' )
Else
	dw_parameters.SetItem ( 1, "custom3", 'N' )
End if
If cbValidate[4].Checked Then
	dw_parameters.SetItem ( 1, "custom4", 'Y' )
Else
	dw_parameters.SetItem ( 1, "custom4", 'N' )
End if
If cbValidate[5].Checked Then
	dw_parameters.SetItem ( 1, "custom5", 'Y' )
Else
	dw_parameters.SetItem ( 1, "custom5", 'N' )
End if
If cbValidate[6].Checked Then
	dw_parameters.SetItem ( 1, "lot", 'Y' )
Else
	dw_parameters.SetItem ( 1, "lot", 'N' )
End if

If dw_parameters.Update ( ) = -1 Then
	RollBack ;
Else
	Commit ;
End if
end subroutine

on open;dw_labels.SetTransObject(sqlca)

dw_labels.Retrieve('RD')

wf_initialize_lables()
end on

on activate;gnv_App.of_GetFrame().ChangeMenu ( m_customer_definable_labels )

end on

on w_user_definable_labels.create
this.dw_labels=create dw_labels
this.dw_parameters=create dw_parameters
this.cbx_validate_lot=create cbx_validate_lot
this.st_9=create st_9
this.st_8=create st_8
this.cbx_validate5=create cbx_validate5
this.cbx_validate4=create cbx_validate4
this.cbx_validate3=create cbx_validate3
this.cbx_validate2=create cbx_validate2
this.cbx_validate1=create cbx_validate1
this.mle_1=create mle_1
this.cbx_user5=create cbx_user5
this.cbx_user4=create cbx_user4
this.cbx_user3=create cbx_user3
this.cbx_user2=create cbx_user2
this.st_7=create st_7
this.cbx_user1=create cbx_user1
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.sle_user5=create sle_user5
this.sle_user4=create sle_user4
this.sle_user3=create sle_user3
this.sle_user2=create sle_user2
this.sle_user1=create sle_user1
this.Control[]={this.dw_labels,&
this.dw_parameters,&
this.cbx_validate_lot,&
this.st_9,&
this.st_8,&
this.cbx_validate5,&
this.cbx_validate4,&
this.cbx_validate3,&
this.cbx_validate2,&
this.cbx_validate1,&
this.mle_1,&
this.cbx_user5,&
this.cbx_user4,&
this.cbx_user3,&
this.cbx_user2,&
this.st_7,&
this.cbx_user1,&
this.st_6,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.sle_user5,&
this.sle_user4,&
this.sle_user3,&
this.sle_user2,&
this.sle_user1}
end on

on w_user_definable_labels.destroy
destroy(this.dw_labels)
destroy(this.dw_parameters)
destroy(this.cbx_validate_lot)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.cbx_validate5)
destroy(this.cbx_validate4)
destroy(this.cbx_validate3)
destroy(this.cbx_validate2)
destroy(this.cbx_validate1)
destroy(this.mle_1)
destroy(this.cbx_user5)
destroy(this.cbx_user4)
destroy(this.cbx_user3)
destroy(this.cbx_user2)
destroy(this.st_7)
destroy(this.cbx_user1)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_user5)
destroy(this.sle_user4)
destroy(this.sle_user3)
destroy(this.sle_user2)
destroy(this.sle_user1)
end on

type dw_labels from datawindow within w_user_definable_labels
int X=421
int Y=1424
int Width=549
int Height=352
int TabOrder=80
boolean Visible=false
string DataObject="dw_smart_user_definable_labels"
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_parameters from datawindow within w_user_definable_labels
int X=1006
int Y=1424
int Width=494
int Height=360
int TabOrder=60
boolean Visible=false
string DataObject="d_parameter_validate_setup"
boolean LiveScroll=true
end type

type cbx_validate_lot from checkbox within w_user_definable_labels
int X=2121
int Y=672
int Width=73
int Height=64
string Text="none"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_9 from statictext within w_user_definable_labels
int X=1573
int Y=672
int Width=517
int Height=64
boolean Enabled=false
string Text="Lot Number Field"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_8 from statictext within w_user_definable_labels
int X=1829
int Y=96
int Width=731
int Height=64
boolean Enabled=false
string Text="Shop Floor Lot Control?"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_validate5 from checkbox within w_user_definable_labels
int X=2121
int Y=576
int Width=73
int Height=64
string Text="none"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_validate4 from checkbox within w_user_definable_labels
int X=2121
int Y=480
int Width=73
int Height=64
string Text="none"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_validate3 from checkbox within w_user_definable_labels
int X=2121
int Y=384
int Width=73
int Height=64
string Text="none"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_validate2 from checkbox within w_user_definable_labels
int X=2121
int Y=288
int Width=73
int Height=64
string Text="none"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_validate1 from checkbox within w_user_definable_labels
int X=2121
int Y=192
int Width=73
int Height=64
string Text="none"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type mle_1 from multilineedit within w_user_definable_labels
int X=667
int Y=848
int Width=1627
int Height=560
int TabOrder=70
boolean Enabled=false
BorderStyle BorderStyle=StyleLowered!
string Text="This program allows you to define up to 5 fields to be used at the  receiving dock. The 'Calculated Field' option indicates that the field value is calculated based on other field input. The 'Shop Floor Lot Control' Option indicates that successive material issue transactions on raw materials have the same values for the marked fields. "
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_user5 from checkbox within w_user_definable_labels
int X=1463
int Y=576
int Width=73
int Height=64
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_user4 from checkbox within w_user_definable_labels
int X=1463
int Y=480
int Width=73
int Height=64
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_user3 from checkbox within w_user_definable_labels
int X=1463
int Y=384
int Width=73
int Height=64
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_user2 from checkbox within w_user_definable_labels
int X=1463
int Y=288
int Width=73
int Height=64
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_7 from statictext within w_user_definable_labels
int X=1262
int Y=96
int Width=489
int Height=64
boolean Enabled=false
string Text="Calculated Field"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_user1 from checkbox within w_user_definable_labels
int X=1463
int Y=192
int Width=73
int Height=64
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_6 from statictext within w_user_definable_labels
int X=475
int Y=576
int Width=110
int Height=72
boolean Enabled=false
string Text="5"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within w_user_definable_labels
int X=475
int Y=480
int Width=110
int Height=72
boolean Enabled=false
string Text="4"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_user_definable_labels
int X=475
int Y=384
int Width=110
int Height=72
boolean Enabled=false
string Text="3"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_user_definable_labels
int X=475
int Y=288
int Width=110
int Height=72
boolean Enabled=false
string Text="2"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_user_definable_labels
int X=457
int Y=96
int Width=658
int Height=64
boolean Enabled=false
string Text="Field Names"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_user_definable_labels
int X=475
int Y=192
int Width=110
int Height=72
boolean Enabled=false
string Text="1"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_user5 from singlelineedit within w_user_definable_labels
int X=640
int Y=576
int Width=475
int Height=88
int TabOrder=50
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_user4 from singlelineedit within w_user_definable_labels
int X=640
int Y=480
int Width=475
int Height=88
int TabOrder=40
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_user3 from singlelineedit within w_user_definable_labels
int X=640
int Y=384
int Width=475
int Height=88
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_user2 from singlelineedit within w_user_definable_labels
int X=640
int Y=288
int Width=475
int Height=88
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_user1 from singlelineedit within w_user_definable_labels
int X=640
int Y=192
int Width=475
int Height=88
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

