$PBExportHeader$u_upgrade_forms_labels_finish.sru
forward
global type u_upgrade_forms_labels_finish from u_wizard_ancestor
end type
type st_1 from statictext within u_upgrade_forms_labels_finish
end type
type cb_setup from commandbutton within u_upgrade_forms_labels_finish
end type
type p_3 from picture within u_upgrade_forms_labels_finish
end type
end forward

global type u_upgrade_forms_labels_finish from u_wizard_ancestor
int Width=1947
st_1 st_1
cb_setup cb_setup
p_3 p_3
end type
global u_upgrade_forms_labels_finish u_upgrade_forms_labels_finish

forward prototypes
public function integer uof_paint_data ()
end prototypes

public function integer uof_paint_data ();w_upgrade_forms_labels.wf_enable_next ( TRUE )
Return 1
end function

on u_upgrade_forms_labels_finish.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_setup=create cb_setup
this.p_3=create p_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_setup
this.Control[iCurrent+3]=this.p_3
end on

on u_upgrade_forms_labels_finish.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cb_setup)
destroy(this.p_3)
end on

type st_1 from statictext within u_upgrade_forms_labels_finish
int X=315
int Y=48
int Width=1595
int Height=712
boolean Enabled=false
boolean BringToTop=true
string Text="none"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event constructor;Text = "The final step in the upgrade is to submit a request for the compiled and uncompiled versions of the forms and labels you have selected as your own.  When you select 'Finish' below, a form will print that you should fax to Monitor.  You will be sent a '.pbl' file and a '.pbd' file with your forms and labels."
end event

type cb_setup from commandbutton within u_upgrade_forms_labels_finish
int X=1467
int Y=788
int Width=443
int Height=108
int TabOrder=1
boolean BringToTop=true
string Text="Printer &Setup"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;PrintSetup ( )
end event

type p_3 from picture within u_upgrade_forms_labels_finish
int X=9
int Y=8
int Width=274
int Height=900
boolean BringToTop=true
string PictureName="printers.bmp"
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
end type

