$PBExportHeader$w_job_information.srw
$PBExportComments$(mps1) Added the check to 'close' event
forward
global type w_job_information from Window
end type
type cb_save from commandbutton within w_job_information
end type
type cb_cancel from commandbutton within w_job_information
end type
type cb_ok from commandbutton within w_job_information
end type
type tab_1 from tab within w_job_information
end type
type tabpage_info from u_job_info within tab_1
end type
type tabpage_in from u_job_material_input within tab_1
end type
type tabpage_out from u_job_material_output within tab_1
end type
type tabpage_process from u_job_material_process within tab_1
end type
type tabpage_status from u_job_status within tab_1
end type
type tabpage_yield from u_job_yield within tab_1
end type
type tabpage_mps from u_job_mps within tab_1
end type
type tabpage_cost from u_job_cost within tab_1
end type
type tab_1 from tab within w_job_information
tabpage_info tabpage_info
tabpage_in tabpage_in
tabpage_out tabpage_out
tabpage_process tabpage_process
tabpage_status tabpage_status
tabpage_yield tabpage_yield
tabpage_mps tabpage_mps
tabpage_cost tabpage_cost
end type
end forward

global type w_job_information from Window
int X=681
int Y=4
int Width=3319
int Height=1748
boolean TitleBar=true
string Title="Job Information"
long BackColor=77897888
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
event ue_exit ( )
cb_save cb_save
cb_cancel cb_cancel
cb_ok cb_ok
tab_1 tab_1
end type
global w_job_information w_job_information

type variables
String       i_s_workorder

Integer     i_i_x, &
                i_i_width

end variables

event ue_exit;Close(this)
end event

on w_job_information.create
this.cb_save=create cb_save
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.tab_1=create tab_1
this.Control[]={this.cb_save,&
this.cb_cancel,&
this.cb_ok,&
this.tab_1}
end on

on w_job_information.destroy
destroy(this.cb_save)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.tab_1)
end on

event activate;IF gnv_App.of_GetFrame().MenuName <> 'm_job_info_menu' THEN &        
	gnv_App.of_GetFrame().Changemenu ( m_job_info_menu )



end event

event open;i_s_workorder = Message.StringParm

POSTEVENT ( "ue_open" )



 
end event

type cb_save from commandbutton within w_job_information
int X=2560
int Y=1552
int Width=261
int Height=92
int TabOrder=40
string Text="Save"
int TextSize=-12
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;INTEGER		l_i_index

l_i_index	=	tab_1.selectedtab 

IF l_i_index > 0 THEN
	Parent.tab_1.Control[l_i_index].TRIGGEREVENT( "ue_save" )
END IF
end event

type cb_cancel from commandbutton within w_job_information
int X=3017
int Y=1552
int Width=242
int Height=92
int TabOrder=30
string Text="Cancel"
int TextSize=-12
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type cb_ok from commandbutton within w_job_information
int X=2821
int Y=1552
int Width=183
int Height=92
int TabOrder=20
string Text="Ok"
int TextSize=-12
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;INTEGER		l_i_index

l_i_index	=	tab_1.selectedtab 

IF l_i_index > 0 THEN
	Parent.tab_1.Control[l_i_index].TRIGGEREVENT( "ue_save" )
END IF
Close(w_job_information)
end event

event constructor;i_i_width 	= this.width
i_i_x			= this.x
end event

type tab_1 from tab within w_job_information
event create ( )
event destroy ( )
int X=14
int Width=3259
int Height=1532
int TabOrder=10
boolean MultiLine=true
boolean PowerTips=true
Alignment Alignment=Center!
int SelectedTab=1
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpage_info tabpage_info
tabpage_in tabpage_in
tabpage_out tabpage_out
tabpage_process tabpage_process
tabpage_status tabpage_status
tabpage_yield tabpage_yield
tabpage_mps tabpage_mps
tabpage_cost tabpage_cost
end type

