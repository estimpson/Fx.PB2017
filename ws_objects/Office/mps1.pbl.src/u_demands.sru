$PBExportHeader$u_demands.sru
$PBExportComments$(mps1) Changed the Clicked! Event.
forward
global type u_demands from UserObject
end type
type st_hours_completed from statictext within u_demands
end type
type p_note from picture within u_demands
end type
type st_part from statictext within u_demands
end type
end forward

global type u_demands from UserObject
int Width=238
int Height=65
long BackColor=12632256
event ue_initialize pbm_custom01
st_hours_completed st_hours_completed
p_note p_note
st_part st_part
end type
global u_demands u_demands

type variables
Window 	i_w_ParentWindow

Long	i_i_Ptr

Decimal	id_RunTime, &
	ic_QtyCompleted, &
	ic_QtyRequired

Date	idt_StartDate, &	
	idt_DueDate

Time	it_StartTime, &
	it_DueTime

String	is_Machine, &
	is_Part, &
	is_Note, &
	is_WorkOrder


end variables

forward prototypes
public subroutine uf_get_parent (ref window l_w_ParentWindow)
public subroutine uf_initialize ()
public subroutine uf_set_hours_completed ()
end prototypes

on ue_initialize;this.uf_initialize()
end on

public subroutine uf_get_parent (ref window l_w_ParentWindow);i_w_ParentWindow	= l_w_ParentWindow
end subroutine

public subroutine uf_initialize ();st_hours_completed.visible	= FALSE
end subroutine

public subroutine uf_set_hours_completed ();st_hours_completed.visible		= (ic_QtyCompleted > 0 )
st_hours_completed.bringtotop	= st_hours_completed.visible

if ic_QtyCompleted > 0 and ic_QtyRequired > 0  then
	st_hours_completed.width	= 	ic_QtyCompleted * st_part.width/ &
											ic_QtyRequired 		
	if st_hours_completed.width > st_part.width then
		st_hours_completed.width	= st_part.width
	end if

	st_hours_completed.x			= 	st_part.x + st_part.width  - &
											st_hours_completed.width
end if
end subroutine

on u_demands.create
this.st_hours_completed=create st_hours_completed
this.p_note=create p_note
this.st_part=create st_part
this.Control[]={ this.st_hours_completed,&
this.p_note,&
this.st_part}
end on

on u_demands.destroy
destroy(this.st_hours_completed)
destroy(this.p_note)
destroy(this.st_part)
end on

on constructor;this.triggerevent( 'ue_initialize' )
end on

type st_hours_completed from statictext within u_demands
int X=147
int Y=5
int Width=87
int Height=57
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=32768
int TextSize=-7
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type p_note from picture within u_demands
int X=10
int Y=9
int Width=46
int Height=49
boolean Enabled=false
string PictureName="mpsnont.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type st_part from statictext within u_demands
int Width=238
int Height=65
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=16776960
int TextSize=-7
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on doubleclicked;szReturnedString	= String(i_i_Ptr)

i_w_ParentWindow.TriggerEvent("ue_double_clicked_mps", 0, i_i_ptr)
end on

on rbuttondown;szReturnedString	= String(i_i_Ptr)

i_w_ParentWindow.PostEvent("ue_dragdrop_mps", 0, i_i_ptr)
end on

on clicked;szReturnedString	= String(i_i_Ptr)

i_w_ParentWindow.TriggerEvent("ue_clicked_mps", 0, i_i_Ptr)

end on

