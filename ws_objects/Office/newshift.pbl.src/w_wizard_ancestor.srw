$PBExportHeader$w_wizard_ancestor.srw
forward
global type w_wizard_ancestor from Window
end type
type cb_3 from commandbutton within w_wizard_ancestor
end type
type cb_2 from commandbutton within w_wizard_ancestor
end type
type cb_1 from commandbutton within w_wizard_ancestor
end type
type ln_2 from line within w_wizard_ancestor
end type
type ln_1 from line within w_wizard_ancestor
end type
end forward

global type w_wizard_ancestor from Window
int X=832
int Y=356
int Width=2016
int Height=1300
boolean TitleBar=true
string Title="Create Shift Wizard"
long BackColor=78682240
WindowType WindowType=response!
event ue_paint pbm_custom01
event ue_finish pbm_custom02
event keyup pbm_keyup
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
ln_2 ln_2
ln_1 ln_1
end type
global w_wizard_ancestor w_wizard_ancestor

type variables
u_wizard_ancestor	uo_page []

INTEGER	ii_PageNumber	= 1, &
	ii_NumberOfPages	= 0
end variables

forward prototypes
private function integer wf_paint_page ()
public function integer wf_enable_next (boolean pb_Value)
end prototypes

on ue_paint;wf_paint_page ( )
cb_2.Default = TRUE
cb_3.Cancel = TRUE
end on

on keyup;uo_Page[ ii_PageNumber ].TriggerEvent ( 'ue_keyup' )
end on

private function integer wf_paint_page ();cb_2.Enabled = FALSE

IF ii_NumberOfPages > 0 THEN
	IF ii_NumberOfPages = 1 THEN
		cb_1.Visible = FALSE
		cb_2.Text = 'Finish'
	END IF
	uo_Page [ ii_PageNumber ].Visible = TRUE
END IF

Return 0
end function

public function integer wf_enable_next (boolean pb_Value);cb_2.Enabled = pb_Value
Return 0
end function

on close;INTEGER	li_Count

FOR li_Count = 1 TO UpperBound ( uo_Page )
	IF IsValid ( uo_Page [ li_Count ] ) THEN
		CloseUserObject ( uo_Page [ li_Count ] )
	END IF
NEXT
Close ( This )
end on

event open;ln_1.LineColor = syscolor.ButtonShadow
ln_2.LineColor = syscolor.ButtonHilight

PostEvent ( 'ue_paint' )
end event

on w_wizard_ancestor.create
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.ln_2=create ln_2
this.ln_1=create ln_1
this.Control[]={this.cb_3,&
this.cb_2,&
this.cb_1,&
this.ln_2,&
this.ln_1}
end on

on w_wizard_ancestor.destroy
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.ln_2)
destroy(this.ln_1)
end on

on key;uo_Page[ ii_PageNumber ].TriggerEvent ( 'ue_keydown' )
end on

type cb_3 from commandbutton within w_wizard_ancestor
int X=1595
int Y=1064
int Width=347
int Height=92
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

on clicked;Parent.TriggerEvent ( 'close' )
end on

type cb_2 from commandbutton within w_wizard_ancestor
int X=1198
int Y=1064
int Width=347
int Height=92
int TabOrder=20
boolean Enabled=false
string Text="Next >"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;cb_1.Enabled = TRUE
uo_Page [ ii_PageNumber ].Visible = FALSE
ii_PageNumber ++
CHOOSE CASE ii_PageNumber
CASE IS < ii_NumberOfPages
	Parent.PostEvent ( 'ue_paint' )
CASE ii_NumberOfPages
	Text = 'Finish'
	Parent.PostEvent ( 'ue_paint' )
CASE IS > ii_NumberOfPages
	Parent.PostEvent ( 'ue_finish' )
END CHOOSE
end on

type cb_1 from commandbutton within w_wizard_ancestor
int X=850
int Y=1064
int Width=347
int Height=92
int TabOrder=10
boolean Enabled=false
string Text="< &Back"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;uo_Page [ ii_PageNumber ].Visible = FALSE
ii_PageNumber --
Parent.PostEvent ( 'ue_paint' )
CHOOSE CASE ii_PageNumber
CASE 1
	Enabled = FALSE
CASE ii_NumberOfPages - 1
	cb_2.Text = 'Next >'
END CHOOSE
end on

type ln_2 from line within w_wizard_ancestor
boolean Enabled=false
int BeginX=50
int BeginY=1012
int EndX=1938
int EndY=1012
int LineThickness=4
long LineColor=16777215
end type

type ln_1 from line within w_wizard_ancestor
boolean Enabled=false
int BeginX=50
int BeginY=1008
int EndX=1938
int EndY=1008
int LineThickness=4
long LineColor=8421504
end type

