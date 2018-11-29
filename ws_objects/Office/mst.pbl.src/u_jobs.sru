$PBExportHeader$u_jobs.sru
forward
global type u_jobs from UserObject
end type
type p_status from picture within u_jobs
end type
type st_job from statictext within u_jobs
end type
end forward

global type u_jobs from UserObject
int Width=238
int Height=65
long BackColor=12632256
p_status p_status
st_job st_job
end type
global u_jobs u_jobs

type variables
Window 	i_w_ParentWindow

Long	i_i_Ptr, &
	il_OrigPos, &
	il_OrigPosY

String	i_s_Machine, &
	i_s_Job
end variables

forward prototypes
public subroutine uf_get_parent (ref window l_w_ParentWindow)
end prototypes

public subroutine uf_get_parent (ref window l_w_ParentWindow);i_w_ParentWindow	= l_w_ParentWindow
end subroutine

on u_jobs.create
this.p_status=create p_status
this.st_job=create st_job
this.Control[]={ this.p_status,&
this.st_job}
end on

on u_jobs.destroy
destroy(this.p_status)
destroy(this.st_job)
end on

type p_status from picture within u_jobs
int Y=9
int Width=46
int Height=41
boolean Enabled=false
string PictureName="ok.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type st_job from statictext within u_jobs
int Width=238
int Height=65
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="    Job#"
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
szReturnedPart		= i_s_Machine

i_w_ParentWindow.TriggerEvent("ue_double_clicked_job")
end on

on rbuttondown;szReturnedString	= String(i_i_Ptr)
szReturnedPart		= i_s_Machine

i_w_ParentWindow.PostEvent("ue_drag_job")
end on

on clicked;szReturnedString	= String(i_i_Ptr)
szReturnedPart		= i_s_Machine

i_w_ParentWindow.PostEvent("ue_select_job")

end on

