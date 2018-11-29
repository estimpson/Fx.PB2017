$PBExportHeader$u_upgrade_forms_labels_start.sru
forward
global type u_upgrade_forms_labels_start from u_wizard_ancestor
end type
type st_1 from statictext within u_upgrade_forms_labels_start
end type
type p_3 from picture within u_upgrade_forms_labels_start
end type
end forward

global type u_upgrade_forms_labels_start from u_wizard_ancestor
st_1 st_1
p_3 p_3
end type
global u_upgrade_forms_labels_start u_upgrade_forms_labels_start

forward prototypes
public function integer uof_paint_data ()
end prototypes

public function integer uof_paint_data ();w_upgrade_forms_labels.wf_enable_next ( TRUE )
Return 1
end function

on u_upgrade_forms_labels_start.create
int iCurrent
call super::create
this.st_1=create st_1
this.p_3=create p_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.p_3
end on

on u_upgrade_forms_labels_start.destroy
call super::destroy
destroy(this.st_1)
destroy(this.p_3)
end on

type st_1 from statictext within u_upgrade_forms_labels_start
int X=315
int Y=48
int Width=1545
int Height=340
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

event constructor;Text = "Version 3.4 of The Monitor Factory Management System has a new system for handling labels and forms.  The following wizard will quickly help you get ready to use the new features of the Extended Forms And Labels Architecure."
end event

type p_3 from picture within u_upgrade_forms_labels_start
int X=9
int Y=8
int Width=293
int Height=908
boolean BringToTop=true
string PictureName="printers.bmp"
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
end type