on tab_1.create
this.tabpage_info=create tabpage_info
this.tabpage_in=create tabpage_in
this.tabpage_out=create tabpage_out
this.tabpage_process=create tabpage_process
this.tabpage_status=create tabpage_status
this.tabpage_yield=create tabpage_yield
this.tabpage_mps=create tabpage_mps
this.tabpage_cost=create tabpage_cost
this.Control[]={this.tabpage_info,&
this.tabpage_in,&
this.tabpage_out,&
this.tabpage_process,&
this.tabpage_status,&
this.tabpage_yield,&
this.tabpage_mps,&
this.tabpage_cost}
end on

on tab_1.destroy
destroy(this.tabpage_info)
destroy(this.tabpage_in)
destroy(this.tabpage_out)
destroy(this.tabpage_process)
destroy(this.tabpage_status)
destroy(this.tabpage_yield)
destroy(this.tabpage_mps)
destroy(this.tabpage_cost)
end on

event clicked;

end event

event selectionchanged;st_Generic_Structure l_st_parm

CHOOSE CASE newindex
		
	CASE 2
		
//		cb_ok.text	= 'Calc Proj Qty' 
//		cb_ok.width	= i_i_width * 2 
//		cb_ok.x		= i_i_x - 230
//		cb_ok.enabled = TRUE

      cb_save.text	= 'Calc Proj Qty' 
		cb_save.width	= i_i_width * 2.2 
		cb_save.x		= i_i_x - 230
		cb_save.enabled = TRUE
		
		
	CASE 1, 4
		cb_ok.text	= 'Ok' 
		cb_ok.width	= cb_cancel.width
		cb_ok.x		= cb_cancel.x - cb_ok.width - 30
		cb_save.x   = cb_cancel.x - cb_save.width - 280
      cb_save.text	= 'Save' 
		cb_ok.enabled = TRUE
		cb_save.enabled = TRUE
		
	CASE ELSE
		cb_ok.enabled = FALSE
		cb_save.enabled = FALSE


END CHOOSE

l_st_parm.value2	= i_s_workorder
control [ newindex].TRIGGER DYNAMIC EVENT ue_setup ( l_st_parm )
end event

type tabpage_info from u_job_info within tab_1
int X=18
int Y=100
int Width=3223
int Height=1416
boolean Border=false
BorderStyle BorderStyle=StyleBox!
string Text="    Info    "
long TabBackColor=79741120
end type

type tabpage_in from u_job_material_input within tab_1
int X=18
int Y=100
int Width=3223
int Height=1416
boolean Border=false
BorderStyle BorderStyle=StyleBox!
string Text="       In        "
long TabBackColor=79741120
end type

type tabpage_out from u_job_material_output within tab_1
int X=18
int Y=100
int Width=3223
int Height=1416
boolean Border=false
BorderStyle BorderStyle=StyleBox!
string Text="     Out    "
long TabBackColor=79741120
end type

type tabpage_process from u_job_material_process within tab_1
int X=18
int Y=100
int Width=3223
int Height=1416
boolean Border=false
BorderStyle BorderStyle=StyleBox!
string Text="  Process   "
long TabBackColor=79741120
end type

type tabpage_status from u_job_status within tab_1
int X=18
int Y=100
int Width=3223
int Height=1416
boolean Border=false
BorderStyle BorderStyle=StyleBox!
string Text="  Status  "
long TabBackColor=79741120
end type

type tabpage_yield from u_job_yield within tab_1
int X=18
int Y=100
int Width=3223
int Height=1416
boolean Border=false
BorderStyle BorderStyle=StyleBox!
string Text="     Yield     "
long TabBackColor=79741120
end type

type tabpage_mps from u_job_mps within tab_1
int X=18
int Y=100
int Width=3223
int Height=1416
string Text="     MPS    "
long TabBackColor=79741120
end type

type tabpage_cost from u_job_cost within tab_1
int X=18
int Y=100
int Width=3223
int Height=1416
boolean Border=false
BorderStyle BorderStyle=StyleBox!
string Text="    Job Cost     "
long TabBackColor=79741120
end type

