$PBExportHeader$u_explorer_ancestor.sru
forward
global type u_explorer_ancestor from UserObject
end type
type st_1 from statictext within u_explorer_ancestor
end type
type tv_1 from u_treeview_ancestor within u_explorer_ancestor
end type
type dw_1 from u_datawindow_ancestor within u_explorer_ancestor
end type
end forward

global type u_explorer_ancestor from UserObject
int Width=1989
int Height=1136
long BackColor=78682240
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=16777215
event resize pbm_size
event ue_setup ( )
event ue_pre_setup ( )
st_1 st_1
tv_1 tv_1
dw_1 dw_1
end type
global u_explorer_ancestor u_explorer_ancestor

type variables
boolean		i_b_moveinprogress=False
long		i_l_hiddencolor=0,&
		i_l_clicked_tv_item,&
		i_l_right_clicked_tv_item
integer		i_i_barthickness=18,&
		i_i_windowborder=25
datastore		i_ds_treeview
end variables

forward prototypes
public function integer of_resizepanels ()
public function integer of_resize ()
end prototypes

event resize;of_resize ( )
end event

public function integer of_resizepanels ();// Left vertical object processing
tv_1.Resize ( st_1.X - tv_1.X, tv_1.Height )

// Middle splitter object processing
st_1.Resize ( st_1.width, tv_1.Height )

// Right vertical object processing
dw_1.Move ( st_1.X + st_1.Width, i_i_WindowBorder)
dw_1.Resize ( width - dw_1.X - i_i_WindowBorder - 5, dw_1.Height )

Return 1

end function

public function integer of_resize ();// Left vertical object processing
tv_1.Move ( i_i_WindowBorder, i_i_WindowBorder )
tv_1.Resize ( st_1.X - tv_1.X, height - tv_1.Y - i_i_WindowBorder )

// Right vertical object processing
dw_1.Move ( st_1.X + st_1.width, i_i_WindowBorder )
dw_1.Resize ( width - dw_1.X - i_i_WindowBorder - 5, height - dw_1.Y - i_i_WindowBorder )

return 1
end function

event constructor;i_ds_treeview = CREATE datastore

TriggerEvent ( "ue_pre_setup" )
PostEvent ( "ue_setup" )

end event

on u_explorer_ancestor.create
this.st_1=create st_1
this.tv_1=create tv_1
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.tv_1,&
this.dw_1}
end on

on u_explorer_ancestor.destroy
destroy(this.st_1)
destroy(this.tv_1)
destroy(this.dw_1)
end on

event destructor;DESTROY i_ds_treeview
end event

type st_1 from statictext within u_explorer_ancestor
event mousemove pbm_mousemove
event mouseup pbm_lbuttonup
event mousedown pbm_lbuttondown
int X=585
int Y=16
int Width=37
int Height=1024
boolean FocusRectangle=false
long BackColor=78682240
string Pointer="SPLIT.cur"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event mousemove;//Check for move in progess
if i_b_moveinprogress then
	//process only if moved
	if parent.pointerx() > tv_1.x and &
		parent.pointerx() < dw_1.x + dw_1.width and &
		this.x <> parent.pointerx() then
		this.x = parent.pointerx()
		//Resize the panels
		of_resizepanels()
	end if
end if
end event

event mouseup;//Hide the bar
//this.BackColor = i_l_hiddencolor

//Resize the panels
of_resizepanels()

//Moving is no longer in progess.
i_b_moveinprogress = false
end event

event mousedown;//Initiate Move process
i_b_moveinprogress = true

end event

type tv_1 from u_treeview_ancestor within u_explorer_ancestor
int X=18
int Y=16
int Width=567
int Height=1024
int TabOrder=20
end type

type dw_1 from u_datawindow_ancestor within u_explorer_ancestor
int X=622
int Y=16
int Width=1317
int Height=1024
int TabOrder=10
string DragIcon="Application!"
end type

event clicked;call super::clicked;dw_1.SelectRow ( 0, FALSE )
if row > 0 then &
	dw_1.SelectRow ( row, TRUE )
	
return 0
end event

