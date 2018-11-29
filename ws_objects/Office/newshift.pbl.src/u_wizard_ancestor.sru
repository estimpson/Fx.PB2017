$PBExportHeader$u_wizard_ancestor.sru
forward
global type u_wizard_ancestor from UserObject
end type
end forward

global type u_wizard_ancestor from UserObject
int Width=1989
int Height=932
long BackColor=77897888
long PictureMaskColor=25166016
long TabBackColor=77897888
event ue_paint pbm_ncpaint
event ue_keydown pbm_custom01
event ue_keyup pbm_custom02
end type
global u_wizard_ancestor u_wizard_ancestor

type variables
Protected:
BOOLEAN	ib_Painted
end variables

forward prototypes
public function integer uof_paint_data ()
end prototypes

on ue_paint;uof_paint_data ( )
end on

public function integer uof_paint_data ();Return 0
end function

on constructor;Visible = FALSE
end on

on u_wizard_ancestor.create
end on

on u_wizard_ancestor.destroy
end on

