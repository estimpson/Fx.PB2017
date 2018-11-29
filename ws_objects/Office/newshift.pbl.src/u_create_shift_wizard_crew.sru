$PBExportHeader$u_create_shift_wizard_crew.sru
forward
global type u_create_shift_wizard_crew from u_wizard_ancestor
end type
type em_1 from editmask within u_create_shift_wizard_crew
end type
type lb_1 from listbox within u_create_shift_wizard_crew
end type
type st_2 from statictext within u_create_shift_wizard_crew
end type
type st_1 from statictext within u_create_shift_wizard_crew
end type
type st_4 from statictext within u_create_shift_wizard_crew
end type
type p_8 from picture within u_create_shift_wizard_crew
end type
type p_2 from picture within u_create_shift_wizard_crew
end type
type p_3 from picture within u_create_shift_wizard_crew
end type
type p_4 from picture within u_create_shift_wizard_crew
end type
type p_5 from picture within u_create_shift_wizard_crew
end type
type p_6 from picture within u_create_shift_wizard_crew
end type
type p_7 from picture within u_create_shift_wizard_crew
end type
type st_3 from statictext within u_create_shift_wizard_crew
end type
end forward

global type u_create_shift_wizard_crew from u_wizard_ancestor
em_1 em_1
lb_1 lb_1
st_2 st_2
st_1 st_1
st_4 st_4
p_8 p_8
p_2 p_2
p_3 p_3
p_4 p_4
p_5 p_5
p_6 p_6
p_7 p_7
st_3 st_3
end type
global u_create_shift_wizard_crew u_create_shift_wizard_crew

type variables
BOOLEAN	ib_Painted = FALSE
end variables

forward prototypes
private function integer uof_paint_data ()
end prototypes

private function integer uof_paint_data ();STRING	ls_LaborCode

IF NOT ib_Painted THEN
	 DECLARE get_labor_codes CURSOR FOR  
	  SELECT id
	    FROM labor
	ORDER BY id
	   USING SQLCA  ;

	    OPEN get_labor_codes  ;

	   FETCH get_labor_codes
	    INTO :ls_LaborCode  ;

	DO WHILE SQLCA.SQLCode = 0
		lb_1.AddItem ( ls_LaborCode )

		   FETCH get_labor_codes
		    INTO :ls_LaborCode  ;

	LOOP

	  CLOSE get_labor_codes  ;

	lb_1.AddItem ( '<none>' )
	lb_1.SelectItem ( '<none>', 0 )
	ib_Painted = TRUE
END IF
IF lb_1.SelectedIndex ( ) <> -1 THEN
	w_create_new_shift_wizard.wf_enable_next ( TRUE )
END IF
Return 0
end function

on ue_paint;call u_wizard_ancestor::ue_paint;uof_paint_data ( )
end on

on u_create_shift_wizard_crew.create
int iCurrent
call super::create
this.em_1=create em_1
this.lb_1=create lb_1
this.st_2=create st_2
this.st_1=create st_1
this.st_4=create st_4
this.p_8=create p_8
this.p_2=create p_2
this.p_3=create p_3
this.p_4=create p_4
this.p_5=create p_5
this.p_6=create p_6
this.p_7=create p_7
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.lb_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_4
this.Control[iCurrent+6]=this.p_8
this.Control[iCurrent+7]=this.p_2
this.Control[iCurrent+8]=this.p_3
this.Control[iCurrent+9]=this.p_4
this.Control[iCurrent+10]=this.p_5
this.Control[iCurrent+11]=this.p_6
this.Control[iCurrent+12]=this.p_7
this.Control[iCurrent+13]=this.st_3
end on

on u_create_shift_wizard_crew.destroy
call super::destroy
destroy(this.em_1)
destroy(this.lb_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_4)
destroy(this.p_8)
destroy(this.p_2)
destroy(this.p_3)
destroy(this.p_4)
destroy(this.p_5)
destroy(this.p_6)
destroy(this.p_7)
destroy(this.st_3)
end on

type em_1 from editmask within u_create_shift_wizard_crew
int X=818
int Y=484
int Width=297
int Height=88
int TabOrder=10
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="##,###"
boolean Spin=true
double Increment=1
string MinMax="1~~"
string Text="1"
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type lb_1 from listbox within u_create_shift_wizard_crew
int X=1166
int Y=484
int Width=507
int Height=368
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on selectionchanged;w_create_new_shift_wizard.wf_enable_next ( TRUE )
end on

type st_2 from statictext within u_create_shift_wizard_crew
int X=78
int Y=120
int Width=101
int Height=56
boolean Visible=false
boolean Enabled=false
string Text="+"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within u_create_shift_wizard_crew
int X=334
int Y=56
int Width=1335
int Height=296
boolean Enabled=false
string Text="none"
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

on constructor;Text = 'Select the size and type of the crew.'
end on

type st_4 from statictext within u_create_shift_wizard_crew
int X=1161
int Y=388
int Width=494
int Height=72
boolean Enabled=false
string Text="Labor Code"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type p_8 from picture within u_create_shift_wizard_crew
int X=82
int Y=196
int Width=91
int Height=76
boolean Visible=false
boolean Enabled=false
string PictureName="vendor.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type p_2 from picture within u_create_shift_wizard_crew
int X=82
int Y=676
int Width=91
int Height=76
boolean Visible=false
boolean Enabled=false
string PictureName="vendor.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type p_3 from picture within u_create_shift_wizard_crew
int X=82
int Y=596
int Width=91
int Height=76
boolean Visible=false
boolean Enabled=false
string PictureName="vendor.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type p_4 from picture within u_create_shift_wizard_crew
int X=82
int Y=516
int Width=91
int Height=76
boolean Visible=false
boolean Enabled=false
string PictureName="vendor.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type p_5 from picture within u_create_shift_wizard_crew
int X=82
int Y=436
int Width=91
int Height=76
boolean Visible=false
boolean Enabled=false
string PictureName="vendor.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type p_6 from picture within u_create_shift_wizard_crew
int X=82
int Y=356
int Width=91
int Height=76
boolean Visible=false
boolean Enabled=false
string PictureName="vendor.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type p_7 from picture within u_create_shift_wizard_crew
int X=82
int Y=276
int Width=91
int Height=76
boolean Visible=false
boolean Enabled=false
string PictureName="vendor.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type st_3 from statictext within u_create_shift_wizard_crew
int X=814
int Y=388
int Width=283
int Height=72
boolean Enabled=false
string Text="Crew Size"
boolean FocusRectangle=false
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

